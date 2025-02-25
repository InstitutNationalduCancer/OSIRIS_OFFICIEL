CREATE TABLE Consent (
    PK_ConsentID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_PatientID INT NOT NULL, 
    ConsentDate DATE NOT NULL, 
    AuthorizGenAna BOOLEAN NOT NULL,
    CONSTRAINT Consent_Pkey PRIMARY KEY(PK_ConsentID)
);

CREATE TABLE Patient(
PK_PatientID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
Ext_PatientID Varchar(20) not null, 
OriginCenterID Char(9) not null, 
ProviderCenterID Char(9) not null, 
BirthDate Date not null, 
Gender Varchar(2) not null, 
Ethnicity Varchar(40) not null, 
DeathStatus Boolean not null, 
DeathStatusDate Date not null, 
DeathDate Date, 
DeathCause Varchar(20),
CONSTRAINT Patient_Pkey Primary key(PK_PatientID)
);
  
CREATE TABLE RelatedPathology(
PK_PathologyID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_PatientID int not null, 
PathologyCode Varchar(8) , 
DiagnosisDate Date Not null, 
PathologyEndDate Date ,
CONSTRAINT RelatedPathology_Pkey Primary key(PK_PathologyID)
);
  
CREATE TABLE FamilyCancerHistory(
PK_FamilyCancerHistoID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_PatientID int not null, 
TopographyCode Varchar(8) , 
Parentage varchar(8) ,
CONSTRAINT FamilyCancerHistory_Pkey Primary key(PK_FamilyCancerHistoID)
);
  
CREATE TABLE TNMEvent(
PK_TNMEventID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_TumorPathoEventID int not null, 
FK_PatientID int not null, 
Tvalue Varchar(3) , 
Nvalue Varchar(3) , 
Mvalue Varchar(3) , 
TNMVersion Varchar (20) , 
TNMType Char(1) ,
CONSTRAINT TNMEvent_Pkey Primary key(PK_TNMEventID)
);
  
CREATE TABLE TumorPathoEvent(
PK_TumorPathoEventID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_PatientID int not null, 
StadeType Varchar(30) , 
StadeValue Varchar(30) , 
HistologicalGradeType Varchar(30) , 
HistologicalGradeValue Varchar(30) not null, 
TopographyCode Varchar(10) not null, 
MorphologyCode Varchar(10) not null, 
Laterality Varchar(20) , 
TumEventType Varchar(50) , 
TumEventStartDate Date , 
TumEventDiagDate Date , 
TumEventG8 int , 
TumEventKarnofsky int , 
TumEventOMS int ,
CONSTRAINT TumorPathoEvent_Pkey Primary key(PK_TumorPathoEventID)
);
  
CREATE TABLE Analysis (
    PK_AnalysisID INT GENERATED ALWAYS AS IDENTITY NOT NULL,  -- Ajout d'une clé primaire
    AnalysisType VARCHAR(50), 
    AnalysisDate DATE, 
    AnalysisCode VARCHAR(20),
    CONSTRAINT Analysis_Pkey PRIMARY KEY(PK_AnalysisID)
);

  
CREATE TABLE Treatment (
    PK_TreatmentID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_TumorPathoEventID INT NOT NULL, 
    FK_PatientID INT NOT NULL, 
    TreatmentLine INT, 
    TreatmentType VARCHAR(50), 
    MoleculeCode VARCHAR(7), 
    MoleculeName VARCHAR(50), 
    SurgeryNature VARCHAR(50), 
    SurgeryQualityResection VARCHAR(2), 
    CCAMCode VARCHAR(7), 
    TreatmentStartDate DATE, 
    TreatmentEndDate DATE, 
    ClinicalTrialContext BOOLEAN NOT NULL, 
    ClinicalTrialName VARCHAR(30), 
    ClinicalTrailEudraCTNumber VARCHAR(17),
    CONSTRAINT Treatment_Pkey PRIMARY KEY(PK_TreatmentID)
);

CREATE TABLE ResponseEvaluation(
PK_ResponseEvaluationID INT GENERATED ALWAYS AS IDENTITY not null, 
FK_TreatmentID int not null, 
EvaluationDate Date not null, 
EvaluationStatus Varchar(225) not null,
CONSTRAINT ResponseEvaluation_Pkey Primary key(PK_ResponseEvaluationID)
);
  
CREATE TABLE AdverseEvent (
    PK_AdverseEventID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    FK_PatientID INT NOT NULL, 
    FK_TreatmentID INT NOT NULL, 
    FK_TumorPathoEventID INT NOT NULL, 
    AdverseEventCode INT,
    AdverseEventDate DATE, 
    AdverseEventEndDate DATE, 
    AdverseEventGrade INT,
    CONSTRAINT AdverseEvent_Pkey PRIMARY KEY(PK_AdverseEventID)
);
  
