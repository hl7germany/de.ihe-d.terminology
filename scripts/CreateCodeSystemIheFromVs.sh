#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

exit_with_message () {
  echo $1 >&2
  exit 1
}

encapsulate_after_colon() {
    local original_string="$1"

    after_colon="${original_string#*:}"
    if [[ "$after_colon" =~ ^[[:space:]]*$ ]]; then
        echo $1
    else
        result="$(echo -e "${after_colon}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        result=$(escape_double_quotes "$result")
        result="${original_string%%:*}: \"${result}\""
        echo "$result"
    fi
}

escape_double_quotes() {
    result=$(echo "$1" | sed 's/"/\\"/g')
    echo $result
}

# Check dependencies

for dependency in "fhir" "yq" "jq"
do
    if ! [ -x "$(command -v $dependency)" ]; then
        exit_with_message "$dependency is not installed."
    fi
done

# Check and print arguments

if [ $# -eq 0 ] || [ $# -ne 3 ];
  then
    exit_with_message "You need to provide following arguments: (1) the canonical of the IHE ValueSet that needs to be transformed (2) absolute local path to folder in which the IHE ValueSets are stored (3) absolute local path to folder in which the IHE CodeSystem shall be stored"
fi

echo "IHE ValueSet canonical: '$1'"
echo "Path to IHE ValueSets: '$2'"
echo "Path to IHE CodeSystems: '$3'"

# Resolve ValueSet

if [ ! -d "$2" ]; then
  exit_with_message "Directory '$2' does not exist."
fi

cd "$2"
fhir restore
fhir clear
fhir resolve $1

# Extract CS canonicals

declare -a canonicalNodes

composeIncludeSystemOutput=$(fhir select compose.include.system --output Tree)
while IFS= read -r line; do
    if [ -n "$line" ]; then
        current_item+="$line "
    else
        canonicalNodes+=("$current_item")
        current_item=""
    fi
done <<< "$composeIncludeSystemOutput"
if [ -n "$current_item" ]; then
    canonicalNodes+=("$current_item")
fi
current_item=""

# Start building CS...
for canonicalNode in "${canonicalNodes[@]}"; do
    canonical=$(echo "$canonicalNode" | yq '.system' - )

    if [[ ! "$canonical" == "http://ihe-d.de/"* ]]; then
        echo "Skipping CS canonical '$canonical' ..."
        continue
    fi

    echo "Building CodeSystem for canonical '$canonical' ..."

    cs=$(jq -n '{}') # Start with empty JSON document

    # Add metadata

    #cs=$(echo "$cs" | jq ".meta += {\"profile\": [\"http://hl7.org/fhir/StructureDefinition/shareablecodesystem\"]}")
    cs=$(echo "$cs" | jq ".url = \"$canonical\"")
    cs=$(echo "$cs" | jq ".version = \"$(fhir select version)\"")
    name=${canonical##*/}
    cs=$(echo "$cs" | jq ".name = \"$name\"")
    cs=$(echo "$cs" | jq ".id = \"$name\"")
    title=$(echo "$name" | sed 's/\([A-Z]\)/ \1/g')
    cs=$(echo "$cs" | jq ".title = \"$title\"")
    cs=$(echo "$cs" | jq ".status = \"$(fhir select status)\"")
    experimental=$(fhir select experimental)
    experimental=$(echo "$experimental" | tr '[:upper:]' '[:lower:]')
    cs=$(echo "$cs" | jq ".experimental = $experimental")
    cs=$(echo "$cs" | jq ".publisher = \"$(fhir select publisher)\"")
    cs=$(echo "$cs" | jq ".caseSensitive = true")
    cs=$(echo "$cs" | jq ".content = \"complete\"")

    # Select concepts
    declare -a conceptNodes=()

    conceptOutput=$(fhir select compose.include.where\(system=\'$canonical\'\).concept --output Tree)
    while IFS= read -r line; do
    if [ -z "$line" ]; then
        conceptNodes+=("$current_item")
        current_item=""
    else
        line=$(encapsulate_after_colon "$line")
        current_item+="$line"$'\n'
    fi
    done <<< "$conceptOutput"
    if [ -n "$current_item" ]; then
        conceptNodes+=("$current_item")
    fi

    count=0
    for conceptNode in "${conceptNodes[@]}"; do
        #echo "$conceptNode"
        code=$(echo "$conceptNode" | yq '.concept.code' -)
        display=$(echo "$conceptNode" | yq '.concept.display' -)
        definition=$(echo "$conceptNode" | yq '.concept.extension | ."value[string]"' -)
        definition=$(escape_double_quotes "$definition")

        if [[ "$definition" == *"null"* ]]; then
            cs=$(echo "$cs" | jq ".concept += [{\"code\": \""$code\"", \"display\": \""$display\""}]")
        else
        cs=$(echo "$cs" | jq ".concept += [{\"code\": \""$code\"", \"display\": \""$display\"", \"definition\": \""$definition\""}]")
        fi

        ((count++))
    done

    cs=$(echo "$cs" | jq ".count = $count")
    
    echo "$cs" > $3/"CodeSystem-$name".json
    cs=""

done