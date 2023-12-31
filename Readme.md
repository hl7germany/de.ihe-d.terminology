# de.ihe-d.terminology

Das vorliegende Projekt enthält einen Export von ValueSet herausgegeben durch IHE Deutschland e.V.
Diese werden maßgebend definiert durch folgendes ArtDecor Projekt: https://art-decor.org/art-decor/decor-valuesets--ihede-

Weitere Infos siehe [XDS ValueSets für Deutschland](https://www.ihe-d.de/projekte/xds-value-sets-fuer-deutschland/) und [Value Sets für XDS - HL7 DE Wiki](https://wiki.hl7.de/index.php?title=IG:Value_Sets_für_XDS).

Publiziert werden die Terminologieressourcen in dem FHIR-Package "de.ihe-d.terminology".

# Versionen

Die oben genannten ValueSets liegen in folgenden Versionen vor:

* Version 1.0.0 - Final - 10.11.2016
  * [PDF](https://www.ihe-d.de/wp-content/uploads/2020/09/XDS_Value_Sets1.pdf)
  * [GitHub](https://github.com/hl7germany/de.ihe-d.terminology/tree/v1.0) 
* Version 2.0.0 - Final - 09.10.2018
  * [PDF](https://www.ihe-d.de/wp-content/uploads/2020/09/ValueSets2_0.pdf)
  * [GitHub](https://github.com/hl7germany/de.ihe-d.terminology/tree/v2.0)  
* Version 3.0.0 - Final - 09.07.2021
  * [PDF](https://www.ihe-d.de/wp-content/uploads/2021/07/XDSValueSetsDv3.pdf)
  * [GitHub](https://github.com/hl7germany/de.ihe-d.terminology/tree/v3.0) 

Es ist zu beachten, dass Zwischenversionen die nicht als "final" gekennzeichnet wurden, nicht publiziert werden.

Der ["live"-Ordner](https://github.com/hl7germany/de.ihe-d.terminology/tree/master/terminologie/ValueSets/live) spiegelt immer die aktuelle Arbeitsversion wieder.

# ValueSets

Folgende Value Sets werden in Version 3.0 offiziell bereitgestellt:

* DocumentEntry.classCode
  * Name: IHEXDSclassCode
  * OID: 1.2.276.0.76.11.32
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSclassCode
* DocumentEntry.typeCode
  * Name: IHEXDStypeCode
  * OID: 1.2.276.0.76.11.38
  * Canonical: http://ihe-d.de/ValueSets/IHEXDStypeCode
* DocumentEntry.healthcareFacilityTypeCode
  * Name: IHEXDShealthcareFacilityTypeCode
  * OID: 1.2.276.0.76.11.36
  * Canonical: http://ihe-d.de/ValueSets/IHEXDShealthcareFacilityTypeCode
* DocumentEntry.practiceSettingCode
  * Name: IHEXDSpracticeSettingCode
  * OID: 1.2.276.0.76.11.37
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSpracticeSettingCode
* DocumentEntry.formatCode
  * Name: IHEXDSformatCodeDE
  * OID: 1.2.276.0.76.11.35
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSformatCodeDE
* DocumentEntry.authorRole
  * Name: IHEXDSauthorRole
  * OID: 1.2.276.0.76.11.30
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSauthorRole
* DocumentEntry.authorSpecialty
  * Name: IHEXDSauthorSpeciality
  * OID: 1.2.276.0.76.11.31
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSauthorSpeciality
* DocumentEntry.confidentialityCode
  * Name: IHEXDSconfidentialityCode
  * OID: 1.2.276.0.76.11.33
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSconfidentialityCode
* DocumentEntry.eventCodeList
  * Name: IHEXDSeventCodeList
  * OID: 1.2.276.0.76.11.34
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSeventCodeList
* DocumentEntry.languageCode
  * Name: n/A
  * OID: n/A
  * Canonical: n/A
* Folder.codeList
  * Name: IHEXDScodeList
  * OID: 1.2.276.0.76.11.40
  * Canonical: http://ihe-d.de/ValueSets/IHEXDScodeList
* SubmissionSet.contentTypeCode
  * Name: IHEXDScontentTypeCode
  * OID: 1.2.276.0.76.11.39
  * Canonical: http://ihe-d.de/ValueSets/IHEXDScontentTypeCode

Weitere informell veröffentliche ValueSets in Version 3.0:

* Name: IHEXDSpracticeSettingCodeNonDoctoral
  * OID: 1.2.276.0.76.11.70
  * Canonical: http://ihe-d.de/ValueSets/IHEXDSpracticeSettingCodeNonDoctoral
* Name: IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
  * OID: 1.2.276.0.76.11.58
  * Canonical: http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.58--20180713162142
* Name: IHEXDShealthcareFacilityTypeCodeOutsidePatientReleatedHealthcare
  * OID: 1.2.276.0.76.11.59
  * Canonical: http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.59--20180713162125
* Name: IHEXDSpracticeSettingCodedoctoral
  * OID: 1.2.276.0.76.11.69
  * Canonical: http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.69--20190405083559
* Name: IHEXDSformatCodeINTL
  * OID: 1.2.276.0.76.11.71
  * Canonical: http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.71--20210706212636

# Offene Probleme

* IHEXDSpracticeSettingCode:
  * Inkludiert ValueSet mit Canonical "http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.69--20190405083559". Canonical "http://ihe-d.de/ValueSets/IHEXDSpracticeSettingCodeDoctoral" sollte inkludiert werden.
  
* IHEXDShealthcareFacilityTypeCode:
  * Inkludiert ValueSets mit den Canoncials "http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.58--20180713162142" und "http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.59--20180713162125". Canonicals "http://ihe-d.de/ValueSets/IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare" und "http://ihe-d.de/ValueSets/IHEXDShealthcareFacilityTypeCodeOutsidePatientRelatedHealthcare" sollten inkludiert werden.

* IHEXDSformatCodeDE:
  * Inkludiert ValueSet mit Canonical "http://art-decor.org/fhir/ValueSet/1.2.276.0.76.11.71--20180713170639". Canonical "http://ihe-d.de/ValueSets/IHEXDSformatCodeINTL" sollte anstelle dessen inkludiert werden.

* IHEXDSeventCodeList:
  * urn:oid:1.2.840.10008.6.1.19 ist als Canonical URL nicht offiziell durch IHE Int. vergeben. Sollte getauscht werden mit "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_29.html". Zudem bezieht sich die Canonical auf ein ValueSet kein CodeSystem, daher ist der Include per ValueSet.compose.include.valueSet anzugeben.
  * 1.2.840.10008.6.1.2 ist als Canonical URL nicht offiziell durch IHE Int. vergeben. Sollte getauscht werden mit "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4.html". Zudem bezieht sich die Canonical auf ein ValueSet kein CodeSystem, daher ist der Include per ValueSet.compose.include.valueSet anzugeben.
  * Das ValueSet mit der Canonical "urn:oid:1.2.276.0.76.11.469" ist formal nicht definitert. Zudem bezieht sich die Canonical auf ein ValueSet kein CodeSystem, daher ist der Include per ValueSet.compose.include.valueSet anzugeben.