CREATE TABLE Biomarker(
PK_BiomarkerID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_PatientID int not null, 
FK_AnalysisID int not null, 
BiomarkerType Varchar(20) , 
BiomarkerName Varchar(30) , 
BiomarkerValue Varchar(20) , 
BiomarkerUnit Varchar(20) ,
CONSTRAINT Biomarker_Pkey Primary key(PK_BiomarkerID)
);


CREATE TABLE BiologicalSample (
    PK_BioSampleID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_TumorPathoEventID INT NOT NULL, 
    FK_PatientID INT NOT NULL, 
    FK_ConsentID INT NOT NULL, 
    ExternalAccession VARCHAR(50) NOT NULL, 
    ParentExternalAccession VARCHAR(50), 
    CollectDate DATE, 
    SampleOrigin VARCHAR(20), 
    SampleNature VARCHAR(50), 
    TopographyCode INT, 
    StorageTemperature VARCHAR(20), 
    TumorCellularity INT,
    CONSTRAINT BiologicalSample_Pkey PRIMARY KEY(PK_BioSampleID)
);

CREATE TABLE Technology(
PK_TechnologyID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_AnalysisID int not null, 
TechnicalProtocol Varchar(50) not null, 
PlatformAccession Varchar(9) , 
PlatformName Varchar(50) , 
PanelName Varchar(50) , 
AnalyticPipelineCode Varchar(50) not null, 
AlgorithmicCellularity int , 
AlgorithmicPloidy Varchar(50) , 
NumberOfBreakPoints int ,
CONSTRAINT Technology_Pkey Primary key(PK_TechnologyID)
);

CREATE TABLE AlterationOnSample (
    PK_AlterationID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AnalysisID INT NOT NULL, 
    AlterationType VARCHAR(50) NOT NULL, 
    RefGenomeVersion VARCHAR(50) NOT NULL, 
    AlterationChromosome VARCHAR(10) NOT NULL, 
    GenomicStart INT NOT NULL, 
    GenomicStop INT NOT NULL, 
    Cytoband VARCHAR(30),
    CONSTRAINT AlterationOnSample_Pkey PRIMARY KEY(PK_AlterationID)
);

CREATE TABLE Variant(
PK_VariantID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_AnalysisID int not null, 
FK_AlterationID int not null, 
Type Varchar(50) not null, 
CellType Varchar(10) not null, 
Zygosity Varchar(10) , 
VariantReferenceAllele Varchar(255) not null, 
VariantAlternativeAllele Varchar(255) not null, 
VariantInsampleDepth int not null, 
VariantAlternativeAlleleDepth int not null, 
VariantInSampleStrandBias Boolean ,
CONSTRAINT Variant_Pkey Primary key(PK_VariantID)
);

CREATE TABLE CopyNumber (
    PK_CopyNumberID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AnalysisID INT NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    CNVSegmentGenomicStatus VARCHAR(50) NOT NULL, 
    CNVAlterationCopyNumber INT, 
    CNVSegmentIntensity FLOAT NOT NULL, 
    CNVLOH BOOLEAN,
    CONSTRAINT CopyNumber_Pkey PRIMARY KEY(PK_CopyNumberID)
);


CREATE TABLE Expression(
PK_ExpressionID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_AnalysisID int not null, 
FK_AlterationID int not null, 
GeneExpressionDataType Varchar(50) not null, 
GeneExpressionValue float not null,
CONSTRAINT Expression_Pkey Primary key(PK_ExpressionID)
);

CREATE TABLE Fusion(
PK_FusionID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_AnalysisID int not null, 
FK_AlterationID int not null, 
FusionType Varchar(50) , 
GeneName5 Varchar(50) not null, 
GeneRegion5 Varchar(255) , 
TranscrIdentifier5 Varchar(50) not null, 
DNAstrand5 Varchar(50) not null, 
GenPosition3 int not null, 
GeneName3 Varchar(50) not null, 
GeneRegion3 Varchar(255) , 
TranscrIdentifier3 Varchar(50) not null, 
DNAstrand3 Varchar(50) not null, 
Position3 int not null, 
FusionInFrame boolean , 
FusionDepth int not null, 
DepthOfFusionPoint int not null,
CONSTRAINT Fusion_Pkey Primary key(PK_FusionID)
);

CREATE TABLE MolecularAnnotation (
    PK_AnnotationMolecularID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    GenomeEntityType VARCHAR(50) NOT NULL, 
    GenomeEntityDatabase VARCHAR(50) NOT NULL, 
    GenomeEntityID VARCHAR(50) NOT NULL, 
    GenomeEntitySymbol VARCHAR(50),
    CONSTRAINT MolecularAnnotation_Pkey PRIMARY KEY(PK_AnnotationMolecularID)
);


CREATE TABLE GenomicAnnotation (
    PK_AnnotationGenomicID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    GenomeBaseName VARCHAR(50) NOT NULL, 
    GeneIdentifier VARCHAR(50) NOT NULL, 
    GeneRegion VARCHAR(50), 
    GenomicImpact VARCHAR(100), 
    ImpactOnGeneCodingRegion VARCHAR(100),
    CONSTRAINT GenomicAnnotation_Pkey PRIMARY KEY(PK_AnnotationGenomicID)
);


CREATE TABLE TranscriptomicAnnotation (
    PK_AnnotationTranscriptomicID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    AnnotationTranscriptomicDBName VARCHAR(50) NOT NULL, 
    AnnotationGeneIdentifier VARCHAR(50) NOT NULL, 
    AnnotationTranscriptImpact VARCHAR(100),
    CONSTRAINT TranscriptomicAnnotation_Pkey PRIMARY KEY(PK_AnnotationTranscriptomicID)
);


CREATE TABLE ProteomicAnnotation (
    PK_AnnotationProteomicID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    AnnotationProteinDBName VARCHAR(50) NOT NULL, 
    AnnotationProteinIdentifier VARCHAR(50) NOT NULL, 
    AnnotationProteinImpact VARCHAR(100), 
    AnnotationPFAMIdentifier VARCHAR(50), 
    AnnotationPFAMDomainName VARCHAR(100),
    CONSTRAINT ProteomicAnnotation_Pkey PRIMARY KEY(PK_AnnotationProteomicID)
);


CREATE TABLE Validation(
PK_ValidationID INT GENERATED ALWAYS AS IDENTITY not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_AlterationID int not null, 
ValidationType Varchar(50) not null, 
ValidationMethod Varchar(50) not null, 
ValidationStatus Varchar(50) ,
CONSTRAINT Validation_Pkey Primary key(PK_ValidationID)
);

CREATE TABLE MolecularRCP (
    PK_MolecularRCPID INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_AlterationID INT NOT NULL, 
    PredictionSoftware VARCHAR(50), 
    SoftwareConfidenceScore FLOAT, 
    AlterationOnSamplePathogenicity VARCHAR(50), 
    AlterationOnSampleProposedForOrientation VARCHAR(50), 
    AlterationOnSampleActionability BOOLEAN,
    CONSTRAINT MolecularRCP_Pkey PRIMARY KEY(PK_MolecularRCPID)
);

CREATE TABLE Course(
PK_Course_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
CourseType varchar(50) not null, 
CourseObjective varchar(50) , 
CourseEndReason Integer , 
CourseNbSessions Integer , 
CourseStartDate Date not null, 
CourseEndDate Date not null,
CONSTRAINT Course_Pkey Primary key(PK_Course_ID)
);

CREATE TABLE Phase(
PK_Phase_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Course_ID int not null, 
PhaseType varchar(100) NOT NULL, 
PhaseNbFractions int NOT NULL, 
PhaseStartDate Date NOT NULL, 
PhaseEndDate Date NOT NULL,
CONSTRAINT Phase_Pkey Primary key(PK_Phase_ID)
);

CREATE TABLE Plan(
PK_Plan_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Phase_ID int not null, 
FK_Series_ID int not null, 
FK_ROI_Segmentation_ID int not null, 
PlanType varchar(50) NOT NULL, 
NbOfFractions int NOT NULL, 
PlanStartDate Date NOT NULL, 
PlanEndDate Date NOT NULL, 
PlanReschedulReason Integer Not null, 
PlanAlgoName varchar(100) NOT NULL, 
UIDimage varchar(100) , 
UIDRTSS varchar(100) , 
UIDRTdose varchar(100) , 
UIDRTplan varchar(100) NOT NULL,
CONSTRAINT Plan_Pkey Primary key(PK_Plan_ID)
);

CREATE TABLE ROI_Volume(
PK_ROI_Vol_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Dose_to_Vol_ID int not null, 
ROIidentifier varchar(100) NOT NULL, 
ROIlocation Integer NOT NULL, 
ROIlocationCodes Integer , 
ROIdescription varchar(255) ,
CONSTRAINT ROI_Volume_Pkey Primary key(PK_ROI_Vol_ID)
);

CREATE TABLE Dose_To_Volume(
PK_DoseToVol_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Plan_ID int not null, 
ScheduledDosePerFraction varchar(15) NOT NULL, 
DoseNbFractions integer NOT NULL, 
TotalDosis decimal NOT NULL,
CONSTRAINT Dose_To_Volume_Pkey Primary key(PK_DoseToVol_ID)
);

CREATE TABLE Modality_and_Tech(
PK_Modal_Tech_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Plan_ID int not null, 
Technique varchar(50) NOT NULL, 
Modality varchar(10) NOT NULL, 
BeamEmissEquip varchar(50) ,
CONSTRAINT Modality_and_Tech_Pkey Primary key(PK_Modal_Tech_ID)
);

CREATE TABLE Energy_Isotope(
PK_Energy_Isotope_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Plan_ID int not null, 
EI_Quantity decimal NOT NULL, 
IsotopeName varchar(50) ,
CONSTRAINT Energy_Isotope_Pkey Primary key(PK_Energy_Isotope_ID)
);

CREATE TABLE Study(
PK_Study_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Analysis_ID int not null, 
StudyUniqueNumber varchar(50) not null, 
StudyDescription varchar(50) NOT NULL, 
StudyAcquisitTime Date NOT NULL, 
StudyStorageLocation varchar(50) NOT NULL, 
StudyInstitutionName varchar(50) , 
StudyModalities varchar(50) NOT NULL, 
StudyNbSeries Int NOT NULL,
CONSTRAINT Study_Pkey Primary key(PK_Study_ID)
);

CREATE TABLE Equipment(
PK_Equipment_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
EquiptManufacturer varchar(50) NOT NULL, 
EquiptModelName varchar(50) NOT NULL, 
EquiptSoftwareVersion varchar(50) NOT NULL,
CONSTRAINT Equipment_Pkey Primary key(PK_Equipment_ID)
);

CREATE TABLE Series(
PK_Series_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Equipment_ID int not null, 
FK_Injection_ID int NOT NULL, 
FK_Study_ID int NOT NULL, 
SeriesUserNumber varchar(20) , 
SeriesUniqueReferenceNumber varchar(100) NOT NULL, 
SeriesModality varchar(20) NOT NULL, 
SeriesDescription varchar(255) NOT NULL, 
SeriesBodyPartExamined varchar(50) , 
SeriesNumberofimagesinseries Int NOT NULL, 
SeriesAcquisitiontime Date NOT NULL, 
SeriesPatientweight int , 
SeriesPatientsize int ,
CONSTRAINT Series_Pkey Primary key(PK_Series_ID)
);

CREATE TABLE Injection(
PK_Injection_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
InjectProductName varchar(20) , 
InjectContrastAgent varchar(50) , 
InjectionStartTime Date , 
InjectEndTime Date , 
ActualInjectionTime Date , 
InjectRadiopharmDose Int ,
CONSTRAINT Injection_Pkey Primary key(PK_Injection_ID)
);


CREATE TABLE Common_Image(
PK_Common_Image_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Series_ID int not null, 
UniqueNumber varchar(50) NOT NULL, 
CutThickness varchar(20) NOT NULL, 
PixelSpacing varchar(20) NOT NULL, 
FieldOfVision Int , 
NbPixelsDirLine Int NOT NULL, 
NbPixelsDirColumn Int NOT NULL,
CONSTRAINT Common_Image_Pkey Primary key(PK_Common_Image_ID)
);

CREATE TABLE MR_Image(
PK_MR_Image_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Common_ImageID int not null, 
PulseSequType varchar(50) NOT NULL, 
NominalFieldStrenght varchar(20) NOT NULL, 
DescriptionOfAcquisType varchar(20) NOT NULL, 
RepetitionTime varchar(20) NOT NULL, 
EchoTime varchar(20) NOT NULL, 
PrecessionFrequency varchar(20) NOT NULL, 
TiltAngle varchar(50) NOT NULL, 
PeriodFromMidRFInversion varchar(20) NOT NULL, 
ReceivingAntenna varchar(20) NOT NULL,
CONSTRAINT MR_Image_Pkey Primary key(PK_MR_Image_ID)
);

CREATE TABLE CT_Image(
PK_CT_Image_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Common_ImageID int not null, 
PeakKilovoltage varchar(20) , 
XrayTubeCurrent varchar(20) NOT NULL, 
XrayExposureTime varchar(20) NOT NULL, 
SpiralPitch varchar(20) NOT NULL, 
FilterType varchar(50) NOT NULL, 
ConvolutionKernel varchar(50) NOT NULL,
CONSTRAINT CT_Image_Pkey Primary key(PK_CT_Image_ID)
);

CREATE TABLE NM_PT_Image(
PK_NM_PT_Image_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Common_ImageID int not null, 
AttenuationCorrectionMethod varchar(50) NOT NULL, 
ReconstructionMethod varchar(50) NOT NULL, 
AttenuationSorrectionScatering varchar(50) NOT NULL,
CONSTRAINT NM_PT_Image_Pkey Primary key(PK_NM_PT_Image_ID)
);

CREATE TABLE DX_Image(
PK_DX_Image_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Common_ImageID int not null, 
LateralityOfBodyPart varchar(20) NOT NULL, 
PatientOrientation varchar(20) , 
KilovoltagePeak varchar(20) NOT NULL, 
Exposure varchar(20) NOT NULL, 
DurationOfExposure varchar(20) NOT NULL,
CONSTRAINT DX_Image_Pkey Primary key(PK_DX_Image_ID)
);

CREATE TABLE ROI_Segment(
PK_ROI_Segmentation_ID int not null, 
TK_LoadProcID int not null, 
TD_CreationDate Timestamp not null, 
TD_UpdateDate Timestamp not null, 
FK_Series_ID int not null, 
UniqueDICOMIdentifier varchar(20) NOT NULL, 
UniqueROIIdentifier varchar(100) NOT NULL, 
UserDefinedNameforROI varchar(50) NOT NULL, 
UserDefinedDescriptionforROI varchar(50) , 
ROI_Type varchar(20) NOT NULL, 
ROISegm_FileID varchar(100) NOT NULL,
CONSTRAINT ROI_Segment_Pkey Primary key(PK_ROI_Segmentation_ID)
);


CREATE TABLE Radiom_Criter (
    PK_RadiomicsCriteria_ID INT NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_ROI_Segmentation_ID INT NOT NULL, 
    FK_RadiomImageFilter_ID INT NOT NULL, 
    Filter_SoftwareName VARCHAR(100) NOT NULL, 
    Filter_SoftwareVersion VARCHAR(20) NOT NULL, 
    CalculMethodLoc VARCHAR(50) NOT NULL, 
    CalculWindows VARCHAR(50) NOT NULL, 
    FilterMethodBeforeCalc VARCHAR(50) NOT NULL, 
    MethodParam VARCHAR(50) NOT NULL, 
    DistanceWeight VARCHAR(20) NOT NULL, 
    ResampIntensMethod VARCHAR(50) NOT NULL, 
    Nb_SizeOfBins DECIMAL(10, 2) NOT NULL, 
    RadiomCriterTerminal VARCHAR(50) NOT NULL, 
    LowestDiscrIntensOf1stBin DECIMAL(10, 2) NOT NULL, 
    HighestDiscrIntensOf1stBin DECIMAL(10, 2) NOT NULL, 
    LimitIntensAfterDiscr VARCHAR(10) NOT NULL, 
    SpatialResampMethod VARCHAR(50) NOT NULL, 
    SpatialResampValue VARCHAR(50) NOT NULL, 
    BiomarkDescCalc VARCHAR(255) NOT NULL,
    CONSTRAINT Radiom_Criter_Pkey PRIMARY KEY(PK_RadiomicsCriteria_ID)
);



CREATE TABLE Radiom_Image_Filter (
    PK_RadiomImageFilter_ID INT NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_Common_ImageID INT NOT NULL, 
    RIFSoftwareName VARCHAR(100) NOT NULL, 
    RIFSoftwareVersion VARCHAR(20) NOT NULL, 
    RIFMethod VARCHAR(50) NOT NULL, 
    RIFType VARCHAR(50), 
    RIFInterpolType VARCHAR(50), 
    RIFFractionalUnit VARCHAR(50), 
    RIFLimitCondition VARCHAR(50),
    CONSTRAINT Radiom_Image_Filter_Pkey PRIMARY KEY(PK_RadiomImageFilter_ID)
);

CREATE TABLE Radiom_Feature (
    PK_RadiomFeature_ID INT NOT NULL, 
    TK_LoadProcID INT NOT NULL, 
    TD_CreationDate TIMESTAMP NOT NULL, 
    TD_UpdateDate TIMESTAMP NOT NULL, 
    FK_RadiomicsCriteria_ID INT NOT NULL, 
    UniqueNumber VARCHAR(50) NOT NULL, 
    RadiomicsFeatureName VARCHAR(50) NOT NULL, 
    RadiomicsFeatureValue DECIMAL NOT NULL,
    CONSTRAINT Radiom_Feature_Pkey PRIMARY KEY(PK_RadiomFeature_ID)
);

