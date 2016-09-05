{@name is used to define @link(TCustomModflowWriter) which is an abstract
 base class for writing MODFLOW input files.

@author(Richard B. Winston <rbwinst@usgs.gov>)}
unit CustomModflowWriterUnit;

interface

uses Windows, Types, LayerStructureUnit, ModflowTimeUnit, FluxObservationUnit,
  SysUtils, Classes, Contnrs, Forms, RbwParser, AbstractGridUnit,
  SubscriptionUnit, GoPhastTypes, DataSetUnit, PhastModelUnit, ModflowCellUnit,
  ModflowOutputControlUnit, ScreenObjectUnit, ModflowBoundaryUnit,
  ModflowPackageSelectionUnit, ModflowTransientListParameterUnit,
  OrderedCollectionUnit, ModflowBoundaryDisplayUnit, ModflowParameterUnit,
  System.Generics.Collections;

type
  // @name indicates whether the file in the name file is an input file
  // and output file or undetermined.
  TFileOption = (foNone, foInput, foOutput, foInputAlreadyExists);

  TModflowArrayType = (matStructured, matUnstructured, mat1D);

  {@name is used in @link(TCustomModflowWriter.CheckArray)
   @value(cvmGreater If the value in the array is greater than
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
   @value(cvmGreaterEqual If the value in the array is greater than or equal to
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
   @value(cvmEqual If the value in the array is equal to
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
   @value(cvmNotEqual If the value in the array is not equal to
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
   @value(cvmLessThan If the value in the array is less than
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
   @value(cvmLessThanEqual If the value in the array is less than or equal to
     CheckValue in @link(TCustomModflowWriter.CheckArray),
     the value in the array is OK.)
  }
  TCheckValueMethod = (cvmGreater, cvmGreaterEqual, cvmEqual,
    cvmNotEqual, cvmLessThan, cvmLessThanEqual, cvmGradient);

  {@name is used in @link(TCustomModflowWriter.CheckArray) to specify
    whether cases that don't pass the check should be treated as errors or
    warnings.
    @value(etError If something doesn't pass the check, it should be treated
      as an error.)
    @value(etWarning If something doesn't pass the check, it should be treated
      as a warning.)
      }
  TErrorType = (etError, etWarning);
  TArrayWritingFormat = (awfModflow, awfMt3dms, awfModflow_6);

  TCustomFileWriter = class(TObject)
  strict private
    // name is the file that is created by @classname.
    FFileStream: TFileStream;
  private
    // See @link(Model).
    FModel: TCustomModel;
  protected
    FEvaluationType: TEvaluationType;
    // @name closes the file that is being exported.
    // @seealso(OpenFile)
    procedure CloseFile;
    // @name opens the input file to be exported.
    // @seealso(CloseFile)
    procedure OpenFile(const FileName: string);
    // @name generates a comment line for a MODFLOW input file indentifying
    // the file type
    function File_Comment(const FileID: string): string;
    // @name writes a comment line to the output file.
    procedure WriteCommentLine(const Comment: string);
    // @name returns the extension (including the initial period) for the
    // MODFLOW input file to be exported.
    class function Extension: string; virtual; abstract;
  public
    // @name converts AFileName to use the correct extension for the file.
    class function FileName(const AFileName: string): string;
    {@name is the model to be exported.}
    property Model: TCustomModel read FModel;
    // the period as the decimal separator.
    class Function FortranDecimal(NumberString : string) : string;
    // @name converts "Value" to an string padded at the beginning with blank
    // characters so that the resulting string as a length of "Width".
    class function FixedFormattedInteger(const Value, Width: integer): string;
    // @name converts "Value" to an string padded at the beginning with blank
    // characters so that the resulting string as a length of "Width".
    class function FixedFormattedReal(const Value : double;
      const Width : integer) : string;
    // @name converts "Value" to a string.  The decimal separator will
    // always be a period.
    class function FreeFormattedReal(const Value : double) : string;
    // @name creates and instance of @classname.
    // @param(Model is the @link(TCustomModel) to be exported.)
    Constructor Create(AModel: TCustomModel; EvaluationType: TEvaluationType); virtual;
    // @name writes an end of line to the output file.
    procedure NewLine; virtual;
    // @name writes Value to the output with a leading blank space.
    procedure WriteFloat(const Value: double);
    procedure WriteFloatCondensed(const Value: double);
    procedure WriteF10Float(const Value: double);
    // @name writes Value to the output with a leading blank space.
    procedure WriteInteger(Const Value: integer);
    // @name writes Value to the output in I10 format.
    procedure WriteI10Integer(Const Value: integer; const ErrorID: string);
    // @name writes Value to the output in I2 format.
    procedure WriteI2Integer(Const Value: integer; const ErrorID: string);
    // @name writes Value to the output with NO leading blank space.
    procedure WriteString(const Value: String); overload;
    procedure WriteString(const Value: AnsiString); overload; virtual;
  end;

  { @name is an abstract base class used as an ancestor for classes that
    write MODFLOW input files.
  }
  TCustomModflowWriter = class(TCustomFileWriter)
  private

    // @name writes a header for DataArray using either
    // @link(WriteConstantU2DINT) or @link(WriteU2DRELHeader).
    procedure WriteHeader(const DataArray: TDataArray;
      const Comment: string; const MF6_ArrayName: string);
    function CheckArrayUniform(const LayerIndex: Integer;
      const DataArray: TDataArray): boolean;
    procedure WriteArrayValues(const LayerIndex: Integer;
      const DataArray: TDataArray);
  protected
    FArrayWritingFormat: TArrayWritingFormat;

    // @name generates a comment line for a MODFLOW input file indentifying
    // the package.
    function PackageID_Comment(APackage: TModflowPackageSelection): string; virtual;
    // @name writes Lines as comments.
    procedure WriteCommentLines(const Lines: TStrings);
    // @name returns the proper IPRN for specifying whether to print an
    // integer input array
    function IPRN_Integer: integer;
    function IPRN_Mt3dms_Integer: integer;
    // @name returns the proper IPRN for specifying whether to print an
    // real number input array
    function IPRN_Real: integer;
    function IPRN_Mt3dms_Real: integer;
    // @name retrieves the proper unit number for the cell-by-cell flow
    // file.
    procedure GetFlowUnitNumber(var UnitNumber: Integer); virtual;
    // @name writes a U2DREL array based on the contents of List.
    //  List is sometimes a @link(TValueCellList)
    // or a list of list of @link(TValueCellList)
    // or a TList.
    // DataTypeIndex indicates which parameter of the @link(TValueCell)
    // to use.
    // DataType indicates what sort of information in the TList.
    // DefaultValue indicates the proper default parameter for the gridded data.
    // If FreeArray is @true, TransientArray will be set to nil.
    // If FreeArray is @false, TransientArray will be set
    // to the @link(TDataArray) that was exported and it will be the caller's
    // responsibility to free TransientArray
    procedure WriteTransient2DArray(const Comment: string;
      DataTypeIndex: Integer; DataType: TRbwDataType; DefaultValue: Double;
      List: TList; AssignmentMethod: TUpdateMethod; AdjustForLGR: boolean;
      var TransientArray: TDataArray; const MF6_ArrayName: string;
      FreeArray: boolean = True);
    procedure WriteMf6_DataSet(DataArray: TDataArray; const ID: string);
    procedure WriteSaveFlowsOption;
    procedure WritePrintFlowsOption;
    procedure WriteBeginOptions;
    procedure WriteEndOptions;
    procedure PrintListInputOption;
    function ShouldCheckCell(LayerIndex, RowIndex, ColIndex: Integer): Boolean; virtual;
  public
    // @name converts AFileName to use the correct extension for the file.
//    class function FileName(const AFileName: string): string;

    // @name converts a real number represented as a string to always use
    property ArrayWritingFormat: TArrayWritingFormat read FArrayWritingFormat;
    {@name checks that the values stored in DataArray are valid.
    @name returns @true if no error is found.
    @param(DataArray is the @link(TDataArray) to be checked.)
    @param(LayerIndex is the layer (first index) in DataArray to be checked.)
    @param(ErrorOrWarningMessage is the message to be displayed to the
      user if the check fails.)
    @param(CheckMethod indicates how the data in DataArray will be checked.)
    @param(CheckValue is the value against which the data in DataArray
      will be checked.)
    @param(ErrorType indicates whether problems discovered in @name should be
      considered errors or warnings.)
    }
    function CheckArray(const DataArray: TDataArray; const LayerIndex: integer;
      const ErrorOrWarningMessage: string; CheckMethod: TCheckValueMethod;
      CheckValue: double; ErrorType: TErrorType): boolean;
    // @name creates and instance of @classname.
    // @param(Model is the @link(TCustomModel) to be exported.)
    Constructor Create(AModel: TCustomModel; EvaluationType: TEvaluationType); override;
    { @name writes one layer of DataArray to the output file.
      @param(DataArray is the TDataArray to be written.)
      @param(LayerIndex is the layer in DataArray to be written.)
      @param(ArrayName is written as a comment
        identifying the data set being written.)
    }
    procedure WriteArray(const DataArray: TDataArray; const LayerIndex: integer;
      const Comment: string;  NoValueAssignedAnnotation: string; const MF6_Arrayname: string;
      CacheArray: Boolean = True);
    // @name writes value to the output file using the U2DINT format in MODFLOW
    // or the IARRAY array reader in MT3DMS depending on the value of
    // @link(FArrayWritingFormat)
    // for cases when the array is a constant.
    procedure WriteConstantU2DINT(const Comment: string;
      const Value: integer; ArrayType: TModflowArrayType;
      const MF6_ArrayName: string); virtual;
    // @name writes value to the output file using the U2DREL format in MODFLOW
    // or the RARRAY array reader in MT3DMS depending on the value of
    // @link(FArrayWritingFormat)
    // for cases when the array is a constant.
    procedure WriteConstantU2DREL(const Comment: string;
      const Value: double; ArrayType: TModflowArrayType;
      const MF6_ArrayName: string); virtual;
    // @name writes DataArray in cross section format.
    procedure WriteCrossSectionArray(const DataArray: TDataArray;
      const Comment: string; const MF6_ArrayName: string);
    // @name writes the IFACE parameter in MODFLOW.
    procedure WriteIface(const Value: TIface);
    // @name writes the header for the U2DINT array reader in MODFLOW
    // or the IARRAY array reader in MT3DMS depending on the value of
    // @link(FArrayWritingFormat).
    // @param(Comment is used to identify the array being written.)
    Procedure WriteU2DINTHeader(const Comment: string;
      ArrayType: TModflowArrayType; const MF6_ArrayName: string); virtual;
    // @name writes the header for the U2DINT array reader in MODFLOW
    // or the RARRAY array reader in MT3DMS depending on the value of
    // @link(FArrayWritingFormat).
    // @param(Comment is used to identify the array being written.)
    Procedure WriteU2DRELHeader(const Comment: string;
      ArrayType: TModflowArrayType; const MF6_ArrayName: string); virtual;
    // @name writes a line to the name file.
    class procedure WriteToNameFile(const Ftype: string;
      const UnitNumber: integer; FileName: string;
      const Option: TFileOption; AModel: TCustomModel;
      RelativeFileName: boolean = False); overload;
    class procedure WriteToNameFile(const Ftype: string;
      UnitNumber: integer; FileName: string;
      const Option: TFileOption; OutputSuppression: TOutputSuppression;
      AModel: TCustomModel;
      RelativeFileName: boolean = False); overload;
    class procedure WriteToMt3dMsNameFile(const Ftype: string;
      const UnitNumber: integer; FileName: string; Option: TFileOption;
      AModel: TCustomModel; RelativeFileName: boolean = False);
    // @name adds a comment line to the name file.
    class procedure AddNameFileComment(const Comment: string);
  end;

  // @name is an abstract base class used to generate input for
  // MODFLOW for a specific package.
  TCustomPackageWriter = class(TCustomModflowWriter)
  private
    FWarningRoot: string;
  protected
    procedure SetTimeListsUpToDate(TimeLists: TModflowBoundListOfTimeLists);
    // @name identifies the package that is being exported.
    function Package: TModflowPackageSelection; virtual; abstract;
    // @name writes the comments for the current package.
    // @name also writes a comment identifying the package.
    procedure WriteDataSet0;
    // @name prepares the lists in TimeLists for display when the
    // lists in question are not used.
    procedure UpdateNotUsedDisplay(TimeLists: TModflowBoundListOfTimeLists);
    // @name updates the @link(TDataArray)s in DataArrayList
    // using the cells @link(TValueCellList CellList).
    // @param(ParameterIndicies indicates which properties of the cells are
    // affected by MODFLOW parameters.)
    // @param(Param is a MODFLOW parameter that might affect the value of
    // some cells.)
    // @Seealso(TCustomTransientWriter.UpdateTransient2DArray)
    procedure UpdateCellDisplay(CellList: TValueCellList; DataArrayList: TList;
      ParameterIndicies: TByteSet; Param: TModflowTransientListParameter = nil;
      UsedIndicies: TByteSet = []);
    // @name adds spaces to Source until the result is at least as long
    // as ALength.
    function ExpandString(Source: string; ALength: integer): string;
    // @name is used to define parameter clusters for Param.
    //
    // When @name is called, Param must be a parameter for which the clusters
    // need to be identified and LayerCount must be greater than or equal
    // to the maximum number of clusters that could be defined for the
    // parameter.
    //
    // After @name is called:
    // NCLU will be equal to the number of layer
    // clusters needed to be associated with Param.
    //
    // Clusters will be an
    // array with length equal to the LayerCount.  The first NCLU
    // items in Clusters will be the MODFLOW layers for which a cluster
    // will need to be defined.
    //
    // UniformLayers will be an
    // array with length equal to the LayerCount.  The first NCLU
    // items in UniformLayers will indicate whether or not the cluster
    // associated with that layer will be uniform.
    //
    // The remaining items in Clusters and UniformLayers are undefined.
    procedure IdentifyZoneClusters(var NCLU: Integer;
      var Clusters: TOneDIntegerArray; var UniformLayers: TBooleanDynArray;
      LayerCount: Integer; Param: TModflowSteadyParameter);
    Function UcodeObsNameOK(Const AName: string): boolean;
    procedure CheckCell(ValueCell: TValueCell;
      const PackageName: string); virtual;
    procedure RemoveNoDefinedError(var NoDefinedErrorRoot: string); virtual;
    procedure ShowNoBoundaryError(const NoDefinedErrorRoot: string); virtual;
    function AquiferConductance(Layer, Row, Column: Integer): double;
    function AquiferKx(Layer, Row, Column: Integer): double;
  public
    destructor Destroy; override;
  end;

  TCustomSolverWriter = class(TCustomPackageWriter)
  protected
    function SolverFileGeneratedExternally: boolean;
  end;

  TCustomFlowPackageWriter = class(TCustomPackageWriter)
  protected
    function FlowPackageFileGeneratedExternally: boolean;
  end;

  // @name is used to export input files for MODFLOW for packages with
  // time-varying data.
  TCustomTransientWriter = class(TCustomPackageWriter)
  private
    // After @link(Evaluate) is called,
    // @name contains a series of @link(TValueCellList)s;
    // one for each stress period.
    // Each such list contains series of @link(TValueCell)s. Each
    // @link(TValueCell) defines one boundary cell for one stress period.
    // @name is a TObjectList.
    FValues: TList;
    function GetOwnsValueContents: Boolean;
    procedure SetOwnsValueContents(const Value: Boolean);
  protected
    // @name reads the data from the model and processes it into a form
    // where it can be readily exported to the MODFLOW input file.
    procedure Evaluate; virtual; abstract;
    // @name stores the values at a list of cells.
    property Values: TList read FValues;
    property OwnsValueContents: Boolean read GetOwnsValueContents
      write SetOwnsValueContents;

    {@name updates @link(TModflowBoundaryDisplayDataArray DisplayArray)
    with the contents of List.
    List can either contain @link(TDataArray)s,
    lists of @link(TDataArray)s, or lists of lists of @link(TDataArray)s.
    @Seealso(UpdateCellDisplay)}
    procedure UpdateTransient2DArray(
      DisplayArray: TModflowBoundaryDisplayDataArray; List: TList);

    {@name
    @unorderedList(
      @item(assigns DefaultValue to every location in
      @link(TModflowBoundaryDisplayDataArray DisplayArray),)
      @item(assigns @link(StrNoValueAssigned) to the corresponding annotation,)
      @item(assigns @link(TModflowBoundaryDisplayDataArray.CellCount)
        a value of zero.)
    )}
    procedure InitializeDisplayArray(
      DisplayArray: TModflowBoundaryDisplayDataArray; DefaultValue: Double);

    {@name uses the contents of  List to assign values to
    @link(TModflowBoundaryDisplayDataArray DisplayArray).
     @param(List can either contain @link(TValueCellList)s or
     lists of @link(TValueCellList)s.)
     DefaultValue is the value to be assigned if no member of List has
     a value.
     @param(DataType indicates whether @link(TValueCell.IntegerValue)
     or @link(TValueCell.RealValue) should be accessed.)
     @param(DataTypeIndex indicates which @link(TValueCell.IntegerValue)
     or @link(TValueCell.RealValue) should be accessed.)
     @param(UpdateMethod indicates whether successive values from @link(TValueCell)
     should replace or be added to existing values.)}
    procedure AssignTransient2DArray(
      DisplayArray: TModflowBoundaryDisplayDataArray; DataTypeIndex: Integer;
      List: TList; DefaultValue: double; DataType: TRbwDataType;
      UpdateMethod: TUpdateMethod);
    // @name counts the maximum number of cells used in any stress period. This
    // value is returned in MaximumNumberOfCells.
    procedure CountCells(var MaximumNumberOfCells: integer); virtual;
    procedure GetITMP(var ITMP: integer; TimeIndex: integer;
      var List: TValueCellList); virtual;
    procedure WriteDimensionsMF6;
  public
    // @name creates and instance of @classname.
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    // @name destroys the current instance of @classname.
    Destructor Destroy; override;
  end;

  TCustomParameterTransientWriter = class(TCustomTransientWriter)
  private
  protected
    FParameterNames: TStringList;
    // @name is used to maintain a list of parameter instance names so that
    // duplicate instance names are not generated. @name is filled once
    // when exporting the parameters and again when exporting the
    // stress periods.  Thus it must be cleared at the beginning of the process
    // of exporting the stress periods.
    FUsedInstanceNames: TStringList;
    // See @link(ParamValues).
    FParamValues: TStringList;
    function BoundariesPresent: boolean; virtual;
    // @name is used to create a @link(TValueCellList) for a particular type
    // of @link(TValueCell).
    function CellType: TValueCellType; virtual; abstract;
    // @name returns the number of cells defined by parameters and the number
    // of parameters instances for the parameter.
    procedure GetNumCellsAndNumInstances(ParamValues: TList;
      var NUMINST, NLST: Integer);
    // @name is an abstract function used to return the proper
    // @link(TModflowBoundary) for the package that is being exported.
    function GetBoundary(ScreenObject: TScreenObject): TModflowBoundary;
      virtual; abstract;
    // @name writes the non-parameter cells and the names of the parameter
    // instance for each stress period.
    // @param(DataSetIdentifier DataSetIdentifier is passed to
    //   @link(TCustomListWriter.WriteCell).)
    // @param(VariableIdentifiers VariableIdentifiers is passed to
    //   @link(TCustomListWriter.WriteCell).)
    procedure WriteStressPeriods(const VariableIdentifiers, DataSetIdentifier,
      DS5, D7PNameIname, D7PName: string); virtual; abstract;
    // @name returns the proper name for an instance of a parameter in
    // InstanceName. InstanceRoot should have been obtained from
    // @link(GetInstanceRoot). @name needs to return the same value of the
    // instance name for each unique combination of TimeIndex and InstanceRoot;
    procedure GetInstanceName(var InstanceName: string; TimeIndex: Integer;
      InstanceRoot: string);
    // @name uses PARNAM to determine InstanceRoot which is then used in
    // @link(GetInstanceName). InstanceRoot will be short enough that
    // the name of the parameter instance will always be less than or equal
    // to 10 characters.
    procedure GetInstanceRoot(const PARNAM: string; ParamValues: TList;
      var InstanceRoot: string);
    // @name determines the appropriate value or values to assign to each cell
    // for each stress period.
    procedure Evaluate; override;
    // @name adds lines to ParametersUsed that specify the parameters
    // that are used in the current stress period.
    // @name fills ParameterValues with lists of @link(TValueCellList)s.
    procedure RetrieveParametersForStressPeriod(const D7PNameIname,
      D7PName: string; TimeIndex: Integer; ParametersUsed: TStringList;
      ParameterValues: TList; IncludePrintCode: boolean);
    // @name is the number of parameters used by the package.
    function ParameterCount: integer; virtual;
    // @name is an abstract method that returns the package being exported.
    function ParameterType: TParameterType; virtual; abstract;
    // @name is an abstract method used to write the cells for a parameter.
    // If CellList.Count < NLST, dummy, inactive cells should be written so
    // that all instances of the parameter have the same number of cells.
    // @param(CellList CellList contains a list of @link(TValueCell)s to be
    //   exported.)
    // @param(NLST NLST is the required number of cells in each parameter
    //   instance.)
    // @param(DataSetIdentifier DataSetIdentifier is passed to
    //   @link(TCustomListWriter.WriteCell).)
    // @param(VariableIdentifiers VariableIdentifiers is passed to
    //   @link(TCustomListWriter.WriteCell).)
    procedure WriteParameterCells(CellList: TValueCellList; NLST: Integer;
      const VariableIdentifiers, DataSetIdentifier: string;
      AssignmentMethod: TUpdateMethod;
      MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); virtual; abstract;
    // @name writes the definitions of parameters including the lists of cells.
    // @param(DS3 DS3 identifies the data set containing
    //   PARNAM PARTYP Parval NLST  and those variable names.)
    // @param(DS3Instances DS3Instances identifies the variables
    //    associated with parameters instances.)
    // @param(DS4A DS4A identifies the data set containing INSTNAM. when
    //   parameter instances are being defined.)
    // @param(DataSetIdentifier DataSetIdentifier is passed to
    //   @link(TCustomListWriter.WriteCell).)
    // @param(VariableIdentifiers VariableIdentifiers is passed to
    //   @link(TCustomListWriter.WriteCell).)
    // @param(ErrorRoot ErrorRoot is used in a format statement to create
    //   an error message when a parameter has no associated cells.
    //   It should have %s in it somewhere which will be filled in with the
    //   type of parameter being exported.)
    // @param(ParameterType ParameterType is the type of parameter associated
    //   with the package being exported.)
    procedure WriteParameterDefinitions(const DS3, DS3Instances, DS4A,
      DataSetIdentifier, VariableIdentifiers, ErrorRoot: string;
      AssignmentMethod: TUpdateMethod;
      MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); virtual; abstract;
    { TODO -cRefactor : Consider replacing Model with an interface. }
    //
    procedure ClearTimeLists(AModel: TBaseModel);
  public
    // @name creates and instance of @classname.
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    Destructor Destroy; override;
    // After @link(Evaluate) is called,
    // @name contains a series of parameter names.  Associated with each
    // parameter name in the Objects property is a TList.  Each TList
    // contains a series of @link(TValueCellList)s; one for each stress period.
    // Each such list contains series of @link(TValueCell)s. Each
    // @link(TValueCell) defines one boundary cell for one stress period.
    property ParamValues: TStringList read FParamValues;
  end;

  {@name is used as a base class for writing typical boundary condition
   files that allow for both parameter and non-parameter cells.}
  TCustomListWriter = class(TCustomParameterTransientWriter)
  private
    FBoundNames: TStringList;
    FObjectNames: TStringList;
    procedure WriteMF6_ListParm(DataSetIdentifier, VariableIdentifiers,
      ErrorRoot: string; const TimeIndex: integer);
  protected

    // @name counts the maximum number of cells used in any stress period. This
    // value is returned in MaximumNumberOfCells.
    procedure CountCells(var MaximumNumberOfCells: Integer); override;
    // @name counts the number of parameters and the maximum number of cells
    // defined by parameters. If a parameter has no cells associated with it,
    // its name will be erased from FParamValues which will cause a warning
    // message to be displayed later on.
    // @seealso(ParameterCount)
    procedure CountParametersAndParameterCells(
      var ParamCount, ParamCellCount: integer);
    // @name returns the 'Option" used in many packages for suppressing
    // the printing of lists of cells.
    procedure GetOption(var Option: string); virtual;
    // @name is an abstract method for writes a cell.
    // @param(DataSetIdentifier DataSetIdentifier identifies the data set
    // that is being exported.)
    // @param(VariableIdentifiers VariableIdentifiers identifies the variables
    // being exported when the names of some variables vary.)
    procedure WriteCell(Cell: TValueCell;
      const DataSetIdentifier, VariableIdentifiers: string); virtual; abstract;
    // @name writes the definitions of parameters including the lists of cells.
    // @param(DS3 DS3 identifies the data set containing
    //   PARNAM PARTYP Parval NLST  and those variable names.)
    // @param(DS3Instances DS3Instances identifies the variables
    //    associated with parameters instances.)
    // @param(DS4A DS4A identifies the data set containing INSTNAM. when
    //   parameter instances are being defined.)
    // @param(DataSetIdentifier DataSetIdentifier is passed to
    //   @link(WriteCell).)
    // @param(VariableIdentifiers VariableIdentifiers is passed to
    //   @link(WriteCell).)
    // @param(ErrorRoot ErrorRoot is used in a format statement to create
    //   an error message when a parameter has no associated cells.
    //   It should have %s in it somewhere which will be filled in with the
    //   type of parameter being exported.)
    // @param(ParameterType ParameterType is the type of parameter associated
    //   with the package being exported.)
    procedure WriteParameterDefinitions(const DS3, DS3Instances, DS4A,
      DataSetIdentifier, VariableIdentifiers, ErrorRoot: string;
      AssignmentMethod: TUpdateMethod;
      MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); override;
    // @name writes the non-parameter cells and the names of the parameter
    // instance for each stress period.
    // @param(DataSetIdentifier DataSetIdentifier is passed to
    //   @link(WriteCell).)
    // @param(VariableIdentifiers VariableIdentifiers is passed to
    //   @link(WriteCell).)
    procedure WriteStressPeriods(const VariableIdentifiers, DataSetIdentifier,
      DS5, D7PNameIname, D7PName: string); override;
    // Check that the cell is in an active cell.

    // @name can be overridden to write additional information for
    // a stress period.
    procedure WriteCustomStressPeriod(TimeIndex: Integer); virtual;
    procedure DoBeforeWriteCells; virtual;
    procedure DoBeforeWriteParamCells; virtual;
    procedure WriteListOptions; virtual;
    procedure WriteOptionsMF6;
    procedure WriteBoundName(ACell: TValueCell);
    procedure WriteAndCheckCells(const VariableIdentifiers: string;
      const DataSetIdentifier: string; List: TValueCellList; TimeIndex: integer); virtual;
  public
    // @name is used to update the display of transient data used to color the
    // grid.
    // @param(TimeLists TimeLists is a list of
    //   @link(TModflowBoundaryDisplayTimeList)s that are to be updated.
    //   The order of the @link(TModflowBoundaryDisplayTimeList)s in TimeLists
    //   is important. The position in the list must be same as the index
    //   value used to access @link(TValueCell.RealValue TValueCell.RealValue)
    //   and @link(TValueCell.RealAnnotation TValueCell.RealAnnotation).)
    // @param(ParameterIndicies The values included in ParameterIndicies
    //   indicate which @link(TModflowBoundaryDisplayTimeList)s in TimeLists
    //   are affected by MODFLOW parameters.)
    procedure UpdateDisplay(TimeLists: TModflowBoundListOfTimeLists;
      ParameterIndicies: TByteSet);
  public
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    Destructor Destroy; override;
  end;

  TTransientArrayWriter = class(TCustomModflowWriter)
  protected
    class function Extension: string; override;
  public
    function WriteFile(const AFileName, ArrayType: string;
      ADataArray: TDataArray): string;
  end;


  // @name is used for packages that have an associated flux observation
  // package. @name writes the input for both the boundary condition
  // and the observations.
  TFluxObsWriter = class(TCustomListWriter)
  private
    function GetFluxType(ObservationGroup: TFluxObservationGroup): string;
    procedure RemoveWarningGroups(ObservationGroup: TFluxObservationGroup);
  protected
    // @name must be set to the name of the input file for the package.
    FFileName: string;
    function ObservationPackage: TModflowPackageSelection; virtual; abstract;
    // @name is the file extension used for the observation input file.
    class function ObservationExtension: string; virtual; abstract;
    // @name is the file extension used for the observation output file.
    class function ObservationOutputExtension: string; virtual; abstract;
    // @name returns the name of the Observation input file.
    function ObservationFileName(AFileName: string): string;
    // @name returns the name of the Observation output file.
    function ObservationOutputFileName(AFileName: string): string;
    // @name writes OBSNAM IREFSP TOFFSET FLWOBS for the flux observations.
    procedure WriteObservationDataSet4(ObservationGroup: TFluxObservationGroup;
      DataSet4: TStringList);
    // @name writes the observation cells to be included in the observation to
    // DataSet5 for a @link(TFluxObservationGroup).
    // @param(AllCells is a list of the cells from the
    // corresponding flux package.)
    procedure WriteObservationDataSet5(DataSet5: TStringList;
      ObservationGroup: TFluxObservationGroup; AllCells: TList); virtual;
    // @name writes a flux observation file.
    procedure WriteFluxObsFile(const AFileName, OutputUnitId,
      PackageAbbreviation, DataSet1Comment, DataSet2Comment,
      DataSet3Comment: string; Observations: TFluxObservationGroups;
      Purpose: TObservationPurpose);
    procedure WriteFluxObsFileMF6(const AFileName, OutputUnitId,
      PackageAbbreviation, DataSet1Comment, DataSet2Comment,
      DataSet3Comment: string; Observations: TFluxObservationGroups;
      Purpose: TObservationPurpose);
    function ObsTypeMF6: string; virtual; abstract;
    // @name writes a cell with a factor of zero in order to ensure that
    // MODFLOW skips the cell in the observation.
    procedure WriteZeroConductanceCell(ACell: TValueCell;
      DataSet5: TStringList); virtual;
    // @name writes the layer, row, column and factor for the
    // @link(TValueCell ACell) to DataSet5.
    // @param(Expression determines what "Factor" should be.)
    // @param(Variables is a list of @link(TCustomVariable)s used by
    //  Expression.)
    // @param(DataSets is a list of @link(TDataArray)s corresponding to
    // the @link(TCustomVariable)s in Variables.)
    procedure WriteObservationCell(ACell: TValueCell; DataSet5: TStringList;
      var Expression: TExpression; DataSets, Variables: TList;
      ObsFactor: TObservationFactor); virtual;
    // @name writes the cells to be include in the observation to DataSet5.
    // @param(Variables is a list of @link(TCustomVariable)s used by
    //  Expression.)
    // @param(DataSets is a list of @link(TDataArray)s corresponding to
    // the @link(TCustomVariable)s in Variables.)
    // @param(Expression determines what "Factor" should be for each cell.)
    // @param(AllCells is a list of @link(TValueCell)s. from the corresponding
    // flux package.)
    // @param(ScreenObject is the @link(TScreenObject) that defines the
    // cells to be exported.)
    procedure WriteObservationCells(Variables, DataSets: TList;
      var Expression: TExpression; DataSet5: TStringList; AllCells: TList;
      ScreenObject: TScreenObject; ObsFactor: TObservationFactor); virtual;
    function ObsNameWarningString: string; virtual; abstract;
    procedure WriteDataSet5ForOneScreenObject(ObsFactor: TObservationFactor;
      DataSet5: TStringList; AllCells: TList);
    procedure EvaluateFactor(var Factor: Extended; var Expression: TExpression;
      ACell: TValueCell; DataSets, Variables: TList;
      ObsFactor: TObservationFactor);
    procedure WriteListOptions; override;
  end;

  TCustomTransientArrayWriter = class(TCustomParameterTransientWriter)
  private
    {@name assigns values to DataArray based on Param and
     the contents of CellList.}
    procedure EvaluateParameterCells(CellList: TValueCellList;
      DataArray: TModflowBoundaryDisplayDataArray;
      Param: TModflowTransientListParameter; AssignmentMethod: TUpdateMethod);
    {@name assigns the layer where the array boundary condition will be applied
    based on the contents of List.
    List can be a @link(TValueCellList) or contain @link(TValueCellList)s
    or contain lists of @link(TValueCellList)s.}
    procedure UpdateLayerDataSet(List: TList;
      DisplayArray: TModflowBoundaryDisplayDataArray);
  protected
    FNameOfFile: string;
    // @name stores information about which layer is used to assign
    // an array boundary condition for each stress period.
    // @name is actually a TObjectList.
    // @name is only used if the layers are specified and time-varying.
    FLayers: TList;
    // @name updates DataArray with the layer used to assign the
    // array boundary condition.
    procedure UpdateLayerDisplay(List: TValueCellList; ParameterValues: TList;
      TimeIndex: Integer; DataArray: TModflowBoundaryDisplayDataArray);
    // On exit, List contains a @link(TModflowBoundaryDisplayDataArray)
    // for each active parameter for each stress period.
    procedure EvaluateParameterDefinitions(List: TList;
      const ErrorRoot: string; AssignmentMethod: TUpdateMethod);
    // Name is used in assigning the names of Multiplier array
    // and Zone array data sets.
    function Prefix: string; virtual; abstract;
    // @name creates transient multiplier and zone arrays to define where
    // the array parameter should be applied and the  for the cells in CellList.
    // NLST is not used in this version of @name.
    // DataSetIdentifier is not used in this version of @name.
    procedure WriteParameterCells(CellList: TValueCellList; NLST: integer;
      const VariableIdentifiers, DataSetIdentifier: string;
      AssignmentMethod: TUpdateMethod;
      MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); override;
    procedure WriteParameterDefinitions(const DS3, DS3Instances, DS4A,
      DataSetIdentifier, VariableIdentifiers, ErrorRoot: string;
      AssignmentMethod: TUpdateMethod;
      MultiplierArrayNames: TTransientMultCollection;
      ZoneArrayNames: TTransientZoneCollection); override;
    // @name is used to write the layer on which the array boundary
    // condition is applied for each cell in Lists.
    procedure WriteLayerArray(Lists: TList; const Comment: string; const MF6_ArrayName: string);
    // @name writes the layer where the array boundary should be applied.
    // If the layer is time-varying, FLayers is used to define the layers.
    // If parameters are used, ParameterValues is used to define the layers.
    // Otherwise, List is used to define the layers.
    procedure WriteLayerSelection(List: TValueCellList;
      ParameterValues: TList; TimeIndex: Integer; const Comment: string;
      const MF6_ArrayName: string);
    // @name clears @link(FUsedInstanceNames) so that the same parameter
    //instance names will be used in the stress periods as used in the
    // paramater definitions.
    procedure WriteStressPeriods(const VariableIdentifiers, DataSetIdentifier,
      DS5, D7PNameIname, D7PName: string); override;
    function ParameterCount: integer; override;
  public
    Constructor Create(Model: TCustomModel; EvaluationType: TEvaluationType); override;
    // @name destroys the current instance of @classname.
    Destructor Destroy; override;
  end;

  TCustomSubWriter = class(TCustomPackageWriter)
  protected
    procedure GetStartAndEndTimeSteps(var ITS2, ISP2, ITS1, ISP1: Integer;
      PrintChoice: TCustomPrintItem);
    function StartTimeOK(Time: double; PrintChoice: TCustomPrintItem): boolean;
    function EndTimeOK(Time: double; PrintChoice: TCustomPrintItem): boolean;
  end;

  TCustomNameFileWriter = class(TCustomModflowWriter)
  private
    FNameFile: TStringList;
    FInputFiles: TStringList;
    FOutputFiles: TStringList;
    FListFileName: string;
    FFullOutputFiles: TStringList;
  protected
    // @name clears the name file.
    procedure ClearNameFile;
    procedure InitilizeNameFile(Const FileName: string;
      out OutputListFileName: string); virtual; abstract;
    procedure HandleMF6Files; virtual;
    function ArchiveExtension: string; virtual;
  public
    Constructor Create(AModel: TCustomModel; const FileName: string;
      EvaluationType: TEvaluationType); reintroduce;
    Destructor Destroy; override;
    // Name saves the name file to a file.
    procedure SaveNameFile(AFileName: string); virtual;
  public
    property ListFileName: string read FListFileName;
    property NameFile: TStringList read FNameFile;
    property InputFiles: TStringList read FInputFiles;
    property OutputFiles: TStringList read FOutputFiles;
  end;

  TNameFileWriter = class(TCustomNameFileWriter)
  private
    procedure CheckExternalFiles(const FileName: string);
  protected
    // @name adds lines to the name file to define the listing file,
    // the cell-by-cell flow file, and the files generated outside of
    // ModelMuse.
    procedure InitilizeNameFile(Const FileName: string;
      out OutputListFileName: string); override;
    procedure HandleMF6Files; override;
  public
    procedure SaveNameFile(AFileName: string); override;
    class function Extension: string; override;
  end;

  TMt3dmsNameWriter = class(TCustomNameFileWriter)
  protected
    procedure InitilizeNameFile(Const FileName: string;
      out OutputListFileName: string); override;
    function ArchiveExtension: string; override;
  public
    procedure SaveNameFile(AFileName: string); override;
    class function Extension: string; override;
  end;

  TModelDataList = TList<TModelData>;

  TMf6_SimNameFileWriter = class(TCustomModflowWriter, IMf6_SimNameFileWriter)
  private
    FTDisFileName: string;
    FModelDataList: TModelDataList;
    procedure WriteOptions;
    procedure WriteTiming;
    procedure WriteModels;
    procedure WriteSolutionGroups;
    function GetTDisFileName: string;
    procedure SetTDisFileName(const Value: string);
  protected
    FRefCount: Integer;
    class function Extension: string; override;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    Constructor Create(AModel: TCustomModel); reintroduce;
    destructor Destroy; override;
    property TDisFileName: string read GetTDisFileName write SetTDisFileName;
    procedure AddModel(ModelData: TModelData);
    procedure WriteFile(FileName: string);
  end;

// name writes a batch-file used to run MODFLOW.
function WriteModflowBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFiles: TStringList; OpenListFile: boolean;
  Before, After: TStrings; ExportModpath, ExportZoneBudget: boolean;
  Model: TCustomModel): string;

function WriteMt3dmsBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFiles: TStringList; OpenListFile: boolean): string;

// name writes a batch-file used to run MODPATH.
function WriteModPathBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFile: string; OpenListFile: boolean;
  const LargeBudgetFileResponse: string; EmbeddedExport: boolean; Model: TCustomModel): string;

function WriteModPathBatchFileVersion6(ProgramLocations: TProgramLocations;
  FileName: string; ListFile: string; OpenListFile: boolean;
  EmbeddedExport: boolean; ModpathInputFiles: TStrings): string;

function WriteZoneBudgetBatchFile(Model: TCustomModel;
  FileName: string; OpenListFile, EmbeddedExport: boolean): string;

procedure ResetMaxUnitNumber;
function GetMaxUnitNumber: integer;

procedure SetCurrentNameFileWriter(NameFileWriter: TCustomNameFileWriter);

procedure AddOpenListFileLine(ListFile: string; OpenListFile: Boolean;
  BatchFile: TStringList; ProgramLocations: TProgramLocations);

resourcestring
  StrObservationFactor = '(Observation factor for the ' + sLineBreak + '%s)';
  StrNoValueAssigned = 'No value assigned';
  StrNoBoundaryConditio = 'No boundary conditions assigned to the %s because' +
  ' the object does not set the values of either enclosed or intersected cel' +
  'ls.';
  StrTheSPackageHasB = 'The %s package has been activated but no boundaries ' +
  'for it have been defined.';
  StrNoDefinedBoundarie = 'No defined boundaries in %s.';
  StrInSNoFlowObser = 'In %s, no flow observations of the correct type have ' +
  'been defined.';
  StrSelectModelObserv = 'Select "Model|Observation Type" and make sure you ' +
  'have the correct observation type selected.';
  StrLayerRowCol = 'Layer, Row, Col = [%0:d, %1:d, %2:d]';
  StrLayerRowColObject = 'Layer, Row, Col = [%0:d, %1:d, %2:d] defined by the object %3:s';
  StrLayerRowColObjectAmount = 'Layer, Row, Col = [%0:d, %1:d, %2:d] defined by the object %3:s. Amount: %4:g.';
  StrEvaluatingS = '  Evaluating %s';
  StrEvaluatingSData = 'Evaluating %s data.';
  StrWritingStressPer = '  Writing Stress Period %d';
  StrNoBoundaryConditio1 = 'No boundary conditions for the %0:s in one or mor' +
  'e stress periods.';
  StrStressPeriod0d = 'Stress Period %0:d';
  StrOneOrMoreSParam = 'One or more %s parameters have been eliminated becau' +
  'se there are no cells associated with them.';
  StrRunModelBat = 'RunModel.Bat';

const
  // @name is the comment assigned to locations in a @link(TDataArray) where
  // no value has been assigned but a value is still needed.
  StrDATABINARY = 'DATA(BINARY)';
  StrDATA = 'DATA';
  StrArrays = 'arrays';

implementation

uses frmErrorsAndWarningsUnit, ModflowUnitNumbers, frmGoPhastUnit,
  frmProgressUnit, GlobalVariablesUnit, frmFormulaErrorsUnit, GIS_Functions,
  ZoneBudgetWriterUnit, ModelMuseUtilities, SparseDataSets, SparseArrayUnit,
  RealListUnit, ModflowMultiplierZoneWriterUnit, IOUtils,
  ModpathResponseFileWriterUnit, ModflowPackagesUnit, Math,
  System.Generics.Defaults, ArchiveNodeInterface;

resourcestring
  StrTheFollowingParame = 'The following %s parameters are being skipped ' +
  'because they have no cells associated with them.';
  StrValueTooLong = 'Value too long';
  StrSIsTooLong10 = '%s is too long to be displayed with 10 characters';
  StrSIsTooLong2 = '%s is too long to be displayed with 2 characters';
  StrTheSInputFileCa = 'The %s input file can not be created.';
  StrInTheBoundaryPack = 'In the boundary package related to the %s package,' +
  ' no boundaries were defined.';
  StrErrorFlowObservatEarly = 'Error; Flow Observation = %0:s Early Times = ' +
  '%1:s';
  StrErrorFlowObservatLate = 'Error; Flow Observation = %0:s Late Times = ' +
  '%1:s';
  EarlyTimeWarning = '%s flow observation times earlier than the beginning of the first stress period will be ignored.';
  LateTimeWarning = '%s flow observation times later than the end of the last stress period will be ignored.';
  MissingFile = 'One or more files that you specified in the MODFLOW Name '
    + 'File dialog box are missing. If these are input files, MODFLOW will '
    + 'not be able to run.';
  StrNameFileForMODFLO = 'Name File for MODFLOW created on %0:s by %1:s';
  StrNameFileForMT3DMS = 'Name File for MT3DMS created on %0:s by %1:s';
  StrTheFlowtransportL = 'The flow-transport link file, %s, does not exist. ' +
  'Run MODFLOW again to correct the problem.';
  StrMissingFtlFile = 'Missing *.ftl file.';
  StrWritingS = '    Writing %s';
  StrWriting0sFor = '    Writing %0:s for Layer %1:d';
  StrWritingArray = '    Writing array';
  StrWritingParamter = '    Writing paramter: %s';
  StrLayer0dRow1 = 'Layer: %0:d; Row: %1:d; Column: %2:d';
  StrInputFileDoesNot = 'Input file does not exist.';
  StrTheRequiredInputF = 'The required input file "%s" does not exist.';
  StrNoParametersAreBe = 'No parameters are being used in one or more stress' +
  ' periods in the %s package.';
  StrNoValuesAssignedT = 'No values assigned to the following data sets';
  StrMissingObservationObjects = 'In the %s package, no objects are part of ' +
  'the following observations.';
  StrOneOrMoreBoundari = 'One or more boundaries in the %s are in inactive c' +
  'ells';

var
//  NameFile: TStringList;
  MaxUnitNumber: integer = 0;
  CurrentNameFileWriter: TCustomNameFileWriter;


procedure SetCurrentNameFileWriter(NameFileWriter: TCustomNameFileWriter);
begin
  CurrentNameFileWriter := NameFileWriter;
end;

procedure ResetMaxUnitNumber;
begin
  MaxUnitNumber := 0;
end;

function GetMaxUnitNumber: integer;
begin
  result := MaxUnitNumber;
end;

procedure AddOpenListFileLine(ListFile: string; OpenListFile: Boolean;
  BatchFile: TStringList; ProgramLocations: TProgramLocations);
var
  IsNotePad: Boolean;
  TextEditor: string;
begin
  if OpenListFile then
  begin
    TextEditor := ProgramLocations.TextEditorLocation;
    IsNotePad := CompareText(StrNotepadexe, ExtractFileName(TextEditor)) = 0;
    if TextEditor <> StrNotepadexe then
    begin
      if not FileExists(TextEditor) then
      begin
        TextEditor := StrNotepadexe;
      end;
    end;
    if TextEditor <> StrNotepadexe then
    begin
      TextEditor := ExpandFileName(TextEditor);
    end;
    TextEditor := QuoteFileName(TextEditor);
    ListFile := QuoteFileName(ListFile);
    if IsNotePad then
    begin
      BatchFile.Add('Start ' + TextEditor + ' ' + ListFile);
    end
    else
    begin
      BatchFile.Add(TextEditor + ' ' + ListFile);
    end;
  end;
end;

function WriteMt3dmsBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFiles: TStringList; OpenListFile: boolean): string;
var
  ADirectory: string;
  Mt3dmsLocation: string;
  BatchFile: TStringList;
  AFileName: string;
  ListFileIndex: Integer;
begin
  ADirectory:= GetCurrentDir;
  try
    result := ExtractFileDir(FileName);
    SetCurrentDir(result);
    result := IncludeTrailingPathDelimiter(result)
      + 'RunMt3dms.Bat';

    Mt3dmsLocation := ProgramLocations.Mt3dmsLocation;

    BatchFile := TStringList.Create;
    try

      AFileName :=  QuoteFileName(ExpandFileName(Mt3dmsLocation));
      BatchFile.Add(AFileName + ' ' + ExtractFileName(FileName) {+ ' /wait'});

      for ListFileIndex := 0 to ListFiles.Count - 1 do
      begin
        AddOpenListFileLine(ListFiles[ListFileIndex], OpenListFile,
          BatchFile, ProgramLocations);
      end;

      BatchFile.Add('pause');
      BatchFile.SaveToFile(result);
    finally
      BatchFile.Free;
    end;

    BatchFile := TStringList.Create;
    try

      AFileName := '..\..\bin\' + ExtractFileName(Mt3dmsLocation);
      BatchFile.Add(AFileName + ' ' + ExtractFileName(FileName) {+ ' /wait'});
      BatchFile.Add('pause');
      BatchFile.SaveToFile(result + ArchiveExt);
    finally
      BatchFile.Free;
    end;

  finally
    SetCurrentDir(ADirectory);
  end;
end;

function WriteModflowBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFiles: TStringList; OpenListFile: boolean;
  Before, After: TStrings; ExportModpath, ExportZoneBudget: boolean;
  Model: TCustomModel): string;
var
  BatchFile: TStringList;
  ArchiveBatchFile: TStringList;
  AFileName: string;
  ADirectory: string;
  ModflowLocation: string;
  ListFileIndex: Integer;
  SwiObsExtractorPath: string;
  ParamEstBatFileName: string;
  ParamEstBatchFile: TStringList;
  ALine: string;
//  Modelname: string;
//  OutputPrefix: string;
begin
  ADirectory:= GetCurrentDir;
  try
    result := ExtractFileDir(FileName);
    SetCurrentDir(result);
    ParamEstBatFileName := IncludeTrailingPathDelimiter(result)
      + StrRunModelBat;
    result := IncludeTrailingPathDelimiter(result)
      + 'RunModflow.Bat';

    case frmGoPhast.PhastModel.ModelSelection of
      msModflow:
        begin
          ModflowLocation := ProgramLocations.ModflowLocation;
        end;
      msModflowLGR:
        begin
          ModflowLocation := ProgramLocations.ModflowLgrLocation;
        end;
      msModflowLGR2:
        begin
          ModflowLocation := ProgramLocations.ModflowLgr2Location;
        end;
      msModflowNWT:
        begin
          ModflowLocation := ProgramLocations.ModflowNwtLocation;
        end;
      msModflowFmp:
        begin
          ModflowLocation := ProgramLocations.ModflowOwhmLocation;
        end;
      msModflowCFP:
        begin
          ModflowLocation := ProgramLocations.ModflowCfpLocation;
        end;
      msModflow2015:
        begin
          ModflowLocation := ProgramLocations.Modflow6Location;
        end
      else Assert(False);
    end;

    Model.AddBinaryFile(ModflowLocation);

    ParamEstBatchFile := TStringList.Create;
    BatchFile := TStringList.Create;
    ArchiveBatchFile := TStringList.Create;
    try
      BatchFile.AddStrings(Before);
      ArchiveBatchFile.AddStrings(Before);
      ParamEstBatchFile.AddStrings(Before);
      if frmGoPhast.PhastModel.ModelSelection = msModflow2015 then
      begin
        FileName := ChangeFileExt(FileName, '.snam');
        Model.AddModelInputFile(FileName);
      end;
      if FileExists(ProgramLocations.ModelMonitorLocation) then
      begin
        BatchFile.Add('call '
          + QuoteFileName(ExpandFileName(ProgramLocations.ModelMonitorLocation))
          + ' -m ' + QuoteFileName(ExpandFileName(ModflowLocation))
          + ' -n ' + QuoteFileName(FileName));
      end
      else
      begin
        AFileName :=  QuoteFileName(ExpandFileName(ModflowLocation));
        BatchFile.Add(AFileName + ' ' + QuoteFileName(FileName) + ' /wait');
      end;
      AFileName := '..\..\bin\'+ ExtractFileName(ModflowLocation);
      ArchiveBatchFile.Add(AFileName + ' ' + ArchiveQuoteFileName(ExtractFileName(FileName)) + ' /wait');

      AFileName :=  QuoteFileName(ExpandFileName(ModflowLocation));
      ParamEstBatchFile.Add(AFileName + ' ' + QuoteFileName(FileName) + ' /wait');

      if frmGoPhast.PhastModel.InterpSwiObsDefined then
      begin

        SwiObsExtractorPath := ExtractFileDir(Application.ExeName);
        SwiObsExtractorPath := IncludeTrailingPathDelimiter(SwiObsExtractorPath);
        SwiObsExtractorPath := '"'+ SwiObsExtractorPath + 'SwiObsExtractor.exe" ';
        Model.AddBinaryFile(SwiObsExtractorPath);
        ALine := SwiObsExtractorPath + ExtractFileName(ChangeFileExt(FileName, '.swi_obsi'));
        BatchFile.Add(ALine);
        ParamEstBatchFile.Add(ALine);
        ALine := '..\..\bin\SwiObsExtractor.exe ' + ExtractFileName(ChangeFileExt(FileName, '.swi_obsi'));
        ArchiveBatchFile.Add(ALine);
      end;

      BatchFile.AddStrings(After);
      ParamEstBatchFile.AddStrings(After);
      ArchiveBatchFile.AddStrings(After);
      for ListFileIndex := 0 to ListFiles.Count - 1 do
      begin
        AddOpenListFileLine(ListFiles[ListFileIndex], OpenListFile,
          BatchFile, ProgramLocations);
      end;

      if ExportModpath then
      begin
        ALine := 'call RunModpath.bat';
        BatchFile.Add(ALine);
        ParamEstBatchFile.Add(ALine);
      end;
      if ExportZoneBudget then
      begin
        ALine := 'call RunZoneBudget.bat';
        BatchFile.Add(ALine);
        ParamEstBatchFile.Add(ALine);
      end;

      BatchFile.Add('pause');
      ArchiveBatchFile.Add('pause');

      BatchFile.SaveToFile(result);
      ParamEstBatchFile.SaveToFile(ParamEstBatFileName);
      ArchiveBatchFile.SaveToFile(result + ArchiveExt);
      Model.AddModelInputFile(result + ArchiveExt);
    finally
      BatchFile.Free;
      ParamEstBatchFile.Free;
      ArchiveBatchFile.Free;
    end;
  finally
    SetCurrentDir(ADirectory);
  end;
end;

function WriteModPathBatchFileVersion6(ProgramLocations: TProgramLocations;
  FileName: string; ListFile: string; OpenListFile: boolean;
  EmbeddedExport: boolean; ModpathInputFiles: TStrings): string;
var
  BatchFile: TStringList;
  ArchiveBatchFile: TStringList;
  ModPathLocation: string;
  AFileName: string;
  MpBatName: string;
  Modelname: string;
  OutputPrefix: string;
begin
  result := ExtractFileDir(FileName);
  MpBatName := IncludeTrailingPathDelimiter(result)
    + 'Mp.bat';

  BatchFile := TStringList.Create;
  ArchiveBatchFile := TStringList.Create;
  try
    AFileName := ExtractFileName(ChangeFileExt(FileName, TModpathSimFileWriter.Extension));

    ModPathLocation :=  QuoteFileName(ProgramLocations.ModPathLocationVersion6);
    BatchFile.Add(ModPathLocation + ' ' + AFileName);

    ModPathLocation := '..\..\bin\' + ExtractFileName(ProgramLocations.ModPathLocationVersion6);
    ArchiveBatchFile.Add(ModPathLocation + ' ' + AFileName);

    BatchFile.SaveToFile(MpBatName);
    ArchiveBatchFile.SaveToFile(MpBatName + ArchiveExt);

    ModpathInputFiles.Add(MpBatName + ArchiveExt)
  finally
    BatchFile.Free;
    ArchiveBatchFile.Free;
  end;

  result := IncludeTrailingPathDelimiter(result)
    + 'RunModpath.Bat';

  FileName := ExtractFileName(FileName);
  BatchFile := TStringList.Create;
  try
    BatchFile.Add('call mp.bat /wait');
    AddOpenListFileLine(ListFile, OpenListFile, BatchFile, ProgramLocations);
    if not EmbeddedExport then
    begin
      BatchFile.Add('pause');
    end;
    BatchFile.SaveToFile(result);

    Modelname := ChangeFileExt(ExtractFileName(FileName), '');
    OutputPrefix := '..\..\output\' + Modelname + '_Modpath\';
    BatchFile.Add('move /Y MPATH6.LOG ' + OutputPrefix + 'MPATH6.LOG');

    if EmbeddedExport then
    begin
      BatchFile.Add('pause');
    end;
    BatchFile.SaveToFile(result + ArchiveExt);
    ModpathInputFiles.Add(result + ArchiveExt)
  finally
    BatchFile.Free;
  end;

end;

function WriteModPathBatchFile(ProgramLocations: TProgramLocations;
  FileName: string; ListFile: string; OpenListFile: boolean;
  const LargeBudgetFileResponse: string; EmbeddedExport: boolean;
  Model: TCustomModel): string;
var
  BatchFile: TStringList;
  AFileName: string;
  ResponseFile: string;
  MpBatName: string;
begin
  result := ExtractFileDir(FileName);
  MpBatName := IncludeTrailingPathDelimiter(result)
    + 'MpIn.txt';
  Model.AddModpathInputFile(MpBatName);

  BatchFile := TStringList.Create;
  try
    ResponseFile := ChangeFileExt(FileName, '.mprsp');
    Model.AddModpathInputFile(ResponseFile);
    ResponseFile := ExtractFileName(ResponseFile);
    BatchFile.Add(ResponseFile);
    if LargeBudgetFileResponse <> '' then
    begin
      BatchFile.Add(LargeBudgetFileResponse);
    end;
    BatchFile.SaveToFile(MpBatName);
  finally
    BatchFile.Free;
  end;

  MpBatName := IncludeTrailingPathDelimiter(result)
    + 'Mp.bat';

  BatchFile := TStringList.Create;
  try
    AFileName :=  QuoteFileName(ProgramLocations.ModPathLocation);
    BatchFile.Add(AFileName + ' <MpIn.txt');
    BatchFile.SaveToFile(MpBatName);
  finally
    BatchFile.Free;
  end;

  Model.AddModpathInputFile(MpBatName + ArchiveExt);
  BatchFile := TStringList.Create;
  try
    AFileName :=  ExtractFileName(ProgramLocations.ModPathLocation);
    AFileName := '..\..\bin\' + AFileName;
    BatchFile.Add(AFileName + ' <MpIn.txt');
    BatchFile.SaveToFile(MpBatName + ArchiveExt);
  finally
    BatchFile.Free;
  end;

  result := IncludeTrailingPathDelimiter(result)
    + 'RunModpath.Bat';
  Model.AddModpathInputFile(result + ArchiveExt);

  FileName := ExtractFileName(FileName);
  BatchFile := TStringList.Create;
  try
    BatchFile.Add('call mp.bat /wait');
    AddOpenListFileLine(ListFile, OpenListFile, BatchFile, ProgramLocations);
    if not EmbeddedExport then
    begin
      BatchFile.Add('pause');
    end;
    BatchFile.SaveToFile(result);
    if EmbeddedExport then
    begin
      BatchFile.Add('pause');
    end;
    BatchFile.SaveToFile(result + ArchiveExt);
  finally
    BatchFile.Free;
  end;
end;

function WriteZoneBudgetBatchFile(Model: TCustomModel;
  FileName: string; OpenListFile, EmbeddedExport: boolean): string;
var
  BatchFile: TStringList;
  AFileName: string;
  ResponseFile: string;
  ZoneBudBatName: string;
  ProgramLocations: TProgramLocations;
  ListFile: string;
  ZoneBudget: TZoneBudgetSelect;
  ZoneBudgetLocation: string;
  ADirectory: string;
begin
  ZoneBudget := Model.ModflowPackages.ZoneBudget;
  if ZoneBudget.ExportCSV2 then
  begin
    ListFile := ChangeFileExt(FileName, '.2.csv');
    Model.AddZoneBudgetOutputFile(ListFile);
  end;
  if ZoneBudget.ExportCSV then
  begin
    ListFile := ChangeFileExt(FileName, '.csv');
    Model.AddZoneBudgetOutputFile(ListFile);
  end;
  if ZoneBudget.ExportZBLST then
  begin
    ListFile := ChangeFileExt(FileName, '.zblst');
    Model.AddZoneBudgetOutputFile(ListFile);
  end;

  ProgramLocations := Model.ProgramLocations;

  ZoneBudgetLocation := ProgramLocations.ZoneBudgetLocation;
  Model.AddZoneBudgetInputFile(ZoneBudgetLocation);
  ZoneBudgetLocation := QuoteFileName(ZoneBudgetLocation);

  ADirectory := IncludeTrailingPathDelimiter(ExtractFileDir(FileName));

  ResponseFile := ChangeFileExt(FileName, TZoneBudgetResponseFileWriter.Extension);
//  Model.AddZoneBudgetInputFile(ResponseFile);
  ResponseFile := ExtractFileName(ResponseFile);

  ZoneBudBatName := ADirectory + 'ZB.bat';
  BatchFile := TStringList.Create;
  try
    AFileName :=  ZoneBudgetLocation;
    Model.AddZoneBudgetInputFile(AFileName);
    BatchFile.Add(AFileName + ' <' + ResponseFile);
    BatchFile.SaveToFile(ZoneBudBatName);
  finally
    BatchFile.Free;
  end;

  ZoneBudBatName := ADirectory + 'RunZoneBudget.bat' + ArchiveExt;
  Model.AddZoneBudgetInputFile(ZoneBudBatName);
  BatchFile := TStringList.Create;
  try
    AFileName :=  '..\..\bin\' + ExtractFileName(ZoneBudgetLocation);
//    Model.AddZoneBudgetInputFile(AFileName);
    BatchFile.Add(AFileName + ' <' + ResponseFile);
    BatchFile.Add('pause');
    BatchFile.SaveToFile(ZoneBudBatName);
  finally
    BatchFile.Free;
  end;

  result := ADirectory + 'RunZoneBudget.Bat';
//  Model.AddZoneBudgetInputFile(result);

  FileName := ExtractFileName(FileName);
  BatchFile := TStringList.Create;
  try
    BatchFile.Add('call ZB.bat /wait');
    AddOpenListFileLine(ListFile, OpenListFile, BatchFile, ProgramLocations);
    if not EmbeddedExport then
    begin
      BatchFile.Add('pause');
    end;
    BatchFile.SaveToFile(result);
  finally
    BatchFile.Free;
  end;
end;

{ TCustomModflowWriter }

class procedure TCustomModflowWriter.AddNameFileComment(const Comment: string);
begin
  Assert(CurrentNameFileWriter <> nil);
  CurrentNameFileWriter.NameFile.Add('# ' + Comment);
end;

procedure TCustomModflowWriter.WriteArrayValues(const LayerIndex: Integer; const DataArray: TDataArray);
var
  ColIndex: Integer;
  RowIndex: Integer;
  NeedNewLine: Boolean;
begin
  for RowIndex := 0 to DataArray.RowCount - 1 do
  begin
    NeedNewLine := False;
    if (Model.ModelSelection = msModflow2015) then
    begin
      WriteString('      ');
    end;
    for ColIndex := 0 to DataArray.ColumnCount - 1 do
    begin
      case DataArray.DataType of
        rdtDouble:
          begin
            WriteFloat(DataArray.RealData[LayerIndex, RowIndex, ColIndex]);
          end;
        rdtInteger:
          begin
            WriteInteger(DataArray.IntegerData[LayerIndex, RowIndex, ColIndex]);
          end;
        rdtBoolean:
          begin
            if DataArray.BooleanData[LayerIndex, RowIndex, ColIndex] then
            begin
              WriteInteger(1);
            end
            else
            begin
              WriteInteger(0);
            end;
          end;
      else
        Assert(False);
      end;
      NeedNewLine := ((ColIndex + 1) mod 10) <> 0;
      if not NeedNewLine then
      begin
        NewLine;
        if (Model.ModelSelection = msModflow2015)
          and (ColIndex <> DataArray.ColumnCount - 1) then
        begin
          WriteString('      ');
        end;
      end;
    end;
    if NeedNewLine then
    begin
      NewLine;
    end;
  end;
end;

function TCustomModflowWriter.CheckArrayUniform(const LayerIndex: Integer;
  const DataArray: TDataArray): boolean;
var
  ColIndex: Integer;
  RowIndex: Integer;
  IntValue: Integer;
  BoolValue: Boolean;
  RealValue: Double;
begin
  DataArray.Initialize;
  RealValue := 0;
  IntValue := 0;
  BoolValue := False;
  case DataArray.DataType of
    rdtDouble:
      begin
        RealValue := DataArray.RealData[LayerIndex, 0, 0];
      end;
    rdtInteger:
      begin
        IntValue := DataArray.IntegerData[LayerIndex, 0, 0];
      end;
    rdtBoolean:
      begin
        BoolValue := DataArray.BooleanData[LayerIndex, 0, 0];
      end;
  else
    Assert(False);
  end;
  result := True;
  for RowIndex := 0 to DataArray.RowCount - 1 do
  begin
    for ColIndex := 0 to DataArray.ColumnCount - 1 do
    begin
      case DataArray.DataType of
        rdtDouble:
          begin
            result := DataArray.RealData[LayerIndex, RowIndex, ColIndex] = RealValue;
          end;
        rdtInteger:
          begin
            result := DataArray.IntegerData[LayerIndex, RowIndex, ColIndex] = IntValue;
          end;
        rdtBoolean:
          begin
            result := DataArray.BooleanData[LayerIndex, RowIndex, ColIndex] = BoolValue;
          end;
      else
        Assert(False);
      end;
      if not result then
        break;
    end;
    if not result then
      break;
  end;
end;

function TCustomModflowWriter.ShouldCheckCell(LayerIndex, RowIndex,
  ColIndex: Integer): Boolean;
begin
  Result := True;
end;

function TCustomModflowWriter.CheckArray(const DataArray: TDataArray;
  const LayerIndex: integer; const ErrorOrWarningMessage: string;
  CheckMethod: TCheckValueMethod; CheckValue: double; ErrorType: TErrorType): boolean;
var
  RowIndex: Integer;
  ColIndex: Integer;
  Value: double;
  OtherValue1: double;
  OtherValue2: double;
  OkValue: boolean;
  Error: string;
  ActiveDataArray: TDataArray;
  Active: Boolean;
  OtherRow: Integer;
  OtherCol: Integer;
begin

  case ErrorType of
    etError: frmErrorsAndWarnings.RemoveErrorGroup(Model, ErrorOrWarningMessage);
    etWarning: frmErrorsAndWarnings.RemoveWarningGroup(Model, ErrorOrWarningMessage);
  end;
  result := True;
  ActiveDataArray := FModel.DataArrayManager.GetDataSetByName(rsActive);
  Assert(ActiveDataArray <> nil);
  ActiveDataArray.Initialize;
  DataArray.Initialize;
  for RowIndex := 0 to DataArray.RowCount -1 do
  begin
    for ColIndex := 0 to DataArray.ColumnCount - 1 do
    begin
      Value := 0;
      case DataArray.DataType of
        rdtDouble:
          begin
            Value := DataArray.RealData[LayerIndex, RowIndex, ColIndex];
          end;
        rdtInteger:
          begin
            Value := DataArray.IntegerData[LayerIndex, RowIndex, ColIndex];
          end;
        else Assert(False);
      end;
      Active := ActiveDataArray.BooleanData[LayerIndex, RowIndex, ColIndex];
      OkValue := True;
      OtherRow := 0;
      OtherCol := 0;
      if Active and ShouldCheckCell(LayerIndex, RowIndex, ColIndex) then
      begin
        case CheckMethod of
          cvmGreater: OkValue := Value > CheckValue;
          cvmGreaterEqual: OkValue := Value >= CheckValue;
          cvmEqual: OkValue := Value = CheckValue;
          cvmNotEqual: OkValue := Value <> CheckValue;
          cvmLessThan: OkValue := Value < CheckValue;
          cvmLessThanEqual: OkValue := Value <= CheckValue;
          cvmGradient:
            begin
              Assert(DataArray.DataType = rdtDouble);
              if Value <> 0 then
              begin
                if (RowIndex > 0)
                  and ActiveDataArray.BooleanData[LayerIndex, RowIndex-1, ColIndex] then
                begin
                  OtherValue1 := DataArray.RealData[LayerIndex, RowIndex-1, ColIndex];
                end
                else
                begin
                  OtherValue1 := Value
                end;
                if (ColIndex > 0)
                  and ActiveDataArray.BooleanData[LayerIndex, RowIndex, ColIndex-1] then
                begin
                  OtherValue2 := DataArray.RealData[LayerIndex, RowIndex, ColIndex-1];
                end
                else
                begin
                  OtherValue2 := Value
                end;
                OtherRow := RowIndex;
                OtherCol := ColIndex;
                if Abs(OtherValue2-Value) > Abs(OtherValue1-Value)  then
                begin
                  OtherValue1 := OtherValue2;
                  OtherCol := ColIndex-1
                end
                else
                begin
                  OtherRow := RowIndex-1;
                end;
                if OtherValue1 <> 0 then
                begin
                  if OtherValue1 > Value then
                  begin
                    OtherValue1 := OtherValue1/Value;
                  end
                  else
                  begin
                    OtherValue1 := Value/OtherValue1;
                  end;
                  OkValue := OtherValue1 <= CheckValue;
                end
                else
                begin
                  OkValue := True;
                end;
              end
              else
              begin
                OkValue := True;
              end;
            end;
          else Assert(False);
        end;
      end;
      if not OkValue then
      begin
        result := False;
        Error := Format(StrLayer0dRow1, [LayerIndex+1, RowIndex+1,ColIndex+1]);
        if CheckMethod = cvmGradient then
        begin
          Error := 'Between ' + Error + ' and '
            + Format(StrLayer0dRow1, [LayerIndex+1, OtherRow+1,OtherCol+1]);
        end;
        case ErrorType of
          etError: frmErrorsAndWarnings.AddError(Model, ErrorOrWarningMessage, Error);
          etWarning: frmErrorsAndWarnings.
            AddWarning(Model, ErrorOrWarningMessage, Error);
        end;
      end;
    end;
  end;
  Model.DataArrayManager.AddDataSetToCache(DataArray);
end;

procedure TCustomFileWriter.CloseFile;
begin
  FreeAndNil(FFileStream);
end;

//procedure TCustomModflowWriter.UpdateExportTime;
//const
//  TenthSecond = 1/24/3600/10;
//begin
//  if (Now - FExportTime) > TenthSecond then
//  begin
//    FExportTime := Now;
//    Application.ProcessMessages;
//  end;
//end;

constructor TCustomModflowWriter.Create(AModel: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited Create(AModel, EvaluationType);
  if Model.ModelSelection = msModflow2015 then
  begin
    FArrayWritingFormat := awfModflow_6;
  end
  else
  begin
    FArrayWritingFormat := awfModflow;
  end;
end;

class function TCustomFileWriter.FileName(const AFileName: string): string;
begin
  result := ChangeFileExt(AFileName, Extension);
end;

constructor TCustomFileWriter.Create(AModel: TCustomModel;
  EvaluationType: TEvaluationType);
begin
  inherited Create;
  FEvaluationType := EvaluationType;
  FModel := AModel;
end;

//class function TCustomFileWriter.Extension: string;
//begin
//  Result := '';
//end;
//
class function TCustomFileWriter.FixedFormattedInteger(const Value,
  Width: integer): string;
var
  Index : integer;
  PadIndex : integer;
begin
  for Index := Width downto 1 do
  begin
    result := Format(' %.*d', [Index, Value]);
    if Value < 0 then
    begin
      while (Length(result) > 3) and (result[3] = '0') do
      begin
        Delete(result, 3, 1);
      end;
    end
    else
    begin
      while (Length(result) > 2) and (result[2] = '0') do
      begin
        Delete(result, 2, 1);
      end;
    end;

    if Length(result) <= Width then
    begin
      for PadIndex := 0 to Width - Length(result) -1 do
      begin
        result := ' ' + result;
      end;
      break;
    end;
  end;
end;

class function TCustomFileWriter.FixedFormattedReal(const Value: double;
  const Width: integer): string;
var
  Index : integer;
  PadIndex : integer;
begin
  for Index := Width downto 1 do
  begin
    result := Format(' %.*g', [Index, Value]);
    if Length(result) <= Width then
    begin
      for PadIndex := 0 to Width - Length(result) -1 do
      begin
        result := ' ' + result;
      end;
      break;
    end;
  end;
  result := FortranDecimal(result);
end;

class function TCustomFileWriter.FortranDecimal(
  NumberString: string): string;
begin
  if FormatSettings.DecimalSeparator = '.' then
  begin
    result := NumberString;
  end
  else
  begin
    result := StringReplace(NumberString, FormatSettings.DecimalSeparator, '.',
      [rfReplaceAll]);
  end;
end;

class function TCustomFileWriter.FreeFormattedReal(
  const Value: double): string;
begin
  result := FortranDecimal(Format('%.13e ', [Value]));
  while Length(result) < 21 do
  begin
    result := ' ' + result
  end;
end;

procedure TCustomFileWriter.NewLine;
begin
  WriteString(sLineBreak);
end;

procedure TCustomFileWriter.OpenFile(const FileName: string);
begin
  FFileStream:= TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
end;

procedure TCustomModflowWriter.WriteArray(const DataArray: TDataArray;
  const LayerIndex: integer; const Comment: string;
  NoValueAssignedAnnotation: string; const MF6_Arrayname: string;
  CacheArray: Boolean = True);
var
  RealValue: double;
  IntValue: integer;
  BoolValue: Boolean;
  Uniform: boolean;
  UnassignedAnnotation: Boolean;
  RowIndex: integer;
  ColIndex: integer;
begin
  Assert(DataArray <> nil);
  if Comment <> '' then
  begin
    frmProgressMM.AddMessage(Format(StrWritingS, [Comment]));
  end
  else if DataArray.Name <> '' then
  begin
    frmProgressMM.AddMessage(Format(StrWriting0sFor,
      [DataArray.Name, LayerIndex+1]));
  end
  else
  begin
    frmProgressMM.AddMessage(StrWritingArray);
  end;

  Uniform := CheckArrayUniform(LayerIndex, DataArray);

  if Uniform then
  begin
    case DataArray.DataType of
      rdtDouble:
        begin
          RealValue := DataArray.RealData[LayerIndex, 0, 0];
          WriteConstantU2DREL(Comment, RealValue, matStructured, MF6_Arrayname);
        end;
      rdtInteger:
        begin
          IntValue := DataArray.IntegerData[LayerIndex, 0, 0];
          WriteConstantU2DINT(Comment, IntValue, matStructured, MF6_Arrayname);
        end;
      rdtBoolean:
        begin
          BoolValue := DataArray.BooleanData[LayerIndex, 0, 0];
          IntValue := Ord(BoolValue);
          WriteConstantU2DINT(Comment, IntValue, matStructured, MF6_Arrayname);
        end;
      else Assert(False);
    end;
    UnassignedAnnotation := True;
    for RowIndex := 0 to DataArray.RowCount - 1 do
    begin
      for ColIndex := 0 to DataArray.ColumnCount - 1 do
      begin
        if DataArray.Annotation[LayerIndex, RowIndex, ColIndex]
          <> NoValueAssignedAnnotation then
        begin
          UnassignedAnnotation := False;
        end;
      end;
    end;
    if UnassignedAnnotation then
    begin
      if DataArray.Name <> '' then
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrNoValuesAssignedT,
          DataArray.Name);
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model, StrNoValuesAssignedT,
          Comment);
      end;
    end;
  end
  else
  begin
    WriteHeader(DataArray, Comment, MF6_Arrayname);
    WriteArrayValues(LayerIndex, DataArray);
  end;
  if CacheArray then
  begin
    FModel.DataArrayManager.AddDataSetToCache(DataArray);
  end;
end;

procedure TCustomFileWriter.WriteCommentLine(const Comment: string);
begin
  WriteString('# ' + Comment);
  NewLine;
end;

procedure TCustomModflowWriter.WriteCommentLines(const Lines: TStrings);
var
  LineIndex: Integer;
begin
  for LineIndex := 0 to Lines.Count - 1 do
  begin
    WriteCommentLine(Lines[LineIndex]);
  end;
end;

procedure TCustomModflowWriter.WriteCrossSectionArray(
  const DataArray: TDataArray; const Comment: string;
  const MF6_ArrayName: string);
var
  LayerIndex, ColIndex: Integer;
  NeedNewLine: boolean;
begin
  DataArray.Initialize;
  WriteHeader(DataArray, Comment, MF6_ArrayName);
  for LayerIndex := 0 to DataArray.LayerCount -1 do
  begin
    NeedNewLine := False;
    for ColIndex := 0 to DataArray.ColumnCount - 1 do
    begin
      case DataArray.DataType of
        rdtDouble:
          begin
            WriteFloat(DataArray.RealData[LayerIndex, 0, ColIndex]);
          end;
        rdtInteger:
          begin
            WriteInteger(DataArray.IntegerData[LayerIndex, 0, ColIndex]);
          end;
        rdtBoolean:
          begin
            if DataArray.BooleanData[LayerIndex, 0, ColIndex] then
            begin
              WriteInteger(1);
            end
            else
            begin
              WriteInteger(0);
            end;
          end;
        else Assert(False);
      end;
      NeedNewLine := ((ColIndex + 1) mod 10) <> 0;
      if not NeedNewLine then
      begin
        NewLine;
      end
    end;
    if NeedNewLine then
    begin
      NewLine;
    end;
  end;
  Model.DataArrayManager.AddDataSetToCache(DataArray);
end;

procedure TCustomModflowWriter.WriteHeader(const DataArray: TDataArray;
  const Comment: string; const MF6_ArrayName: string);
begin
  case DataArray.DataType of
    rdtDouble:
      begin
        WriteU2DRELHeader(Comment, matStructured, MF6_ArrayName);
      end;
    rdtInteger, rdtBoolean:
      begin
        WriteU2DINTHeader(Comment, matStructured, MF6_ArrayName);
      end;
  else
    Assert(False);
  end;
end;

procedure TCustomFileWriter.WriteF10Float(const Value: double);
begin
  WriteString(FixedFormattedReal(Value, 10));
end;

procedure TCustomFileWriter.WriteFloat(const Value: double);
begin
  WriteString(' ' + FreeFormattedReal(Value));
end;

procedure TCustomFileWriter.WriteFloatCondensed(const Value: double);
var
  AValue: string;
  OldValueLength: Integer;
begin
  AValue := FreeFormattedReal(Value);
  repeat
    OldValueLength := Length(AValue);
    AValue := StringReplace(AValue, '00E', 'E', [rfReplaceAll, rfIgnoreCase]);
  until (OldValueLength = Length(AValue));
  WriteString(' ' + AValue);
end;

procedure TCustomFileWriter.WriteI10Integer(const Value: integer;
  const ErrorID: string);
const
  MaxCharacters = 10;
var
  ValueAsString: string;
begin
  ValueAsString := IntToStr(Value);
  if Length(ValueAsString) > MaxCharacters then
  begin
    frmErrorsAndWarnings.AddError(Model, StrValueTooLong,
      Format(StrSIsTooLong10, [ErrorID]));
  end
  else
  begin
    while Length(ValueAsString) < MaxCharacters do
    begin
      ValueAsString := ' ' + ValueAsString;
    end;
  end;
  WriteString(ValueAsString);
end;

procedure TCustomFileWriter.WriteI2Integer(const Value: integer;
  const ErrorID: string);
const
  MaxCharacters = 2;
var
  ValueAsString: string;
begin
  ValueAsString := IntToStr(Value);
  if Length(ValueAsString) > MaxCharacters then
  begin
    frmErrorsAndWarnings.AddError(Model, StrValueTooLong,
      Format(StrSIsTooLong2, [ErrorID]));
  end
  else
  begin
    while Length(ValueAsString) < MaxCharacters do
    begin
      ValueAsString := ' ' + ValueAsString;
    end;
  end;
  WriteString(ValueAsString);
end;

procedure TCustomModflowWriter.WriteIface(const Value: TIface);
var
  IFACE: integer;
begin
  IFACE := Ord(Value) - 2;
  WriteInteger(IFACE);
end;

procedure TCustomFileWriter.WriteInteger(const Value: integer);
var
  ValueAsString: string;
begin
  ValueAsString := ' ' + IntToStr(Value);
  while Length(ValueAsString) < 6 do
  begin
    ValueAsString := ' ' + ValueAsString;
  end;

  WriteString(ValueAsString);
end;

procedure TCustomFileWriter.WriteString(const Value: AnsiString);
begin
  if Length(Value) > 0 then
  begin
    FFileStream.Write(Value[1], Length(Value)*SizeOf(AnsiChar));
//    UpdateExportTime;
  end;
end;

procedure TCustomFileWriter.WriteString(const Value: String);
//var
//  StringToWrite: AnsiString;
begin
  WriteString(AnsiString(Value));
//  StringToWrite := AnsiString(Value);
//  if Length(StringToWrite) > 0 then
//  begin
//    FFileStream.Write(StringToWrite[1], Length(StringToWrite)*SizeOf(AnsiChar));
////    UpdateExportTime;
//  end;
end;

class procedure TCustomModflowWriter.WriteToMt3dMsNameFile(const Ftype: string;
  const UnitNumber: integer; FileName: string; Option: TFileOption;
  AModel: TCustomModel; RelativeFileName: boolean);
var
  Line: string;
  Extension: string;
begin
  case Option of
    foInput, foInputAlreadyExists:
      begin
        Extension := ExtractFileExt(FileName);
        if Extension <> '.ftl' then
        begin
          AModel.AddMt3dmsInputFile(FileName);
        end;
      end;
    foOutput:
      begin
        AModel.AddMt3dmsOutputFile(FileName);
        CurrentNameFileWriter.FFullOutputFiles.Add(FileName)
      end;
    else
      Assert(False);
  end;
  if not RelativeFileName then
  begin
    FileName := ExtractFileName(FileName);
  end;
  Line := Ftype + ' ' + IntToStr(UnitNumber) + ' ' + FileName;
  Assert(CurrentNameFileWriter <> nil);
  CurrentNameFileWriter.NameFile.Add(Line);
end;

class procedure TCustomModflowWriter.WriteToNameFile(const Ftype: string;
  UnitNumber: integer; FileName: string; const Option: TFileOption;
  OutputSuppression: TOutputSuppression; AModel: TCustomModel;
  RelativeFileName: boolean);
var
  Line: string;
  UnitNumberString: string;
begin
  Assert(CurrentNameFileWriter <> nil);
  if (Option = foInputAlreadyExists) and not FileExists(FileName) then
  begin
    frmErrorsAndWarnings.AddError(CurrentNameFileWriter.Model,
      StrInputFileDoesNot,
      Format(StrTheRequiredInputF, [FileName]));
  end;
  if UnitNumber > MaxUnitNumber then
  begin
    MaxUnitNumber := UnitNumber;
  end;
  case Option of
    foInput, foInputAlreadyExists:
      begin
        AModel.AddModelInputFile(FileName);
      end;
    foOutput:
      begin
        AModel.AddModelOutputFile(FileName);
        CurrentNameFileWriter.FFullOutputFiles.Add(ExtractFileName(FileName))
      end;
    else
      Assert(False);
  end;
  if not RelativeFileName then
  begin
    FileName := ExtractFileName(FileName);
  end;
  if Pos(' ', FileName) > 0 then
  begin
    if not FileExists(FileName) and (Option <> foInputAlreadyExists) then
    begin
      TFile.Create(FileName).Free;
    end;
    if frmGoPhast.ModelSelection <> msModflow2015 then
    begin
      FileName := ExtractShortPathName(FileName);
    end
    else
    begin
      FileName := '''' + FileName + '''';
    end;
  end;

  if OutputSuppression <> osShowAll then
  begin
    UnitNumber := -UnitNumber;
  end;

  Line := Ftype;
  if Length(Line) = 3 then
  begin
    Line := Line + '          ';
  end;
  if Length(Line) = 4 then
  begin
    Line := Line + '         ';
  end;
  while Length(Line) < 13 do
  begin
    Line := Line + ' ';
  end;
  if Line[Length(Line)] <> ' ' then
  begin
    Line := Line + ' ';
  end;
  if frmGoPhast.ModelSelection <> msModflow2015 then
  begin
    UnitNumberString := IntToStr(UnitNumber);
    while Length(UnitNumberString) < 6 do
    begin
      UnitNumberString := ' ' + UnitNumberString;
    end;
    Line := Line + UnitNumberString + ' ';
  end;
  Line := Line + FileName;
  if OutputSuppression <> osShowAll then
  begin
    Line := Line + ' ' + IntToStr(Ord(OutputSuppression) + 1);
  end;
  if (OutputSuppression <> osNoOutput)
    and (frmGoPhast.ModelSelection <> msModflow2015) then
  begin
    case Option of
      foNone: ;// do nothing
      foInput, foInputAlreadyExists:
        begin
          Line := Line + ' ' + 'OLD';
        end;
      foOutput:
        begin
          Line := Line + ' ' + 'REPLACE';
        end;
      else
        Assert(False);
    end;
  end;
  if frmGoPhast.ModelSelection = msModflow2015 then
  begin
    Line := '  ' + Line;
    case Option of
      foNone: Assert(False);
      foInput, foInputAlreadyExists:
        begin
          CurrentNameFileWriter.InputFiles.Add(Line);
        end;
      foOutput:
        begin
          CurrentNameFileWriter.OutputFiles.Add(Line);
        end;
      else
        Assert(False);
    end;
  end
  else
  begin
    CurrentNameFileWriter.NameFile.Add(Line);
  end;
end;

class procedure TCustomModflowWriter.WriteToNameFile(const Ftype: string;
  const UnitNumber: integer; FileName: string; const Option: TFileOption;
  AModel: TCustomModel;
  RelativeFileName: boolean = False);
//var
//  Line: string;
begin
  WriteToNameFile(Ftype, UnitNumber, FileName, Option, osShowAll, AModel,
    RelativeFileName);
end;

function TCustomModflowWriter.IPRN_Real: integer;
begin
  if Model.ModflowOutputControl.PrintInputArrays then
  begin
    result := 12;
  end
  else
  begin
    result := -1;
  end;
end;

function TCustomModflowWriter.IPRN_Integer: integer;
begin
  if Model.ModflowOutputControl.PrintInputArrays then
  begin
    result := 5;
  end
  else
  begin
    result := -1;
  end;
end;

function TCustomModflowWriter.IPRN_Mt3dms_Integer: integer;
begin
  if Model.ModflowOutputControl.PrintInputArrays then
  begin
    result := 5;
  end
  else
  begin
    result := 0;
  end;
end;

function TCustomModflowWriter.IPRN_Mt3dms_Real: integer;
begin
  if Model.ModflowOutputControl.PrintInputArrays then
  begin
    result := 12;
  end
  else
  begin
    result := 0;
  end;
end;

procedure TCustomModflowWriter.WriteU2DINTHeader(const Comment: string;
  ArrayType: TModflowArrayType; const MF6_ArrayName: string);
begin
  case FArrayWritingFormat of
    awfModflow:
      begin
        WriteString( 'INTERNAL 1 (FREE)   ');
        WriteInteger(IPRN_Integer);
      end;
    awfMt3dms:
      begin
        WriteString('       103         1                    ');
        WriteString(FixedFormattedInteger(IPRN_Integer, 10));
      end;
    awfModflow_6:
      begin
        WriteString('  ');
        WriteString(MF6_ArrayName);
        if ArrayType = matStructured then
        begin
          WriteString(' STRUCTURED');
        end;
        NewLine;
        WriteString('    INTERNAL 1 (FREE)   ');
        WriteInteger(IPRN_Integer);
        WriteString(' # ' + Comment);
        NewLine;
      end
    else
      Assert(False);
  end;
  if FArrayWritingFormat <> awfModflow_6 then
  begin
    WriteString( ' # ' + Comment);
    NewLine;
  end;
end;

procedure TCustomModflowWriter.WriteU2DRELHeader(const Comment: string;
  ArrayType: TModflowArrayType; const MF6_ArrayName: string);
begin
  case FArrayWritingFormat of
    awfModflow:
      begin
        WriteString( 'INTERNAL 1.0 (FREE)   ');
        WriteInteger(IPRN_Real);
      end;
    awfMt3dms:
      begin
        WriteString('       103        1.                    ');
        WriteString(FixedFormattedInteger(IPRN_Real, 10));
      end;
    awfModflow_6:
      begin
        if MF6_ArrayName <> '' then
        begin
          WriteString('  ');
          WriteString(MF6_ArrayName);
//          if ArrayType = matStructured then
          begin
            WriteString(' STRUCTURED');
          end;
          NewLine;
        end;
        WriteString('    INTERNAL 1.0 (FREE)   ');
        WriteInteger(IPRN_Real);
        WriteString(' # ' + Comment);
        NewLine;
      end
    else
      Assert(False);
  end;
  if FArrayWritingFormat <> awfModflow_6 then
  begin
    WriteString( ' # ' + Comment);
    NewLine;
  end;
end;

procedure TCustomModflowWriter.WriteConstantU2DINT(const Comment: string;
  const Value: integer; ArrayType: TModflowArrayType;
  const MF6_ArrayName: string);
begin
  case FArrayWritingFormat of
    awfModflow:
      begin
        WriteString( 'CONSTANT   ');
        WriteInteger(Value);
      end;
    awfMt3dms:
      begin
        WriteString('         0');
        WriteString(FixedFormattedInteger(Value, 10));
        WriteString('                    ');
        WriteString(FixedFormattedInteger(IPRN_Integer, 10));
      end;
    awfModflow_6:
      begin
        if MF6_ArrayName <> '' then
        begin
          WriteString('  ');
          WriteString(MF6_ArrayName);
          if ArrayType = matStructured then
          begin
            WriteString(' STRUCTURED');
          end;
          NewLine;
        end;

        WriteString('    CONSTANT ');
        WriteInteger(Value);

        WriteString(' # ');
        WriteString(Comment);

        NewLine;
      end
    else
      Assert(False);
  end;
  if FArrayWritingFormat <> awfModflow_6 then
  begin
    WriteString( ' # ' + Comment);
    NewLine;
  end;
end;

procedure TCustomModflowWriter.WriteConstantU2DREL(const Comment: string;
  const Value: double; ArrayType: TModflowArrayType; const MF6_ArrayName: string);
begin
  case FArrayWritingFormat of
    awfModflow:
      begin
        WriteString('CONSTANT   ');
        WriteFloat(Value);
      end;
    awfMt3dms:
      begin
        WriteString('         0');
        WriteF10Float(Value);
        WriteString('                    ');
        WriteI10Integer(IPRN_Real, 'IPRN');
      end;
    awfModflow_6:
      begin
        if MF6_ArrayName <> '' then
        begin
          WriteString('  ');
          WriteString(MF6_ArrayName);
          if ArrayType = matStructured then
          begin
            WriteString(' STRUCTURED');
          end;
          NewLine;
        end;

        WriteString('    CONSTANT ');
        WriteFloat(Value);

        WriteString(' # ');
        WriteString(Comment);

        NewLine;
      end
    else
      Assert(False);
  end;
  if Model.ModelSelection <> msModflow2015 then
  begin
    WriteString( ' # ' + Comment);
    NewLine;
  end;
end;

{ TNameFileWriter }

class function TNameFileWriter.Extension: string;
begin
  result := '.nam';
end;

procedure TNameFileWriter.CheckExternalFiles(const FileName: string);
var
  Directory: string;
  OldDir: string;
  Index: Integer;
  ALine: string;
  Splitter: TStringList;
  Fname: string;
  InputFile: Boolean;
  Option: string;
begin
  Directory := ExtractFileDir(FileName);
  Directory := IncludeTrailingPathDelimiter(Directory);
  OldDir := GetCurrentDir;
  try
    SetCurrentDir(Directory);
    Splitter := TStringList.Create;
    try
      Splitter.Delimiter := #9;
      for Index := 0 to Model.ModflowNameFileLines.Count - 1 do
      begin
        ALine := Model.ModflowNameFileLines[Index];
        if (ALine <> '') and (ALine[1] <> '#') then
        begin
          Splitter.DelimitedText := ALine;
          if Splitter.Count >= 3 then
          begin
            Fname := Splitter[2];
            if not FileExists(Fname) then
            begin
              InputFile := True;
              if Splitter.Count >= 4 then
              begin
                Option := Splitter[3];
                if SameText(Option, 'REPLACE') then
                begin
                  InputFile := False;
                end;
              end;
              if InputFile then
              begin
                frmErrorsAndWarnings.AddWarning(Model, MissingFile, Fname);
              end;
            end;
            Model.AddModelInputFile(ExpandFileName(Fname));
          end;
        end;
      end;
    finally
      Splitter.Free;
    end;
  finally
    SetCurrentDir(OldDir);
  end;
end;

procedure TNameFileWriter.InitilizeNameFile(const FileName: string;
  out OutputListFileName: string);
var
  CellFlowsName: string;
begin
//  Model.AddModelInputFile(FileName);
  ClearNameFile;
  AddNameFileComment(Format(StrNameFileForMODFLO,
    [DateToStr(Now), Model.ProgramName]));
  OutputListFileName := ChangeFileExt(FileName, '.lst');
  if Model.ModelSelection = msModflowFmp then
  begin
    WriteToNameFile(StrLIST, Model.UnitNumbers.UnitNumber(StrLIST),
      OutputListFileName, foOutput,
      Model.ModflowOutputControl.OutputSuppression, Model);
  end
  else
  begin
    WriteToNameFile(StrLIST, Model.UnitNumbers.UnitNumber(StrLIST),
      OutputListFileName, foOutput, Model);
  end;

  { TODO -cMODFLOW-2015 : This needs to change for MODFLOW-2015 }
  case Model.ModflowOutputControl.SaveCellFlows of
    csfNone:
      begin
        // do nothing
      end;
    csfBinary:
      begin
        CellFlowsName := ChangeFileExt(FileName, StrCbcExt);
        WriteToNameFile(StrDATABINARY,
          Model.UnitNumbers.UnitNumber(StrCBC), CellFlowsName, foOutput, Model);
      end;
    csfListing:
      begin
        // do nothing
      end;
    else
      begin
        Assert(False);
      end;
  end;
  if Model.ModflowNameFileLines.Count > 0 then
  begin
    CheckExternalFiles(FileName);
    if FModel.ModelSelection = msModflow2015 then
    begin
      InputFiles.Add('');
      InputFiles.Add('#Files generated outside of ' + Model.ProgramName);
      InputFiles.AddStrings(Model.ModflowNameFileLines);
      InputFiles.Add('');
      InputFiles.Add('#Files generated by ' + Model.ProgramName);
    end
    else
    begin
      NameFile.Add('');
      NameFile.Add('#Files generated outside of ' + Model.ProgramName);
      NameFile.AddStrings(Model.ModflowNameFileLines);
      NameFile.Add('');
      NameFile.Add('#Files generated by ' + Model.ProgramName);
    end;
  end;
end;

procedure TNameFileWriter.SaveNameFile(AFileName: string);
begin
  inherited;
  AFileName := AFileName + ArchiveExt;
  NameFile.SaveToFile(AFileName);
  Model.AddModelInputFile(AFileName);
end;

procedure TCustomModflowWriter.GetFlowUnitNumber(var UnitNumber: Integer);
begin

  case Model.ModflowOutputControl.SaveCellFlows of
    csfNone:
      begin
        UnitNumber := 0;
      end;
    csfBinary:
      begin
        UnitNumber := Model.UnitNumbers.UnitNumber(StrCBC);
      end;
    csfListing:
      begin
        UnitNumber := -1;
      end;
  else
    begin
      Assert(False);
    end;
  end;
end;

{ TCustomTransientWriter }

procedure TCustomParameterTransientWriter.ClearTimeLists(AModel: TBaseModel);
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  Boundary: TModflowBoundary;
begin
  for ScreenObjectIndex := 0 to Model.ScreenObjectCount - 1 do
  begin
    ScreenObject := Model.ScreenObjects[ScreenObjectIndex];
    if ScreenObject.Deleted then
    begin
      Continue;
    end;
    if not ScreenObject.UsedModels.UsesModel(Model) then
    begin
      Continue;
    end;
    Boundary := GetBoundary(ScreenObject);
    if Boundary <> nil then
    begin
      Boundary.ClearTimeLists(AModel);
    end;
  end;

end;

procedure TCustomTransientWriter.CountCells(var MaximumNumberOfCells: Integer);
var
  StressPeriodIndex: Integer;
  List: TValueCellList;
begin
  MaximumNumberOfCells := 0;
  for StressPeriodIndex := 0 to FValues.Count - 1 do
  begin
    List := FValues[StressPeriodIndex];
    if List.Count > MaximumNumberOfCells then
    begin
      MaximumNumberOfCells := List.Count;
    end;
    List.Cache;
  end;

end;

constructor TCustomTransientWriter.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FValues := TObjectList.Create;
end;

destructor TCustomTransientWriter.Destroy;
begin
  FValues.Free;
  inherited;
end;

function TCustomTransientWriter.GetOwnsValueContents: Boolean;
begin
  result := (FValues as TObjectList).OwnsObjects;
end;

function TCustomParameterTransientWriter.BoundariesPresent: boolean;
begin
  result := (FParamValues.Count > 0) or (FValues.Count > 0)
end;

procedure TCustomParameterTransientWriter.Evaluate;
var
  ScreenObjectIndex: Integer;
  ScreenObject: TScreenObject;
  ParamIndex: Integer;
  List: TList;
  Boundary: TModflowBoundary;
  NoAssignmentErrorRoot: string;
  NoDefinedErrorRoot: string;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    RemoveNoDefinedError(NoDefinedErrorRoot);
    NoAssignmentErrorRoot := Format(StrNoBoundaryConditio, [Package.PackageIdentifier]);
  //  NoAssignmentErrorRoot := 'No boundary conditions assigned to the '
  //    + Package.PackageIdentifier
  //    + ' because the object does not '
  //    + 'set the values of either enclosed or intersected cells.';
    frmProgressMM.AddMessage(Format(StrEvaluatingSData, [Package.PackageIdentifier]));
  //  frmProgressMM.AddMessage('Evaluating '
  //    + Package.PackageIdentifier + ' data.');
    for ScreenObjectIndex := 0 to Model.ScreenObjectCount - 1 do
    begin
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      ScreenObject := Model.ScreenObjects[ScreenObjectIndex];
      if ScreenObject.Deleted then
      begin
        Continue;
      end;
      if not ScreenObject.UsedModels.UsesModel(Model) then
      begin
        Continue;
      end;
      Boundary := GetBoundary(ScreenObject);
      if Boundary <> nil then
      begin
        if not ScreenObject.SetValuesOfEnclosedCells
          and not ScreenObject.SetValuesOfIntersectedCells then
        begin
          frmErrorsAndWarnings.AddError(Model, NoAssignmentErrorRoot,
            ScreenObject.Name, ScreenObject);
        end;
        frmProgressMM.AddMessage(Format(StrEvaluatingS,
          [ScreenObject.Name]));
        Boundary.GetCellValues(FValues, FParamValues, Model);
      end;
    end;
    for ParamIndex := 0 to FParamValues.Count - 1 do
    begin
      List := FParamValues.Objects[ParamIndex] as TList;
      While List.Count > FValues.Count do
      begin
        FValues.Add(TValueCellList.Create(CellType))
      end;
    end;
    for ParamIndex := 0 to FParamValues.Count - 1 do
    begin
      List := FParamValues.Objects[ParamIndex] as TList;
      While List.Count < FValues.Count do
      begin
        List.Add(TValueCellList.Create(CellType))
      end;
    end;
    if not BoundariesPresent then
    begin
      ShowNoBoundaryError(NoDefinedErrorRoot);
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

function TCustomParameterTransientWriter.ParameterCount: integer;
begin
  result := FParamValues.Count;
end;

procedure TCustomParameterTransientWriter.GetInstanceRoot(const PARNAM: string;
  ParamValues: TList; var InstanceRoot: string);
var
  InstanceName: string;
  PCount: Integer;
  MaxStressPeriodString: string;
  TerminalString: string;
begin
  PCount := FParameterNames.IndexOf(PARNAM);
  if PCount < 0 then
  begin
    PCount := FParameterNames.Add(PARNAM);
  end;
  Inc(PCount);
  MaxStressPeriodString := IntToStr(FModel.ModflowFullStressPeriods.Count);
  TerminalString := IntToStr(PCount) + '_';

  // Make sure the maximum length of the name of instance is <= 10.
  InstanceRoot := PARNAM;
  InstanceName := InstanceRoot + TerminalString + MaxStressPeriodString;
  While(Length(InstanceName)) > 10 do
  begin
    SetLength(InstanceRoot, Length(InstanceRoot)-1);
    InstanceName := InstanceRoot + TerminalString + MaxStressPeriodString;
  end;
  InstanceRoot := InstanceRoot + TerminalString;
end;

procedure TCustomParameterTransientWriter.GetInstanceName(
  var InstanceName: string;
  TimeIndex: Integer; InstanceRoot: string);
begin
  InstanceName := InstanceRoot + IntToStr(TimeIndex + 1);
  While (Length(InstanceName) > 10)
    or (FUsedInstanceNames.IndexOf(InstanceName) >= 0) do
  begin
    SetLength(InstanceRoot, Length(InstanceRoot) -1);
    Assert(InstanceRoot <> '');
    InstanceName := InstanceRoot + IntToStr(TimeIndex + 1);
  end;
  FUsedInstanceNames.Add(InstanceName);
end;

procedure TCustomParameterTransientWriter.GetNumCellsAndNumInstances(
  ParamValues: TList; var NUMINST, NLST: Integer);
var
  CellList: TValueCellList;
  TimeIndex: Integer;
begin
  NLST := 0;
  NUMINST := 0;
  for TimeIndex := 0 to ParamValues.Count - 1 do
  begin
    CellList := ParamValues[TimeIndex];
    if CellList.Count > NLST then
    begin
      NLST := CellList.Count;
    end;
    if CellList.Count > 0 then
    begin
      Inc(NUMINST);
    end;
    CellList.Cache;
  end;
end;

{ TCustomListWriter }

procedure TCustomListWriter.CountParametersAndParameterCells(
  var ParamCount, ParamCellCount: integer);
var
  ParamIndex: Integer;
  Times: TList;
  MaxCells: Integer;
  TimeIndex: Integer;
  Cells: TValueCellList;
begin
  ParamCount := 0;
  ParamCellCount := 0;
  for ParamIndex := 0 to FParamValues.Count - 1 do
  begin
    Times := FParamValues.Objects[ParamIndex] as TList;
    MaxCells := 0;
    for TimeIndex := 0 to Times.Count - 1 do
    begin
      Cells := Times[TimeIndex];
      if MaxCells < Cells.Count then
      begin
        MaxCells := Cells.Count;
      end;
    end;
    ParamCellCount := ParamCellCount + MaxCells * Times.Count;
    if MaxCells > 0 then
    begin
      Inc(ParamCount);
    end
    else
    begin
      // This is done to flag the parameter has having no cells
      // associated with it.  Later on, an error message will
      // be displayed about this problem.
      FParamValues[ParamIndex] := '';
    end;
  end;
end;

constructor TCustomListWriter.Create(Model: TCustomModel;
  EvaluationType: TEvaluationType);
begin
  inherited;
  FBoundNames := TStringList.Create;

  FObjectNames := TStringList.Create;
  FObjectNames.Sorted := True;
  FObjectNames.CaseSensitive := False;
end;

procedure TCustomPackageWriter.CheckCell(ValueCell: TValueCell;
  const PackageName: string);
var
  ActiveDataArray: TDataArray;
  WarningRoot: string;
  ErrorMessage: string;
begin
  ActiveDataArray := Model.DataArrayManager.GetDataSetByName(rsActive);
  Assert(ActiveDataArray <> nil);
  ActiveDataArray.Initialize;
  if not ActiveDataArray.BooleanData[ValueCell.Layer,
    ValueCell.Row, ValueCell.Column] then
  begin
    WarningRoot := Format(StrOneOrMoreBoundari, [PackageName]);
    if WarningRoot = FWarningRoot then
    begin
      WarningRoot := FWarningRoot;
    end
    else
    begin
      FWarningRoot := WarningRoot;
    end;
    ErrorMessage := Format(StrLayerRowCol,
      [ValueCell.Layer+1, ValueCell.Row+1, ValueCell.Column+1]);
    frmErrorsAndWarnings.AddWarning(Model, FWarningRoot, ErrorMessage);
  end;
end;

function TCustomPackageWriter.AquiferConductance(Layer, Row, Column: Integer): double;
var
  Packages: TModflowPackages;
  DataArray: TDataArray;
  Value: Double;
  Group: TLayerGroup;
  AquiferType: Integer;
begin
  result := 0;
  Packages := Model.ModflowPackages;
  if Packages.LpfPackage.IsSelected or Packages.UpwPackage.IsSelected
    or Packages.NpfPackage.IsSelected then
  begin
    DataArray := Model.DataArrayManager.GetDataSetByName(rsKx);
    Assert(DataArray <> nil);
    DataArray.Initialize;
    Value := DataArray.RealData[Layer, Row, Column];
    result := Value * Model.ModflowGrid.LayerThickness(Layer, Row, Column)
      * Min(Model.Grid.RowWidth[Row], Model.Grid.ColumnWidth[Column]);
  end
  else if Packages.BcfPackage.IsSelected then
  begin
    Group := Model.GetLayerGroupByLayer(Layer);
    AquiferType := Group.AquiferType;
    if (AquiferType = 1) and (Layer > 0) then
    begin
      AquiferType := 3;
    end;
    case AquiferType of
      0, 2:
        begin
          // Data set 5
          DataArray := Model.DataArrayManager.GetDataSetByName(StrTransmissivity);
          Assert(DataArray <> nil);
          DataArray.Initialize;
          Value := DataArray.RealData[Layer, Row, Column];
          result := Value
            * Min(Model.Grid.RowWidth[Row], Model.Grid.ColumnWidth[Column]);
        end;
      1, 3:
        begin
          // Data set 6
          DataArray := Model.DataArrayManager.GetDataSetByName(rsKx);
          Assert(DataArray <> nil);
          DataArray.Initialize;
          Value := DataArray.RealData[Layer, Row, Column];
          result := Value * Model.ModflowGrid.LayerThickness(Layer, Row, Column)
            * Min(Model.Grid.RowWidth[Row], Model.Grid.ColumnWidth[Column]);
        end;
      else
        begin
          Assert(False);
        end;
    end;
  end
  else if Packages.HufPackage.IsSelected then
  begin
    DataArray := Model.DataArrayManager.GetDataSetByName(StrHUFKxName);
    Assert(DataArray <> nil);
    DataArray.Initialize;
    Value := DataArray.RealData[Layer, Row, Column];
    result := Value * Model.ModflowGrid.LayerThickness(Layer, Row, Column)
      * Min(Model.Grid.RowWidth[Row], Model.Grid.ColumnWidth[Column]);
  end
  else
  begin
    Assert(False);
  end;
end;

function TCustomPackageWriter.AquiferKx(Layer, Row, Column: Integer): double;
var
  Packages: TModflowPackages;
  DataArray: TDataArray;
  Value: Double;
  Group: TLayerGroup;
  AquiferType: Integer;
begin
  result := 0;
  Packages := Model.ModflowPackages;
  if Packages.LpfPackage.IsSelected or Packages.UpwPackage.IsSelected then
  begin
    DataArray := Model.DataArrayManager.GetDataSetByName(rsKx);
    Assert(DataArray <> nil);
    DataArray.Initialize;
    result := DataArray.RealData[Layer, Row, Column];
  end
  else if Packages.BcfPackage.IsSelected then
  begin
    Group := Model.GetLayerGroupByLayer(Layer);
    AquiferType := Group.AquiferType;
    if (AquiferType = 1) and (Layer > 0) then
    begin
      AquiferType := 3;
    end;
    case AquiferType of
      0, 2:
        begin
          // Data set 5
          DataArray := Model.DataArrayManager.GetDataSetByName(StrTransmissivity);
          Assert(DataArray <> nil);
          DataArray.Initialize;
          Value := DataArray.RealData[Layer, Row, Column];
          result := Value / Model.ModflowGrid.LayerThickness(Layer, Row, Column);
        end;
      1, 3:
        begin
          // Data set 6
          DataArray := Model.DataArrayManager.GetDataSetByName(rsKx);
          Assert(DataArray <> nil);
          DataArray.Initialize;
          result := DataArray.RealData[Layer, Row, Column];
        end;
      else
        begin
          Assert(False);
        end;
    end;
  end
  else if Packages.HufPackage.IsSelected then
  begin
    DataArray := Model.DataArrayManager.GetDataSetByName(StrHUFKxName);
    Assert(DataArray <> nil);
    DataArray.Initialize;
    result := DataArray.RealData[Layer, Row, Column];
  end
  else
  begin
    Assert(False);
  end;
end;

procedure TCustomListWriter.CountCells(var MaximumNumberOfCells: Integer);
var
  List: TValueCellList;
  NumberInStressPeriod: Integer;
  ParamIndex: Integer;
  ParamValues: TList;
  StressPeriodIndex: Integer;
  MaximumParamCells : integer;
begin
  inherited CountCells(MaximumNumberOfCells);

//  if Model.ModelSelection <> msModflow2015 then
  begin
    MaximumParamCells := 0;
    for StressPeriodIndex := 0 to FValues.Count - 1 do
    begin
      NumberInStressPeriod := 0;
      for ParamIndex := 0 to FParamValues.Count - 1 do
      begin
        ParamValues := FParamValues.Objects[ParamIndex] as TList;
        Assert(ParamValues.Count = FValues.Count);
        List := ParamValues[StressPeriodIndex];
        NumberInStressPeriod := NumberInStressPeriod + List.Count;
        List.Cache;
      end;
      if NumberInStressPeriod > MaximumParamCells then
      begin
        MaximumParamCells := NumberInStressPeriod;
      end;
    end;

    MaximumNumberOfCells := MaximumNumberOfCells + MaximumParamCells;
  end;
end;

procedure TCustomListWriter.GetOption(var Option: string);
begin
  Option := ' AUXILIARY IFACE';
  if not Model.ModflowOutputControl.PrintInputCellLists then
  begin
    Option := Option + ' NOPRINT';
  end;
end;

procedure TCustomListWriter.UpdateDisplay(
  TimeLists: TModflowBoundListOfTimeLists; ParameterIndicies: TByteSet);
var
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: integer;
  ParameterValues: TList;
  PARTYP: String;
  ErrorMessage: string;
  TimeIndex: Integer;
  CellList: TValueCellList;
  DataArrayList: TList;
  TimeListIndex: Integer;
  DisplayTimeList: TModflowBoundaryDisplayTimeList;
  DataArray: TModflowBoundaryDisplayDataArray;
begin
  // Quit if the package isn't used.
  if not Package.IsSelected then
  begin
    UpdateNotUsedDisplay(TimeLists);
    Exit;
  end;
  frmErrorsAndWarnings.BeginUpdate;
  try
    DataArrayList := TList.Create;
    try
      // evaluate all the data used in the package.
      Evaluate;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      ClearTimeLists(Model);

      // Set PARTYP.
      case ParameterType of
        ptUndefined..ptLPF_VKCB:
          begin
            Assert(False);
          end;
        ptRch, ptEvt, ptETS, ptCHD..ptDRT, ptSTR, ptQMAX:
          begin
            PARTYP := ' ' + ParmeterTypeToStr(ParameterType);
          end
        Else Assert(False);
      end;
      // Set the error message.
      ErrorMessage := Format(StrOneOrMoreSParam, [Trim(PARTYP)]);
      frmErrorsAndWarnings.RemoveWarningGroup(Model, ErrorMessage);


      // loop over the parameters
      for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
      begin
        Param := Model.ModflowTransientParameters[ParamIndex];
        // Consider only those parameters that match the parameter type for the
        // current package.
        if Param.ParameterType = ParameterType then
        begin
          Position := ParamValues.IndexOf(Param.ParameterName);
          // The parameter name is erased from FParamValues in
          // CountParametersAndParameterCells if there are no cells
          // associated with it.
          if Position < 0 then
          begin
            if frmErrorsAndWarnings <> nil then
            begin
              frmErrorsAndWarnings.AddWarning(Model,
                ErrorMessage, Param.ParameterName);
            end;
            Continue;
          end;
          ParameterValues := ParamValues.Objects[Position] as TList;
          if ParameterValues.Count = 0 then
          begin
            Continue;
          end;
          // ParameterValues contains lists of cells for a parameter for
          // each stress period.
          for TimeListIndex := 0 to TimeLists.Count - 1 do
          begin
            DisplayTimeList := TimeLists[TimeListIndex];
            Assert(ParameterValues.Count = DisplayTimeList.Count);
          end;
          // For each stress period, transfer values from
          // the cells lists to the data arrays.
          for TimeIndex := 0 to ParameterValues.Count - 1 do
          begin
            CellList := ParameterValues[TimeIndex];
            if CellList.Count > 0 then
            begin
              DataArrayList.Clear;
              for TimeListIndex := 0 to TimeLists.Count - 1 do
              begin
                DisplayTimeList := TimeLists[TimeListIndex];
                DataArray := DisplayTimeList[TimeIndex]
                  as TModflowBoundaryDisplayDataArray;
                DataArrayList.Add(DataArray);
              end;
              UpdateCellDisplay(CellList, DataArrayList,
                ParameterIndicies, Param);
            end;
          end;
        end;
      end;
      // Values contains lists of cells not associated with any parameter for
      // each stress period.
      for TimeListIndex := 0 to TimeLists.Count - 1 do
      begin
        DisplayTimeList := TimeLists[TimeListIndex];
        // Values.Count can be zero if no objects define the boundary condition.
        if (Values.Count <> 0) or (DisplayTimeList.Count = 0) then
        begin
          Assert(Values.Count = DisplayTimeList.Count);
        end;
      end;

      // For each stress period, transfer values from
      // the cells lists to the data arrays.
      for TimeIndex := 0 to Values.Count - 1 do
      begin
        CellList := Values[TimeIndex];
        if CellList.Count > 0 then
        begin
          DataArrayList.Clear;
          for TimeListIndex := 0 to TimeLists.Count - 1 do
          begin
            DisplayTimeList := TimeLists[TimeListIndex];
            DataArray := DisplayTimeList[TimeIndex]
              as TModflowBoundaryDisplayDataArray;
            DataArrayList.Add(DataArray);
          end;
          UpdateCellDisplay(CellList, DataArrayList, ParameterIndicies);
        end;
      end;
      // Mark all the data arrays and time lists as up to date.
      for TimeListIndex := 0 to TimeLists.Count - 1 do
      begin
        DisplayTimeList := TimeLists[TimeListIndex];
        for TimeIndex := 0 to DisplayTimeList.Count - 1 do
        begin
          DataArray := DisplayTimeList[TimeIndex]
            as TModflowBoundaryDisplayDataArray;
          DataArray.UpToDate := True;
        end;
        DisplayTimeList.SetUpToDate(True);
      end;
    finally
      DataArrayList.Free;
    end;
    if frmErrorsAndWarnings.HasMessages then
    begin
      frmErrorsAndWarnings.Show;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TCustomListWriter.WriteMF6_ListParm(DataSetIdentifier,
  VariableIdentifiers, ErrorRoot: string; const TimeIndex: integer);
var
  ErrorMessage: string;
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: Integer;
  ParamValues: TList;
//  TimeIndex: Integer;
  CellList: TValueCellList;
  PARTYP: string;
  NUMINST: Integer;
  NLST: Integer;
//  DataSetIdentifier: string;
//  MultiplierArrayNames: TTransientMultCollection;
//  ZoneArrayNames: TTransientZoneCollection;
begin
  case ParameterType of
    ptUndefined..ptLPF_VKCB: Assert(False);
    ptRch, ptEvt, ptETS, ptCHD..ptDRT, ptQMAX: PARTYP := ' '
      + ParmeterTypeToStr(ParameterType);
    Else Assert(False);
  end;
  ErrorMessage := Format(ErrorRoot, [Trim(PARTYP)]);
  for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
  begin
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Param := Model.ModflowTransientParameters[ParamIndex];
    if Param.ParameterType = ParameterType then
    begin
      Position := FParamValues.IndexOf(Param.ParameterName);
      // The parameter name is erased from FParamValues in
      // CountParametersAndParameterCells if there are no cells
      // associated with it.
      if Position < 0 then
      begin
        if frmErrorsAndWarnings <> nil then
        begin
          frmErrorsAndWarnings.AddWarning(Model,
            ErrorMessage, Param.ParameterName);
        end;
        Continue;
      end;
      ParamValues := FParamValues.Objects[Position] as TList;
      GetNumCellsAndNumInstances(ParamValues, NUMINST, NLST);
      Assert(ParamValues.Count > 0);
//      for TimeIndex := 0 to ParamValues.Count - 1 do
//      begin
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
        CellList := ParamValues[TimeIndex];
//        CellList.CheckRestore;
        if CellList.Count > 0 then
        begin
          WriteParameterCells(CellList, NLST, VariableIdentifiers,
            DataSetIdentifier, umAssign, nil, nil);
        end;
        CellList.Cache;
//      end;
    end;
  end;

end;

procedure TCustomListWriter.WriteParameterDefinitions(const DS3, DS3Instances,
  DS4A, DataSetIdentifier, VariableIdentifiers, ErrorRoot: string;
  AssignmentMethod: TUpdateMethod;
  MultiplierArrayNames: TTransientMultCollection;
  ZoneArrayNames: TTransientZoneCollection);
var
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: Integer;
  ParamValues: TList;
  PARNAM: string;
  NUMINST: Integer;
  NLST: Integer;
  Parval: Double;
  InstanceRoot: string;
  TimeIndex: Integer;
  CellList: TValueCellList;
  InstanceName: string;
  PARTYP: string;
  ErrorMessage: string;
begin
  case ParameterType of
    ptUndefined..ptLPF_VKCB: Assert(False);
    ptRch, ptEvt, ptETS, ptCHD..ptDRT, ptQMAX: PARTYP := ' '
      + ParmeterTypeToStr(ParameterType);
    Else Assert(False);
  end;
  ErrorMessage := Format(ErrorRoot, [Trim(PARTYP)]);
  for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
  begin
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Param := Model.ModflowTransientParameters[ParamIndex];
    if Param.ParameterType = ParameterType then
    begin
      Position := FParamValues.IndexOf(Param.ParameterName);
      // The parameter name is erased from FParamValues in
      // CountParametersAndParameterCells if there are no cells
      // associated with it.
      if Position < 0 then
      begin
        if frmErrorsAndWarnings <> nil then
        begin
          frmErrorsAndWarnings.AddWarning(Model,
            ErrorMessage, Param.ParameterName);
        end;
        Continue;
      end;
      ParamValues := FParamValues.Objects[Position] as TList;
      Assert(ParamValues.Count > 0);
      // Data set 3
      PARNAM := Param.ParameterName;
      frmProgressMM.AddMessage(Format(StrWritingParamter, [PARNAM]));
      if Length(PARNAM) > 10 then
      begin
        SetLength(PARNAM, 10);
      end;
      GetNumCellsAndNumInstances(ParamValues, NUMINST, NLST);
      Parval := Param.Value;
      WriteString(PARNAM);
      WriteString(PARTYP);
      WriteFloat(Parval);
      WriteInteger(NLST);
      if NUMINST > 1 then
      begin
        WriteString(' INSTANCES');
        WriteInteger(NUMINST);
      end;
      WriteString(DS3);
      if NUMINST > 1 then
      begin
        WriteString(DS3Instances);
      end;
      NewLine;

      Model.WritePValAndTemplate(PARNAM,PARVAL);

      // Make sure the maximum length of the name of instance is <= 10.
      GetInstanceRoot(PARNAM, ParamValues, InstanceRoot);

      DoBeforeWriteParamCells;

      // Data sets 4a and 4b
      for TimeIndex := 0 to ParamValues.Count - 1 do
      begin
        Application.ProcessMessages;
        if not frmProgressMM.ShouldContinue then
        begin
          Exit;
        end;
        CellList := ParamValues[TimeIndex];
//        CellList.CheckRestore;
        if CellList.Count > 0 then
        begin
          // Data set 4a.
          if NUMINST > 1 then
          begin
            GetInstanceName(InstanceName, TimeIndex, InstanceRoot);
            WriteString(InstanceName);
            WriteString(DS4A + ' (Parameter instance for stress period '
              + IntToStr(TimeIndex+1) + ')');
            NewLine;
          end;
          // Data set 4b.
          WriteParameterCells(CellList, NLST, VariableIdentifiers,
            DataSetIdentifier, umAssign, MultiplierArrayNames, ZoneArrayNames);
        end;
        CellList.Cache;
      end;
    end;
  end;
end;

destructor TCustomListWriter.Destroy;
begin
  FObjectNames.Free;
  FBoundNames.Free;
  inherited;
end;

procedure TCustomListWriter.WriteAndCheckCells(const VariableIdentifiers: string;
  const DataSetIdentifier: string; List: TValueCellList; TimeIndex: integer);
var
  CellIndex: Integer;
  Cell: TValueCell;
begin
  for CellIndex := 0 to List.Count - 1 do
  begin
    Cell := List[CellIndex] as TValueCell;
    WriteCell(Cell, DataSetIdentifier, VariableIdentifiers);
    CheckCell(Cell, Package.PackageIdentifier);
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
  end;
end;

procedure TCustomListWriter.DoBeforeWriteCells;
begin
  // overriden in Farm process and DRN, RIV, GHB, DRT.
end;

procedure TCustomListWriter.DoBeforeWriteParamCells;
begin
  // overriden in Farm process
end;

procedure TCustomListWriter.WriteCustomStressPeriod(TimeIndex: Integer);
begin

end;

procedure TCustomListWriter.WriteStressPeriods(const VariableIdentifiers,
  DataSetIdentifier, DS5, D7PNameIname, D7PName: string);
var
  ITMP: Integer;
  NP: Integer;
  List: TValueCellList;
  ParamValues: TList;
  ParamIndex: Integer;
  ParametersUsed: TStringList;
  TimeIndex: Integer;
begin
  FUsedInstanceNames.Clear;
  ParamValues := TList.Create;
  try
    for TimeIndex := 0 to FValues.Count - 1 do
    begin
      Application.ProcessMessages;
      if not frmProgressMM.ShouldContinue then
      begin
        Exit;
      end;
      frmProgressMM.AddMessage(Format(StrWritingStressPer, [TimeIndex+1]));
      ParametersUsed := TStringList.Create;
      try
        RetrieveParametersForStressPeriod(D7PNameIname, D7PName, TimeIndex,
          ParametersUsed, ParamValues, False);

        NP := ParametersUsed.Count;
        GetITMP(ITMP, TimeIndex, List);
        if (ITMP = 0) and (NP = 0) then
        begin
          frmErrorsAndWarnings.AddWarning(Model,
            Format(StrNoBoundaryConditio1, [Package.PackageIdentifier]),
            Format(StrStressPeriod0d, [TimeIndex+1]));
        end;

        if Model.ModelSelection <> msModflow2015 then
        begin
          // data set 5;
          WriteInteger(ITMP);
          WriteInteger(NP);
          if DS5 <> '' then
          begin
            WriteString(DS5 + ' Stress period ' + IntToStr(TimeIndex+1));
          end;
          NewLine;
        end;

        if Model.ModelSelection = msModflow2015 then
        begin
          if (ITMP < 0) and (NP = 0) then
          begin
            Continue;
          end;
          WriteString('BEGIN PERIOD ');
          WriteInteger(TimeIndex+1);
          NewLine;
        end;
        // data set 6
        if ITMP > 0 then
        begin
          DoBeforeWriteCells;
          WriteAndCheckCells(VariableIdentifiers, DataSetIdentifier, List,
            TimeIndex);
          Application.ProcessMessages;
          if not frmProgressMM.ShouldContinue then
          begin
            Exit;
          end;
        end;
        if Model.ModelSelection = msModflow2015 then
        begin
          WriteMF6_ListParm(DataSetIdentifier, VariableIdentifiers,
            StrOneOrMoreSParam, TimeIndex);
          WriteString('END PERIOD');
          NewLine;
          NewLine;
        end;
        if TimeIndex = FValues.Count - 1 then
        begin
          if List <> nil then
          begin
            List.Cache;
          end;
        end;
        // data set 7
        if Model.ModelSelection <> msModflow2015 then
        begin
          for ParamIndex := 0 to ParametersUsed.Count - 1 do
          begin
            WriteString(ParametersUsed[ParamIndex]);
            NewLine;
            Application.ProcessMessages;
            if not frmProgressMM.ShouldContinue then
            begin
              Exit;
            end;
          end;
        end;
      finally
        ParametersUsed.Free;
      end;
      WriteCustomStressPeriod(TimeIndex);

    end;
  finally
    ParamValues.Free;
  end;
end;

{ TCustomTransientArrayWriter }
procedure TCustomTransientArrayWriter.EvaluateParameterCells(
  CellList: TValueCellList; DataArray: TModflowBoundaryDisplayDataArray;
  Param: TModflowTransientListParameter; AssignmentMethod: TUpdateMethod);
var
  CellIndex: Integer;
  Cell: TValueCell;
  Annotation: string;
  NewAnnotation: string;
  OldAnnotation: string;
  AnnotationList: TStringList;
  GroupedAnnotation: string;
  GroupIndex: Integer;
begin
  if CellList.Count = 0 then
  begin
    Exit;
  end;

  AnnotationList := TStringList.Create;
  try
    AnnotationList.Sorted := True;
    Annotation := '';
    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex] as TValueCell;
      if (AssignmentMethod = umAdd) and DataArray.IsValue[0, Cell.Row, Cell.Column] then
      begin
        DataArray.RealData[0, Cell.Row, Cell.Column] :=
          DataArray.RealData[0, Cell.Row, Cell.Column]
          + Cell.RealValue[0, Model] * Param.Value;
      end
      else
      begin
        DataArray.RealData[0, Cell.Row, Cell.Column] :=
          Cell.RealValue[0, Model] * Param.Value;
      end;
      NewAnnotation := Cell.RealAnnotation[0, Model]
        + ' (multiplied by ' + Param.ParameterName + ' = '
        + FloatToStr(Param.Value) + ')';
      // reduce memory usage by preventing multiple copies of the same
      // annotation from being saved.
      if Annotation <> NewAnnotation then
      begin
        Annotation := NewAnnotation;
      end;
      if (AssignmentMethod = umAdd) and DataArray.IsValue[0, Cell.Row, Cell.Column] then
      begin
        OldAnnotation := DataArray.Annotation[0, Cell.Row, Cell.Column];
        GroupedAnnotation := OldAnnotation
          + sLineBreak + 'Plus' + sLineBreak + Annotation;
        // reduce memory usage by preventing the number of strings from
        // getting out of hand.
        GroupIndex := AnnotationList.IndexOf(GroupedAnnotation);
        if GroupIndex >= 0 then
        begin
          GroupedAnnotation := AnnotationList[GroupIndex];
        end
        else
        begin
          AnnotationList.Add(GroupedAnnotation)
        end;
        DataArray.Annotation[0, Cell.Row, Cell.Column] := GroupedAnnotation;
      end
      else
      begin
        DataArray.Annotation[0, Cell.Row, Cell.Column] := Annotation;
      end;
      DataArray.CellCount[0, Cell.Row, Cell.Column] := 1;
    end;

    DataArray.UpToDate := True;
  finally
    AnnotationList.Free;
  end;

end;

procedure TCustomTransientArrayWriter.WriteParameterCells(
  CellList: TValueCellList; NLST: integer; const VariableIdentifiers,
  DataSetIdentifier: string; AssignmentMethod: TUpdateMethod;
  MultiplierArrayNames: TTransientMultCollection;
  ZoneArrayNames: TTransientZoneCollection);
var
  MultiplierArray: TDataArray;
  ZoneArray: TDataArray;
  CellIndex: Integer;
  Cell: TValueCell;
  RowIndex: Integer;
  ColIndex: Integer;
  IdenticalZoneArray: TDataArray;
  IdenticalMultiplierArray: TDataArray;
  NewMultName: string;
  MultPrefix: string;
  ZonePrefix: string;
  NewZoneName: string;
  MultItem: TTransientMultItem;
  TransMultWriter: TTransientArrayWriter;
  ZoneItem: TTransientZoneItem;
  DummyAnnotation: string;
begin
  if CellList.Count = 0 then
  begin
    Exit;
  end;
  DummyAnnotation := 'none';
  MultiplierArray := TDataArray.Create(Model);
  ZoneArray:= TDataArray.Create(Model);
  try
    MultPrefix := Prefix + '_Mult_';
    NewMultName := MultPrefix
      + IntToStr(Model.TransientMultiplierArrays.Count + 1);
    while (Length(NewMultName) > 10) and (Length(MultPrefix) > 0) do
    begin
      MultPrefix := Copy(MultPrefix, 1, Length(MultPrefix)-1);
      NewMultName := MultPrefix
        + IntToStr(Model.TransientMultiplierArrays.Count + 1);
    end;

    ZonePrefix := Prefix + '_Zone_';
    NewZoneName := ZonePrefix
      + IntToStr(Model.TransientZoneArrays.Count + 1);
    while (Length(NewZoneName) > 10) and (Length(ZonePrefix) > 0) do
    begin
      ZonePrefix := Copy(ZonePrefix, 1, Length(ZonePrefix)-1);
      NewZoneName := ZonePrefix
        + IntToStr(Model.TransientZoneArrays.Count + 1);
    end;

    MultiplierArray.Name := NewMultName;
    ZoneArray.Name := NewZoneName;

    MultiplierArray.Orientation := dsoTop;
    ZoneArray.Orientation := dsoTop;

    MultiplierArray.EvaluatedAt := eaBlocks;
    ZoneArray.EvaluatedAt := eaBlocks;

    MultiplierArray.DataType := rdtDouble;
    ZoneArray.DataType := rdtBoolean;

    MultiplierArray.UpdateDimensions(1, Model.ModflowGrid.RowCount,
      Model.ModflowGrid.ColumnCount, True);
    ZoneArray.UpdateDimensions(1, Model.ModflowGrid.RowCount,
      Model.ModflowGrid.ColumnCount, True);

    MultiplierArray.UpToDate := True;
    ZoneArray.UpToDate := True;

    // initialize multiplier and zone arrays.
    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        MultiplierArray.RealData[0,RowIndex,ColIndex] := 0;
        ZoneArray.BooleanData[0,RowIndex,ColIndex] := False;
        MultiplierArray.Annotation[0,RowIndex,ColIndex] := DummyAnnotation;
        ZoneArray.Annotation[0,RowIndex,ColIndex] := DummyAnnotation;
      end;
    end;

    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex];
      case AssignmentMethod of
        umAssign:
          begin
            MultiplierArray.RealData[0, Cell.Row, Cell.Column] :=
              Cell.RealValue[0, Model];
          end;
        umAdd:
          begin
            MultiplierArray.RealData[0, Cell.Row, Cell.Column] :=
              MultiplierArray.RealData[0, Cell.Row, Cell.Column]
              + Cell.RealValue[0, Model];
          end;
        else Assert(False);
      end;
      ZoneArray.BooleanData[0, Cell.Row, Cell.Column] := True;
    end;

    MultiplierArray.UpToDate := True;
    ZoneArray.UpToDate := True;
    if ParameterType in [ptRCH, ptEVT, ptETS] then
    begin
      Model.AdjustDataArray(MultiplierArray);
      Model.AdjustDataArray(ZoneArray);
    end;
    MultiplierArray.CheckIfUniform;
    if (MultiplierArray.IsUniform = iuTrue) and
      (MultiplierArray.RealData[0,0,0] = 1) then
    begin
      WriteString('NONE ');
    end
    else
    begin
      IdenticalMultiplierArray := Model.
        IndenticalTransientMultiplierArray(MultiplierArray);
      if IdenticalMultiplierArray = nil then
      begin
        Assert(Length(MultiplierArray.Name) <= 10);
        WriteString(MultiplierArray.Name);

        MultItem := MultiplierArrayNames.Add;
        MultItem.ArrayName := MultiplierArray.Name;
        MultItem.Uniform := CheckArrayUniform(0, MultiplierArray);
        if MultItem.Uniform then
        begin
          MultItem.UniformValue := MultiplierArray.RealData[0,0,0];
        end
        else
        begin
          TransMultWriter := TTransientArrayWriter.Create(Model, FEvaluationType);
          try
            MultItem.FileName :=  TransMultWriter.WriteFile(FNameOfFile,
              TModflowMultiplierWriter.ArrayType, MultiplierArray)
          finally
            TransMultWriter.Free;
          end;
        end;

        WriteString(' ');
        MultiplierArray.CacheData;
        Model.TransientMultiplierArrays.Add(MultiplierArray);
        MultiplierArray := nil;
      end
      else
      begin
        WriteString(IdenticalMultiplierArray.Name);
        WriteString(' ');
      end;
    end;

    ZoneArray.UpToDate := True;
    ZoneArray.CheckIfUniform;
    if (ZoneArray.IsUniform = iuTrue) and
      (ZoneArray.BooleanData[0,0,0] = True) then
    begin
      WriteString('ALL');
    end
    else
    begin
      IdenticalZoneArray := Model.IndenticalTransientZoneArray(ZoneArray);
      if IdenticalZoneArray = nil then
      begin
        Assert(Length(ZoneArray.Name) <= 10);
        WriteString(ZoneArray.Name);
//        ZoneArrayNames.Add(ZoneArray.Name);

        ZoneItem := ZoneArrayNames.Add;
        ZoneItem.ArrayName := ZoneArray.Name;
        ZoneItem.Uniform := CheckArrayUniform(0, ZoneArray);
        if ZoneItem.Uniform then
        begin
          ZoneItem.UniformValue := ZoneArray.IntegerData[0,0,0];
        end
        else
        begin
          TransMultWriter := TTransientArrayWriter.Create(Model, FEvaluationType);
          try
            ZoneItem.FileName :=  TransMultWriter.WriteFile(FNameOfFile,
              TModflowZoneWriter.ArrayType, ZoneArray)
          finally
            TransMultWriter.Free;
          end;
        end;


        WriteString(' 1');
        ZoneArray.CacheData;
        Model.TransientZoneArrays.Add(ZoneArray);
        ZoneArray := nil;
      end
      else
      begin
        WriteString(IdenticalZoneArray.Name);
        WriteString(' 1');
      end;
    end;

    NewLine;
  finally
    MultiplierArray.Free;
    ZoneArray.Free
  end;
end;

procedure TCustomTransientArrayWriter.EvaluateParameterDefinitions(List: TList;
  const ErrorRoot: string; AssignmentMethod: TUpdateMethod);
var
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: Integer;
  ParameterValues: TList;
  NUMINST: Integer;
  NCLU: Integer;
  TimeIndex: Integer;
  CellList: TValueCellList;
  PARTYP: string;
  ErrorMessage: string;
  DataArray: TModflowBoundaryDisplayDataArray;
  DataArrayList: TObjectList;
  SkippedParamWarning: string;
  NoParametersError: string;
  ParameterActive: Boolean;
  ParametersUsed: Boolean;
begin
  frmErrorsAndWarnings.BeginUpdate;
  try
    case ParameterType of
      ptUndefined..ptLPF_VKCB: Assert(False);
      ptRCH, ptEVT, ptETS, ptCHD..ptDRT, ptQMAX: PARTYP := ' '
        + ParmeterTypeToStr(ParameterType);
      Else Assert(False);
    end;
    ErrorMessage := Format(ErrorRoot, [Trim(PARTYP)]);
    SkippedParamWarning := Format(StrTheFollowingParame, [Trim(PARTYP)]);
    NoParametersError := Format(StrNoParametersAreBe, [Trim(PARTYP)]);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, ErrorMessage);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, SkippedParamWarning);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, NoParametersError);

    ParameterActive := False;
    ParametersUsed := False;
    for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
    begin
      Param := Model.ModflowTransientParameters[ParamIndex];
      if Param.ParameterType = ParameterType then
      begin
        ParametersUsed := True;
        Position := ParamValues.IndexOf(Param.ParameterName);
        // The parameter name is erased from ParamValues in
        // CountParametersAndParameterCells if there are no cells
        // associated with it.
        if Position < 0 then
        begin
          frmErrorsAndWarnings.AddWarning(Model,
            ErrorMessage, Param.ParameterName);
          Continue;
        end;
        ParameterValues := ParamValues.Objects[Position] as TList;
        if ParameterValues.Count = 0 then
        begin
          Continue;
        end;
        ParameterActive := True;
        Assert(ParameterValues.Count > 0);
        // Data set 3
        GetNumCellsAndNumInstances(ParameterValues, NUMINST, NCLU);
        if NCLU > 0 then
        begin
          NCLU := 1;
          // Make sure the maximum length of the name of instance is <= 10.
    //      GetInstanceRoot(PARNAM, ParameterValues, InstanceRoot);
          // Data sets 4a and 4b
          for TimeIndex := 0 to ParameterValues.Count - 1 do
          begin
            if List.Count > TimeIndex then
            begin
              DataArrayList := List[TimeIndex];
            end
            else
            begin
              DataArrayList:= TObjectList.Create;
              List.Add(DataArrayList);
            end;
            CellList := ParameterValues[TimeIndex];
            if CellList.Count > 0 then
            begin
              // Data set 4a
              DataArray:= TModflowBoundaryDisplayDataArray.Create(Model);
              DataArray.Orientation := dso3D;
              DataArray.EvaluatedAt := eaBlocks;
              DataArray.UpdateDimensions(Model.ModflowGrid.LayerCount,
                Model.ModflowGrid.RowCount,
                Model.ModflowGrid.ColumnCount);
              DataArrayList.Add(DataArray);
              EvaluateParameterCells(CellList, DataArray, Param, AssignmentMethod);
              DataArray.CacheData;
            end;
          end;
        end
        else
        begin
          frmErrorsAndWarnings.AddWarning(Model,
            SkippedParamWarning, Param.ParameterName);
        end;
      end;
    end;
    if ParametersUsed and not ParameterActive then
    begin
      frmErrorsAndWarnings.AddError(Model, NoParametersError,
        NoParametersError);
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

function TCustomTransientArrayWriter.ParameterCount: integer;
var
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: Integer;
  ParameterValues: TList;
  NUMINST: Integer;
  NCLU: Integer;
begin
  result := 0;
  for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
  begin
    Param := Model.ModflowTransientParameters[ParamIndex];
    if Param.ParameterType = ParameterType then
    begin
      Position := ParamValues.IndexOf(Param.ParameterName);
      // The parameter name is erased from ParamValues in
      // CountParametersAndParameterCells if there are no cells
      // associated with it.
      if Position < 0 then
      begin
//        if frmErrorsAndWarnings <> nil then
//        begin
//          frmErrorsAndWarnings.AddWarning(Model,
//            ErrorMessage, Param.ParameterName);
//        end;
        Continue;
      end;
      ParameterValues := ParamValues.Objects[Position] as TList;
      if ParameterValues.Count = 0 then
      begin
        Continue;
      end;
      Assert(ParameterValues.Count > 0);
      // Data set 3
      GetNumCellsAndNumInstances(ParameterValues, NUMINST, NCLU);
      if NCLU > 0 then
      begin
        Inc(result);
      end;
    end;
  end;

end;

procedure TCustomTransientArrayWriter.WriteParameterDefinitions(
  const DS3, DS3Instances, DS4A, DataSetIdentifier,
  VariableIdentifiers, ErrorRoot: string; AssignmentMethod: TUpdateMethod;
  MultiplierArrayNames: TTransientMultCollection;
  ZoneArrayNames: TTransientZoneCollection);
var
  ParamIndex: Integer;
  Param: TModflowTransientListParameter;
  Position: Integer;
  ParameterValues: TList;
  PARNAM: string;
  NUMINST: Integer;
  NCLU: Integer;
  Parval: Double;
  InstanceRoot: string;
  TimeIndex: Integer;
  CellList: TValueCellList;
  InstanceName: string;
  PARTYP: string;
  ErrorMessage: string;
  SkippedParamWarning: string;
begin
  case ParameterType of
    ptUndefined..ptLPF_VKCB: Assert(False);
    ptRCH, ptEVT, ptETS, ptCHD..ptDRT, ptQMAX: PARTYP := ' '
      + ParmeterTypeToStr(ParameterType);
    Else Assert(False);
  end;
  ErrorMessage := Format(ErrorRoot, [Trim(PARTYP)]);
  SkippedParamWarning := Format(StrTheFollowingParame, [Trim(PARTYP)]);
  frmErrorsAndWarnings.RemoveWarningGroup(Model, ErrorMessage);
  frmErrorsAndWarnings.RemoveWarningGroup(Model, SkippedParamWarning);
  for ParamIndex := 0 to Model.ModflowTransientParameters.Count - 1 do
  begin
    Application.ProcessMessages;
    if not frmProgressMM.ShouldContinue then
    begin
      Exit;
    end;
    Param := Model.ModflowTransientParameters[ParamIndex];
    if Param.ParameterType = ParameterType then
    begin
      Position := ParamValues.IndexOf(Param.ParameterName);
      // The parameter name is erased from ParamValues in
      // CountParametersAndParameterCells if there are no cells
      // associated with it.
      if Position < 0 then
      begin
        frmErrorsAndWarnings.AddWarning(Model,
          ErrorMessage, Param.ParameterName);
        Continue;
      end;
      ParameterValues := ParamValues.Objects[Position] as TList;
      Assert(ParameterValues.Count > 0);
      // Data set 3
      PARNAM := Param.ParameterName;
      if Length(PARNAM) > 10 then
      begin
        SetLength(PARNAM, 10);
      end;
      frmProgressMM.AddMessage(Format(StrWritingParamter, [PARNAM]));
      GetNumCellsAndNumInstances(ParameterValues, NUMINST, NCLU);
      if NCLU > 0 then
      begin
        NCLU := 1;
        Parval := Param.Value;
        WriteString(PARNAM);
        WriteString(PARTYP);
        WriteFloat(Parval);
        WriteInteger(NCLU);
        if NUMINST > 1 then
        begin
          WriteString(' INSTANCES');
          WriteInteger(NUMINST);
        end;
        WriteString(DS3);
        if NUMINST > 1 then
        begin
          WriteString(DS3Instances);
        end;
        NewLine;

        Model.WritePValAndTemplate(PARNAM,PARVAL);

        // Make sure the maximum length of the name of instance is <= 10.
        GetInstanceRoot(PARNAM, ParameterValues, InstanceRoot);
        // Data sets 4a and 4b
        for TimeIndex := 0 to ParameterValues.Count - 1 do
        begin
          Application.ProcessMessages;
          if not frmProgressMM.ShouldContinue then
          begin
            Exit;
          end;
          CellList := ParameterValues[TimeIndex];
          if CellList.Count > 0 then
          begin
            // Data set 4a
            if NUMINST > 1 then
            begin
              GetInstanceName(InstanceName, TimeIndex, InstanceRoot);
              WriteString(InstanceName);
              WriteString(DS4A + ' (Parameter instance for stress period '
                + IntToStr(TimeIndex+1) + ')');
              NewLine;
            end;
            WriteParameterCells(CellList, NCLU, VariableIdentifiers,
              DataSetIdentifier, AssignmentMethod, MultiplierArrayNames, ZoneArrayNames);
          end;
          CellList.Cache;
        end;
      end
      else
      begin
        frmErrorsAndWarnings.AddWarning(Model,
          SkippedParamWarning, Param.ParameterName);
      end;
    end;
  end;
end;

procedure TCustomTransientArrayWriter.WriteStressPeriods(
  const VariableIdentifiers, DataSetIdentifier, DS5, D7PNameIname,
  D7PName: string);
begin
  FUsedInstanceNames.Clear;
end;

constructor TCustomTransientArrayWriter.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FLayers := TObjectList.Create;
end;

destructor TCustomTransientArrayWriter.Destroy;
begin
  FLayers.Free;
  inherited;
end;

procedure TCustomTransientArrayWriter.WriteLayerArray(Lists: TList;
  const Comment: string; const MF6_ArrayName: string);
var
  Dummy: TDataArray;
begin
  WriteTransient2DArray(Comment, 0, rdtInteger, 1, Lists, umAssign,
    False, Dummy, MF6_ArrayName);
end;

procedure TCustomTransientArrayWriter.UpdateLayerDataSet(List: TList;
  DisplayArray: TModflowBoundaryDisplayDataArray);
var
  DefaultValue: integer;
  DataTypeIndex: integer;
  RowIndex: Integer;
  ColIndex: Integer;
  LayerArray: TIntegerSparseDataSet;
  InderListIndex: Integer;
  InnerList: TValueCellList;
var
  DataArrayList: TList;
  AnObject: TObject;
  ListIndex: integer;
  Layer, LayerIndex: integer;
  procedure AssignCellValues(CellList: TValueCellList);
  var
    CellIndex: Integer;
    Cell: TValueCell;
  begin
    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex] as TValueCell;
      LayerArray.IntegerData[0, Cell.Row, Cell.Column] :=
        Cell.IntegerValue[DataTypeIndex, Model];
      LayerArray.Annotation[0, Cell.Row, Cell.Column] :=
        Cell.IntegerAnnotation[DataTypeIndex, Model];
    end;
  end;
begin
  LayerArray := TIntegerSparseDataSet.Create(Model);
  try
    LayerArray.Orientation := dsoTop;
    LayerArray.EvaluatedAt := eaBlocks;
    LayerArray.UpdateDimensions(Model.ModflowGrid.LayerCount,
      Model.ModflowGrid.RowCount, Model.ModflowGrid.ColumnCount);

    DefaultValue := 1;
    DataTypeIndex := 0;
    if List.Count > 0 then
    begin
      AnObject := List[0];
      if AnObject is TList then
      begin
        for ListIndex := 0 to List.Count - 1 do
        begin
          DataArrayList := List[ListIndex];
          if DataArrayList.Count > 0 then
          begin
            AnObject := DataArrayList[0];
            if AnObject is TList then
            begin
              for InderListIndex := 0 to DataArrayList.Count - 1 do
              begin
                InnerList := DataArrayList[InderListIndex];
                AssignCellValues(InnerList);
              end;
            end
            else
            begin
              AssignCellValues(DataArrayList as TValueCellList);
            end;
          end;
        end;
      end
      else
      begin
        AssignCellValues(List as TValueCellList);
      end;
    end
    else if List is TValueCellList then
    begin
      AssignCellValues(TValueCellList(List));
    end;

    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        if not LayerArray.IsValue[0, RowIndex, ColIndex] then
        begin
          LayerArray.IntegerData[0, RowIndex, ColIndex] := DefaultValue;
          LayerArray.Annotation[0, RowIndex, ColIndex] := StrNoValueAssigned;
        end;
      end;
    end;
    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        Assert(LayerArray.IsValue[0, RowIndex, ColIndex]);
        Layer := LayerArray.IntegerData[0, RowIndex, ColIndex];
        if (Layer >= 1) and
          (Layer <= Model.ModflowLayerCount) then
        begin
          LayerIndex := Model.
            ModflowLayerToDataSetLayer(Layer);
          if (LayerIndex >= 0) and (LayerIndex < DisplayArray.LayerCount) then
          begin
            DisplayArray.RealData[LayerIndex, RowIndex, ColIndex] := Layer;
            DisplayArray.Annotation[LayerIndex, RowIndex, ColIndex]
              := LayerArray.Annotation[0, RowIndex, ColIndex];
            DisplayArray.CellCount[LayerIndex, RowIndex, ColIndex] := 1;
          end;
        end;
      end;
    end;
    DisplayArray.UpToDate := True;
  finally
    LayerArray.Free;
  end;
end;

procedure TCustomTransientArrayWriter.UpdateLayerDisplay(
  List: TValueCellList; ParameterValues: TList; TimeIndex: Integer;
  DataArray: TModflowBoundaryDisplayDataArray);
var
  CellList: TValueCellList;
  LocalPackage : TCustomTransientLayerPackageSelection;
begin
  LocalPackage := Package as TCustomTransientLayerPackageSelection;
  if LocalPackage.LayerOption = loSpecified then
  begin
    if LocalPackage.TimeVaryingLayers then
    begin
      if TimeIndex < FLayers.Count then
      begin
        CellList := FLayers[TimeIndex];
//        CellList.CheckRestore;
        UpdateLayerDataSet(CellList, DataArray);
      end
      else
      begin
        InitializeDisplayArray(DataArray, 1);
        DataArray.UpToDate := True;
      end;
    end
    else if ParameterCount > 0 then
    begin
      UpdateLayerDataSet(ParameterValues, DataArray);
    end
    else
    begin
      UpdateLayerDataSet(List, DataArray);
    end;
  end;
end;

procedure TCustomTransientArrayWriter.WriteLayerSelection(
  List: TValueCellList; ParameterValues: TList; TimeIndex: Integer;
  const Comment: string; const MF6_ArrayName: string);
var
  LayerList: TValueCellList;
  LocalPackage: TCustomTransientLayerPackageSelection;
begin
  LocalPackage := Package as TCustomTransientLayerPackageSelection;
  if LocalPackage.LayerOption = loSpecified then
  begin
    if LocalPackage.TimeVaryingLayers then
    begin
      if TimeIndex < FLayers.Count then
      begin
        LayerList := FLayers[TimeIndex];
        WriteLayerArray(LayerList, Comment, MF6_ArrayName);
      end
      else
      begin
        LayerList := TValueCellList.Create(CellType);
        try
          WriteLayerArray(LayerList, Comment, MF6_ArrayName);
        finally
          LayerList.Free;
        end;
      end;
    end
    else if ParameterCount > 0 then
    begin
      WriteLayerArray(ParameterValues, Comment, MF6_ArrayName);
    end
    else
    begin
      WriteLayerArray(List, Comment, MF6_ArrayName);
    end;
  end;
end;

procedure TCustomParameterTransientWriter.RetrieveParametersForStressPeriod(
  const D7PNameIname, D7PName: string; TimeIndex: Integer;
  ParametersUsed: TStringList; ParameterValues: TList; IncludePrintCode: boolean);
var
  PARNAM: string;
  InstanceRoot: string;
  NUMINST: Integer;
  NLST: Integer;
  List: TValueCellList;
  InstanceName: string;
  ParamIndex: Integer;
  PValues : TList;
  PrintCode: String;
begin
  ParameterValues.Clear;
  if IncludePrintCode then
  begin
    PrintCode := ' ' + IntToStr(IPRN_Real);
  end
  else
  begin
    PrintCode := '';
  end;
  for ParamIndex := 0 to ParamValues.Count - 1 do
  begin
    PARNAM := ParamValues[ParamIndex];
    if PARNAM <> '' then
    begin
      if Length(PARNAM) > 10 then
      begin
        SetLength(PARNAM, 10);
      end;
      // The number of items in PValues is
      // equal to the number of stress periods.
      // Each item in PValues is a TValueCellList.
      PValues := ParamValues.Objects[ParamIndex] as TList;
      ParameterValues.Add(PValues);
      GetInstanceRoot(PARNAM, PValues, InstanceRoot);
      GetNumCellsAndNumInstances(PValues, NUMINST, NLST);
      List := PValues[TimeIndex];
      if List.Count > 0 then
      begin
        if NUMINST > 1 then
        begin
          GetInstanceName(InstanceName, TimeIndex, InstanceRoot);
          ParametersUsed.Add(PARNAM + ' ' + InstanceName
            + PrintCode + D7PNameIname);
        end
        else
        begin
          ParametersUsed.Add(PARNAM + PrintCode + D7PName);
        end;
      end;
    end;
  end;
end;

procedure TCustomPackageWriter.WriteDataSet0;
var
  Index: integer;
  APackage: TModflowPackageSelection;
begin
  APackage := Package;
  WriteCommentLine(PackageID_Comment(APackage));
  for Index := 0 to APackage.Comments.Count - 1 do
  begin
    WriteCommentLine(APackage.Comments[Index]);
  end;
end;

procedure TCustomPackageWriter.UpdateNotUsedDisplay(
  TimeLists: TModflowBoundListOfTimeLists);
begin
  if not Package.IsSelected then
  begin
    SetTimeListsUpToDate(TimeLists);
  end;
end;

procedure TCustomModflowWriter.WriteTransient2DArray(const Comment: string;
  DataTypeIndex: Integer; DataType: TRbwDataType; DefaultValue: Double;
  List: TList; AssignmentMethod: TUpdateMethod; AdjustForLGR: boolean;
  var TransientArray: TDataArray; const MF6_ArrayName: string;
  FreeArray: boolean = True);
var
  ColIndex: Integer;
  RowIndex: Integer;
  ExportArray: TDataArray;
  IntDefaultValue: Integer;
  CellList: TList;
  InnerCellList: TValueCellList;
  AnObject: TObject;
  ListIndex: integer;
  CellListIndex: Integer;
  DummyAnnotation: string;
//  ValuesAssigned: Boolean;
  procedure AssignCellValues(CellList: TValueCellList);
  var
    CellIndex: Integer;
    Cell: TValueCell;
  begin
    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex] as TValueCell;
      case DataType of
        rdtDouble:
          begin
            case AssignmentMethod of
              umAssign:
                begin
                  ExportArray.RealData[0, Cell.Row, Cell.Column] :=
                    Cell.RealValue[DataTypeIndex, Model];
                  ExportArray.Annotation[0, Cell.Row, Cell.Column] :=
                    Cell.RealAnnotation[DataTypeIndex, Model];
                end;
              umAdd:
                begin
                  ExportArray.RealData[0, Cell.Row, Cell.Column] :=
                    ExportArray.RealData[0, Cell.Row, Cell.Column]
                    + Cell.RealValue[DataTypeIndex, Model];
                  ExportArray.Annotation[0, Cell.Row, Cell.Column] :=
                    ExportArray.Annotation[0, Cell.Row, Cell.Column]
                    + Cell.RealAnnotation[DataTypeIndex, Model];
                end;
              else Assert(False);
            end;
          end;
        rdtInteger:
          begin
            case AssignmentMethod of
              umAssign:
                begin
                  ExportArray.IntegerData[0, Cell.Row, Cell.Column] :=
                    Cell.IntegerValue[DataTypeIndex, Model];
                  ExportArray.Annotation[0, Cell.Row, Cell.Column] :=
                    Cell.IntegerAnnotation[DataTypeIndex, Model];
                end;
              umAdd:
                begin
                  ExportArray.IntegerData[0, Cell.Row, Cell.Column] :=
                    ExportArray.IntegerData[0, Cell.Row, Cell.Column]
                    + Cell.IntegerValue[DataTypeIndex, Model];
                  ExportArray.Annotation[0, Cell.Row, Cell.Column] :=
                    ExportArray.Annotation[0, Cell.Row, Cell.Column]
                    + Cell.IntegerAnnotation[DataTypeIndex, Model];
                end;
              else Assert(False);
            end;
          end;
      else
        Assert(False);
      end;
    end;
  end;
begin
  if Model.ModelSelection in [msModflowLGR2, msModflowFmp] then
  begin
    AdjustForLGR := False;
  end;
  DummyAnnotation := 'none';
  ExportArray := TDataArray.Create(Model);
  try
    IntDefaultValue := Round(DefaultValue);
    ExportArray.Orientation := dsoTop;
    ExportArray.EvaluatedAt := eaBlocks;
    ExportArray.DataType := DataType;
    ExportArray.UpdateDimensions(1, Model.ModflowGrid.RowCount,
      Model.ModflowGrid.ColumnCount, True);
    ExportArray.UpToDate := True;

    for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
    begin
      for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
      begin
        ExportArray.Annotation[0, RowIndex, ColIndex] := DummyAnnotation;
        case DataType of
          rdtDouble:
            begin
              ExportArray.RealData[0, RowIndex, ColIndex] := DefaultValue;
            end;
          rdtInteger:
            begin
              ExportArray.IntegerData[0, RowIndex, ColIndex] := IntDefaultValue;
            end;
        else
          Assert(False);
        end;
      end;
    end;

    // List may have been cast to a TValueCellList even when it wasn't one.
    if List.Count > 0 then
    begin
      AnObject := List[0];
    end
    else
    begin
      AnObject := nil;
    end;


    if (AnObject = nil) or (AnObject is TValueCell) then
    begin
      AssignCellValues(List as TValueCellList);
      TValueCellList(List).Cache;
    end
    else if List.Count > 0 then
    begin
      AnObject := List[0];
      if AnObject is TValueCellList then
      begin
        for ListIndex := 0 to List.Count - 1 do
        begin
          CellList := List[ListIndex];
          AssignCellValues(CellList as TValueCellList);
          TValueCellList(CellList).Cache;
        end;
      end
      else if AnObject is TList then
      begin
        for ListIndex := 0 to List.Count - 1 do
        begin
          CellList := List[ListIndex];
          if CellList.Count > 0 then
          begin
            for CellListIndex := 0 to CellList.Count - 1 do
            begin
              InnerCellList := CellList[CellListIndex];
              AssignCellValues(InnerCellList);
              InnerCellList.Cache;
            end;
          end;
        end;
      end
    end;

    ExportArray.UpToDate := True;
    if AdjustForLGR then
    begin
      Model.AdjustDataArray(ExportArray);
    end;
    WriteArray(ExportArray, 0, Comment, DummyAnnotation, MF6_ArrayName, False);
  finally
    if FreeArray then
    begin
      TransientArray := nil;
      ExportArray.Free;
    end
    else
    begin
      TransientArray := ExportArray;
    end;
  end;
end;

{ TCustomParameterTransientWriter }


constructor TCustomParameterTransientWriter.Create(Model: TCustomModel; EvaluationType: TEvaluationType);
begin
  inherited;
  FParamValues := TStringList.Create;
  FParamValues.OwnsObjects := True;
  FUsedInstanceNames := TStringList.Create;
  FUsedInstanceNames.Sorted := True;
  // FParameterNames should not be sorted.
  FParameterNames := TStringList.Create;
end;

destructor TCustomParameterTransientWriter.Destroy;
begin
  FParameterNames.Free;
  FUsedInstanceNames.Free;
//  for Index := 0 to FParamValues.Count - 1 do
//  begin
//    FParamValues.Objects[Index].Free;
//  end;
  FParamValues.Free;

  inherited;
end;

function TCustomPackageWriter.UcodeObsNameOK(const AName: string): boolean;
const
  Letters = ['A'..'Z', 'a'..'z'];
  ValidCharacters = ['A'..'Z', 'a'..'z', '0'..'9',
    '_', '.', ':', '&', '#', '@'];
var
  Index: Integer;
begin
  result := (AName <> '') and not SameText(AName, 'dum')
    and (Length(AName) <= 20);
  if result then
  begin
    result := CharInSet(AName[1], Letters);
    if result then
    begin
      for Index := 2 to Length(AName) do
      begin
        result := CharInSet(AName[Index], ValidCharacters);
        if not result then
        begin
          break;
        end;
      end;
    end;
  end;
end;

procedure TCustomPackageWriter.UpdateCellDisplay(CellList: TValueCellList;
  DataArrayList: TList; ParameterIndicies: TByteSet;
  Param: TModflowTransientListParameter = nil; UsedIndicies: TByteSet = []);
var
  Cell: TValueCell;
  CellIndex: Integer;
  Value: double;
  Annotation: string;
  DataArrayIndex: Integer;
  DataArray: TModflowBoundaryDisplayDataArray;
  PriorAnnotation: string;
begin
  // Data set 4b
  for DataArrayIndex := 0 to DataArrayList.Count - 1 do
  begin
    if UsedIndicies <> [] then
    begin
      if not (DataArrayIndex in UsedIndicies) then
      begin
        Continue;
      end;
    end;
    DataArray := DataArrayList[DataArrayIndex];
    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex] as TValueCell;
      if (Model.ModelSelection = msModflow2015) or
        ((Param = nil) or not (DataArrayIndex in ParameterIndicies)) then
      begin
        Value := Cell.RealValue[DataArrayIndex, Model];
        Annotation := Cell.RealAnnotation[DataArrayIndex, Model];
      end
      else
      begin
        Value := Cell.RealValue[DataArrayIndex, Model]*Param.Value;
        Annotation := Cell.RealAnnotation[DataArrayIndex, Model]
          + ' (multiplied by parameter '
          + Param.ParameterName + ' = ' + FloatToStr(Param.Value) + ')';
      end;

      // Reduce the storage of duplicate strings.
      if PriorAnnotation <> Annotation then
      begin
        PriorAnnotation := Annotation;
      end;
      DataArray.AddDataValue(PriorAnnotation, Value,
        Cell.Column, Cell.Row, Cell.Layer);
    end;
  end;
end;

procedure TCustomPackageWriter.SetTimeListsUpToDate(TimeLists: TModflowBoundListOfTimeLists);
var
  DataArray: TDataArray;
  TimeIndex: Integer;
  List: TModflowBoundaryDisplayTimeList;
  ListIndex: Integer;
begin
  for ListIndex := 0 to TimeLists.Count - 1 do
  begin
    List := TimeLists[ListIndex];
    if List <> nil then
    begin
      for TimeIndex := 0 to List.Count - 1 do
      begin
        DataArray := List[TimeIndex];
        DataArray.UpToDate := True;
      end;
      List.SetUpToDate(True);
    end;
  end;
end;

destructor TCustomPackageWriter.Destroy;
begin
  DSiTrimWorkingSet;
  inherited;
end;

function TCustomPackageWriter.ExpandString(Source: string;
  ALength: integer): string;
begin
  result := Source;
  while Length(result) < ALength do
  begin
    result := result + ' ';
  end;
end;

function TCustomFileWriter.File_Comment(const FileID: string): string;
begin
  result := FileID + ' file created on '
    + DateToStr(Now) + ' by ' + Model.ProgramName + ' version '
    + IModelVersion + '.';
end;

function TCustomModflowWriter.PackageID_Comment(
  APackage: TModflowPackageSelection): string;
begin
  result := File_Comment(APackage.PackageIdentifier);
end;

procedure TCustomModflowWriter.PrintListInputOption;
begin
  if Model.ModflowOutputControl.PrintInputCellLists then
  begin
    WriteString('    PRINT_INPUT');
    NewLine;
  end;
end;

procedure TCustomTransientWriter.UpdateTransient2DArray(
  DisplayArray: TModflowBoundaryDisplayDataArray; List: TList);
var
  DataArrayList: TList;
  AnObject: TObject;
  ListIndex: integer;
  DataArrayIndex: Integer;
  InnerDataArrayList: TList;
  procedure AssignCellValues(DataArrayList: TList);
  var
    DataArrayIndex: Integer;
    DataArray: TDataArray;
  begin
    for DataArrayIndex := 0 to DataArrayList.Count - 1 do
    begin
      DataArray := DataArrayList[DataArrayIndex];
      DisplayArray.AddDataArray(DataArray);
    end;
  end;
begin
//  if List is TValueCellList then
//  begin
//    TValueCellList(List).CheckRestore;
//  end;
  if List.Count > 0 then
  begin
    AnObject := List[0];
    if AnObject is TList then
    begin
//      if AnObject is TValueCellList then
//      begin
//        TValueCellList(AnObject).CheckRestore;
//      end;
      for ListIndex := 0 to List.Count - 1 do
      begin
        DataArrayList := List[ListIndex];
//        if DataArrayList is TValueCellList then
//        begin
//          TValueCellList(DataArrayList).CheckRestore;
//        end;
        if DataArrayList.Count > 0 then
        begin
          AnObject := DataArrayList[0];
          if AnObject is TList then
          begin
//            if AnObject is TValueCellList then
//            begin
//              TValueCellList(AnObject).CheckRestore;
//            end;
            for DataArrayIndex := 0 to DataArrayList.Count - 1 do
            begin
              InnerDataArrayList := DataArrayList[DataArrayIndex];
//              if InnerDataArrayList is TValueCellList then
//              begin
//                TValueCellList(InnerDataArrayList).CheckRestore;
//              end;
              AssignCellValues(InnerDataArrayList);
            end;
          end
          else
          begin
            AssignCellValues(DataArrayList);
          end;
        end;
      end;
    end
    else
    begin
      AssignCellValues(List);
    end;
  end;
  DisplayArray.UpToDate := True;
end;

procedure TCustomTransientWriter.InitializeDisplayArray(
  DisplayArray: TModflowBoundaryDisplayDataArray; DefaultValue: Double);
begin
  DisplayArray.InitializeDisplayArray(0);
end;

procedure TCustomTransientWriter.SetOwnsValueContents(const Value: Boolean);
begin
  (FValues as TObjectList).OwnsObjects := Value;
end;

procedure TCustomTransientWriter.AssignTransient2DArray(
      DisplayArray: TModflowBoundaryDisplayDataArray; DataTypeIndex: Integer;
      List: TList; DefaultValue: double; DataType: TRbwDataType;
      UpdateMethod: TUpdateMethod);
var
  CellList: TValueCellList;
  AnObject: TObject;
  ListIndex: integer;
  procedure AssignCellValues(CellList: TValueCellList);
  var
    CellIndex: Integer;
    Cell: TValueCell;
  begin
    for CellIndex := 0 to CellList.Count - 1 do
    begin
      Cell := CellList[CellIndex] as TValueCell;
      case UpdateMethod of
        umAssign:
          begin
            case DataType of
              rdtDouble:
                begin
                  DisplayArray.RealData[0, Cell.Row, Cell.Column]
                    := Cell.RealValue[DataTypeIndex, Model];
                  DisplayArray.Annotation[0, Cell.Row, Cell.Column]
                    := Cell.RealAnnotation[DataTypeIndex, Model];
                  DisplayArray.CellCount[0, Cell.Row, Cell.Column] := 1;
                end;
              rdtInteger:
                begin
                  DisplayArray.RealData[0, Cell.Row, Cell.Column]
                    := Cell.IntegerValue[DataTypeIndex, Model];
                  DisplayArray.Annotation[0, Cell.Row, Cell.Column]
                    := Cell.IntegerAnnotation[DataTypeIndex, Model];
                  DisplayArray.CellCount[0, Cell.Row, Cell.Column] := 1;
                end;
            else
              Assert(False);
            end;
          end;
        umAdd:
          begin
            case DataType of
              rdtDouble:
                begin
                  DisplayArray.AddDataValue(Cell.RealAnnotation[DataTypeIndex, Model],
                    Cell.RealValue[DataTypeIndex, Model], Cell.Column, Cell.Row, 0);
                end;
              rdtInteger:
                begin
                  DisplayArray.AddDataValue(Cell.IntegerAnnotation[DataTypeIndex, Model],
                    Cell.IntegerValue[DataTypeIndex, Model], Cell.Column, Cell.Row, 0);
                end;
            else
              Assert(False);
            end;
          end;
        else Assert(False);
      end;
    end;
  end;
begin
  InitializeDisplayArray(DisplayArray, DefaultValue);
  if (List.Count > 0)
    or ((List is TValueCellList) and (TValueCellList(List).Count > 0)) then
  begin
    if (List is TValueCellList) then
    begin
      AnObject := TValueCellList(List).Items[0];
    end
    else
    begin
      AnObject := List[0];
    end;
    if AnObject is TList then
    begin
      for ListIndex := 0 to List.Count - 1 do
      begin
        CellList := List[ListIndex];
        AssignCellValues(CellList);
      end;
    end
    else
    begin
      AssignCellValues(List as TValueCellList);
    end;
  end;
  DisplayArray.UpToDate := True;
end;

function TFluxObsWriter.ObservationFileName(AFileName: string): string;
begin
  result := ChangeFileExt(AFileName, ObservationExtension);
end;

function TFluxObsWriter.ObservationOutputFileName(AFileName: string): string;
begin
  result := ChangeFileExt(AFileName, ObservationOutputExtension);
end;

procedure TFluxObsWriter.RemoveWarningGroups(ObservationGroup: TFluxObservationGroup);
begin
  frmErrorsAndWarnings.RemoveWarningGroup(Model,
    Format(EarlyTimeWarning, [GetFluxType(ObservationGroup)]));
  frmErrorsAndWarnings.RemoveWarningGroup(Model,
    Format(LateTimeWarning, [GetFluxType(ObservationGroup)]));
end;

function TFluxObsWriter.GetFluxType(ObservationGroup: TFluxObservationGroup): string;
begin
  case ObservationGroup.FluxObsType of
    fotHead: result := 'CHOB ';
    fotRiver: result := 'RVOB ';
    fotDrain: result := 'DROB ';
    fotGHB: result := 'GBOB ';
    fotSTR: result := 'STOB ';
  end;
end;

procedure TFluxObsWriter.WriteObservationDataSet4(ObservationGroup: TFluxObservationGroup;
      DataSet4: TStringList);
var
  ObsTime: TFluxObservation;
  OBSNAM: string;
  TOFFSET: Double;
  FLWOBS: Double;
  TimeIndex: Integer;
  StartTime: Double;
  EndTime: Double;
  TimeString: string;
  Comment: string;
  EarlyTimes: string;
  LateTimes: string;
  StartingTimes: TRealList;
  ReferenceStressPeriodIndex: Integer;
begin
  StartingTimes := TRealList.Create;
  try
    for TimeIndex := 0 to Model.ModflowFullStressPeriods.Count - 1 do
    begin
      StartingTimes.Add(Model.ModflowFullStressPeriods[TimeIndex].StartTime);
    end;
    StartingTimes.Sort;
    EarlyTimes := '';
    LateTimes := '';
    StartTime := Model.ModflowStressPeriods[0].StartTime;
    EndTime := Model.ModflowFullStressPeriods[
      Model.ModflowFullStressPeriods.Count-1].EndTime;
    for TimeIndex := 0 to ObservationGroup.ObservationTimes.Count - 1 do
    begin
      ObsTime := ObservationGroup.ObservationTimes[TimeIndex];

      if ObsTime.Time < StartTime then
      begin
        EarlyTimes := EarlyTimes + ' ' + FloatToStr(ObsTime.Time);
        Continue;
      end;

      if ObsTime.Time > EndTime then
      begin
        LateTimes := LateTimes + ' ' + FloatToStr(ObsTime.Time);
        Continue;
      end;

      TimeString := ObsTime.ObsNameTimeString;;
      OBSNAM := ObservationGroup.ObservationName + '_' + TimeString;
      if not UcodeObsNameOK(OBSNAM) then
      begin
        frmErrorsAndWarnings.AddWarning(Model, ObsNameWarningString, OBSNAM);
      end;
      ReferenceStressPeriodIndex := StartingTimes.IndexOfClosest(ObsTime.Time);
      if (StartingTimes[ReferenceStressPeriodIndex] > ObsTime.Time) then
      begin
        Dec(ReferenceStressPeriodIndex);
      end;
      Assert(ReferenceStressPeriodIndex >= 0);
      TOFFSET := ObsTime.Time - StartingTimes[ReferenceStressPeriodIndex];
      FLWOBS := ObsTime.ObservedValue;
      if ObsTime.Comment = '' then
      begin
        Comment := '';
      end
      else
      begin
        Comment :=  ' Comment = ' + ObsTime.Comment;
      end;
      DataSet4.Add(OBSNAM + ' ' + IntToStr(ReferenceStressPeriodIndex+1)
        +  ' ' + FreeFormattedReal(TOFFSET)
        + FreeFormattedReal(FLWOBS)
        + ' # Data Set 4: OBSNAM IREFSP TOFFSET FLWOBS'
        + Comment);
    end;
    if EarlyTimes <> '' then
    begin
      EarlyTimes := Format(StrErrorFlowObservatEarly,
        [ObservationGroup.ObservationName, EarlyTimes]);
      frmErrorsAndWarnings.AddWarning(Model,
        Format(EarlyTimeWarning, [GetFluxType(ObservationGroup)]), EarlyTimes);
    end;
    if LateTimes <> '' then
    begin
      LateTimes := Format(StrErrorFlowObservatLate,
        [ObservationGroup.ObservationName, LateTimes]);
      frmErrorsAndWarnings.AddWarning(Model,
        Format(LateTimeWarning, [GetFluxType(ObservationGroup)]), LateTimes);
    end;
  finally
    StartingTimes.Free;
  end;
end;

procedure TFluxObsWriter.WriteObservationDataSet5(DataSet5: TStringList;
      ObservationGroup: TFluxObservationGroup; AllCells: TList);
var
  ObsFactor: TObservationFactor;
  ObjectIndex: Integer;
begin
  for ObjectIndex := 0 to ObservationGroup.ObservationFactors.Count - 1 do
  begin
    ObsFactor := ObservationGroup.ObservationFactors[ObjectIndex];
    WriteDataSet5ForOneScreenObject(ObsFactor, DataSet5, AllCells);
  end;
end;

procedure TFluxObsWriter.WriteFluxObsFile(const AFileName, OutputUnitId,
      PackageAbbreviation, DataSet1Comment, DataSet2Comment,
      DataSet3Comment: string; Observations: TFluxObservationGroups;
      Purpose: TObservationPurpose);
var
  Index: Integer;
  NQCL_Pkg: Integer;
  DataSet5: TStringList;
  NQOB_Pkg: Integer;
  DataSet4: TStringList;
  ObservationGroup: TFluxObservationGroup;
  ObsIndex: Integer;
  CellList: TValueCellList;
  LocalParamValues: TList;
  ParamIndex: Integer;
  ACell: TValueCell;
  CellIndex: Integer;
  List: TValueCellList;
  ObsFile: TStringList;
  AllCells: TList;
  OutputName: string;
  IU_Pkg_OBSV: Integer;
  NameOfFile: string;
  NQT_Pkg: Integer;
  NQC_Pkg: Integer;
  NQ_Pkg: Integer;
  ErrorRoot: string;
  DetailedMessage: string;
  FluxObsCountWarning: string;
  DataSet1: string;
  PrintObservations: Boolean;
  MissingObservationObjectsErrorMessage: string;
begin
  // if the package is not selected, quit.
  if not ObservationPackage.IsSelected then
  begin
    Exit;
  end;
  // If the file has been generated externally, quit.
  if Model.PackageGeneratedExternally(PackageAbbreviation) then
  begin
    Exit;
  end;

  frmErrorsAndWarnings.BeginUpdate;
  try
    frmErrorsAndWarnings.RemoveWarningGroup(Model, ObsNameWarningString);

    FluxObsCountWarning := Format(StrInSNoFlowObser,
      [ObservationPackage.PackageIdentifier]);
    frmErrorsAndWarnings.RemoveWarningGroup(Model, FluxObsCountWarning);
    MissingObservationObjectsErrorMessage :=
      Format(StrMissingObservationObjects, [PackageAbbreviation]);
    frmErrorsAndWarnings.RemoveErrorGroup(Model, MissingObservationObjectsErrorMessage);

    // count the number of cell groups for which flux observations are listed
    NQ_Pkg := 0;
    for ObsIndex := 0 to Observations.Count - 1 do
    begin
      ObservationGroup := Observations[ObsIndex];
      if Purpose = ObservationGroup.Purpose then
      begin
        Inc(NQ_Pkg);
      end;
    end;

    if (Observations.Count > 0) and (NQ_Pkg = 0) then
    begin
      frmErrorsAndWarnings.AddWarning(Model, FluxObsCountWarning,
        StrSelectModelObserv);
    end;

    NQC_Pkg := 0;
    NQT_Pkg := 0;

    NameOfFile := ObservationFileName(AFileName);
    WriteToNameFile(PackageAbbreviation, Model.UnitNumbers.
      UnitNumber(PackageAbbreviation), NameOfFile, foInput, Model);

    IU_Pkg_OBSV := Model.UnitNumbers.UnitNumber(OutputUnitId);
    OutputName := ObservationOutputFileName(AFileName);
    WriteToNameFile(StrDATA, IU_Pkg_OBSV, OutputName, foOutput, Model);

    AllCells := TList.Create;
    ObsFile := TStringList.Create;
    try
      // Values stores the values at a list of cells.
      if Values.Count = 0 then
      begin
        ErrorRoot := Format(StrTheSInputFileCa, [PackageAbbreviation]);
        DetailedMessage := Format(StrInTheBoundaryPack, [PackageAbbreviation]);
        frmErrorsAndWarnings.AddError(Model, ErrorRoot, DetailedMessage);
        Exit;
      end;
      // put the cells for the flux in AllCells
      List := Values[0];
      for CellIndex := 0 to List.Count - 1 do
      begin
        ACell := List[CellIndex];
        AllCells.Add(ACell);
      end;
      for ParamIndex := 0 to ParamValues.Count - 1 do
      begin
        LocalParamValues := ParamValues.Objects[ParamIndex] as TList;
        CellList := LocalParamValues[0];
        for CellIndex := 0 to CellList.Count - 1 do
        begin
          ACell := CellList[CellIndex];
          AllCells.Add(ACell);
        end;
      end;
      for ObsIndex := 0 to Observations.Count - 1 do
      begin
        ObservationGroup := Observations[ObsIndex];
        if ObsIndex = 0 then
        begin
          RemoveWarningGroups(ObservationGroup);
        end;
        if Purpose = ObservationGroup.Purpose then
        begin
          if ObservationGroup.ObservationFactors.Count = 0 then
          begin
            frmErrorsAndWarnings.AddError(Model,
              MissingObservationObjectsErrorMessage,
              ObservationGroup.ObservationName);
          end;
          DataSet4 := TStringList.Create;
          try
            WriteObservationDataSet4(ObservationGroup, DataSet4);
            NQOB_Pkg := DataSet4.Count;
            NQT_Pkg := NQT_Pkg + NQOB_Pkg;
            DataSet5 := TStringList.Create;
            try
              WriteObservationDataSet5(DataSet5, ObservationGroup, AllCells);
              NQCL_Pkg := DataSet5.Count;
              NQC_Pkg := NQC_Pkg + NQCL_Pkg;
              ObsFile.Add(IntToStr(NQOB_Pkg) + ' ' + IntToStr(NQCL_Pkg)
                + DataSet3Comment);
              ObsFile.AddStrings(DataSet4);
              ObsFile.AddStrings(DataSet5);
            finally
              DataSet5.Free;
            end;
          finally
            DataSet4.Free;
          end;
        end;
      end;
      DataSet1 := IntToStr(NQ_Pkg) + ' ' + IntToStr(NQC_Pkg) + ' '
        + IntToStr(NQT_Pkg) + ' ' + IntToStr(IU_Pkg_OBSV);

      PrintObservations := Model.ModflowOutputControl.PrintObservations;
      if not PrintObservations then
      begin
        DataSet1 := DataSet1 +' NOPRINT';
      end;
      DataSet1 := DataSet1 + DataSet1Comment;
      if not PrintObservations then
      begin
        DataSet1 := DataSet1 +' NOPRINT';
      end;
      ObsFile.Insert(0,DataSet1);
      ObsFile.Insert(1, '1' + DataSet2Comment);
      for Index := ObservationPackage.Comments.Count - 1 downto 0 do
      begin
        ObsFile.Insert(0, '# ' + ObservationPackage.Comments[Index]);
      end;
      ObsFile.Insert(0, '# ' + PackageID_Comment(ObservationPackage));
      ObsFile.SaveToFile(NameOfFile);
    finally
      AllCells.Free;
      ObsFile.Free;
    end;
  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TFluxObsWriter.WriteFluxObsFileMF6(const AFileName, OutputUnitId,
  PackageAbbreviation, DataSet1Comment, DataSet2Comment,
  DataSet3Comment: string; Observations: TFluxObservationGroups;
  Purpose: TObservationPurpose);
var
  ObsIndex: Integer;
  ObservationGroup: TFluxObservationGroup;
  NameOfFile: string;
  OutputName: string;
  TimeIndex: Integer;
  AnObs: TFluxObservation;
  TimeString: string;
  obsname: string;
  ObjectIndex: Integer;
  ObsFactor: TObservationFactor;
  ObjectNameIndex: Integer;
  ID: string;
begin
  { TODO -cMODFLOW-2015 : Add a method of writing continuous observations }

  // if the package is not selected, quit.
  if not ObservationPackage.IsSelected then
  begin
    Exit;
  end;

  frmErrorsAndWarnings.BeginUpdate;
  try

    NameOfFile := ObservationFileName(AFileName);
    OpenFile(NameOfFile);
    try
      WriteDataSet0;

      // Options block
      WriteBeginOptions;
      try
        WriteString('    DIGITS 16');
        NewLine;

        WriteString('    STRUCTURED');
        NewLine;

        PrintListInputOption;

      finally
        WriteEndOptions;
      end;

      OutputName := ObservationOutputFileName(AFileName);
      WriteString('BEGIN SINGLE ');
      WriteString(OutputName);
      NewLine;

      for ObsIndex := 0 to Observations.Count - 1 do
      begin
        ObservationGroup := Observations[ObsIndex];

        if Purpose = ObservationGroup.Purpose then
        begin
          for TimeIndex := 0 to ObservationGroup.ObservationTimes.Count - 1 do
          begin
            AnObs := ObservationGroup.ObservationTimes[TimeIndex];

            TimeString := AnObs.ObsNameTimeString;
            obsname := ObservationGroup.ObservationName + '_' + TimeString;

            for ObjectIndex := 0 to ObservationGroup.ObservationFactors.Count - 1 do
            begin
              ObsFactor := ObservationGroup.ObservationFactors[ObjectIndex];

              ObjectNameIndex := FObjectNames.IndexOf(ObsFactor.ObjectName);
              Assert(ObjectNameIndex >= 0);
              ID := ' ' + FBoundNames[ObjectNameIndex];

              WriteString(obsname);
              WriteString(ObsTypeMF6);
              WriteFloat(AnObs.Time);
              WriteString(ID);
              NewLine;
            end;


          end;

        end;
      end;

      WriteString('END SINGLE');
      NewLine;
    finally
      CloseFile;
    end;

  finally
    frmErrorsAndWarnings.EndUpdate;
  end;
end;

procedure TFluxObsWriter.WriteListOptions;
var
  NameOfFile: string;
begin
  inherited;
  if ObservationPackage.IsSelected then
  begin
    WriteString('    OBS8 ');
    NameOfFile := ObservationFileName(FFileName);
    WriteString(NameOfFile);
    NewLine;
  end;
end;

procedure TFluxObsWriter.WriteZeroConductanceCell(ACell: TValueCell;
  DataSet5: TStringList);
var
  Layer: Integer;
  Row: Integer;
  Column: Integer;
begin
  // write zero-conductance cell.
  Layer := Model.
    DataSetLayerToModflowLayer(ACell.Layer);
  Row := ACell.Row + 1;
  Column := ACell.Column + 1;
  DataSet5.Add(IntToStr(Layer) + ' ' + IntToStr(Row) + ' ' + IntToStr(Column)
    + ' 0' + ' # Data Set 5: Layer Row Column Factor');
end;

procedure TFluxObsWriter.WriteObservationCell(ACell: TValueCell;
  DataSet5: TStringList; var Expression: TExpression; DataSets, Variables: TList;
  ObsFactor: TObservationFactor);
var
  Layer: Integer;
  Row: Integer;
  Column: Integer;
  Factor: Extended;
begin
  // Write cell
  Layer := Model.DataSetLayerToModflowLayer(ACell.Layer);
  Row := ACell.Row + 1;
  Column := ACell.Column + 1;
  EvaluateFactor(Factor, Expression, ACell,
    DataSets, Variables, ObsFactor);
  DataSet5.Add(IntToStr(Layer) + ' ' + IntToStr(Row) + ' '
    + IntToStr(Column) + ' ' + FreeFormattedReal(Factor)
    + ' # Data Set 5: Layer Row Column Factor');
end;

procedure TFluxObsWriter.WriteObservationCells(Variables, DataSets: TList;
  var Expression: TExpression; DataSet5: TStringList; AllCells: TList;
  ScreenObject: TScreenObject; ObsFactor: TObservationFactor);
var
  AnotherCell: TValueCell;
  StartPoint: Integer;
  ACell: TValueCell;
  CellIndex: Integer;
  TempList: TList;
begin
  TempList := TList.Create;
  try
    for CellIndex := 0 to AllCells.Count - 1 do
    begin
      ACell := AllCells[CellIndex];
      if ACell.ScreenObject = ScreenObject then
      begin
        TempList.Add(ACell);
      end;
    end;
    // Simulate the procedure MODFLOW uses to identify the cells to use as
    // part of the observation.
    StartPoint := 0;
    for CellIndex := 0 to TempList.Count - 1 do
    begin
      ACell := TempList[CellIndex];
      while True do
      begin
        AnotherCell := AllCells[StartPoint];
        Inc(StartPoint);
        if StartPoint = AllCells.Count then
        begin
          StartPoint := 0;
        end;
        if ACell = AnotherCell then
        begin
          WriteObservationCell(ACell, DataSet5, Expression,
            DataSets, Variables, ObsFactor);
          break;
        end
        else if (ACell.Layer = AnotherCell.Layer)
          and (ACell.Row = AnotherCell.Row)
          and (ACell.Column = AnotherCell.Column) then
        begin
          WriteZeroConductanceCell(ACell, DataSet5);
        end;
      end;
    end;
  finally
    TempList.Free;
  end;
end;

procedure TFluxObsWriter.WriteDataSet5ForOneScreenObject(
  ObsFactor: TObservationFactor; DataSet5: TStringList; AllCells: TList);
var
  Expression: TExpression;
  Observer: TObserver;
  VariableIndex: Integer;
  Variables: TList;
  FactorFormula: string;
  ScreenObject: TScreenObject;
  DataSets: TList;
  VariablesUsed: TStringList;
  DataArray: TDataArray;
begin
  FactorFormula := ObsFactor.Factor;
  Model.rpThreeDFormulaCompiler.Compile(FactorFormula);
  Expression := Model.rpThreeDFormulaCompiler.CurrentExpression;
  Assert(Expression.ResultType in [rdtDouble, rdtInteger]);
  DataSets := TList.Create;
  Variables := TList.Create;
  try
    VariablesUsed := Expression.VariablesUsed;
    Variables.Capacity := VariablesUsed.Count;
    DataSets.Capacity := VariablesUsed.Count;
    for VariableIndex := 0 to VariablesUsed.Count - 1 do
    begin
      Observer := Model.GetObserverByName(VariablesUsed[VariableIndex]);
      if Observer is TDataArray then
      begin
        DataArray := TDataArray(Observer);
        DataArray.Initialize;
        Variables.Add(VariablesUsed.Objects[VariableIndex]);
        DataSets.Add(DataArray);
        Model.DataArrayManager.AddDataSetToCache(DataArray);
      end
      else
      begin
        Assert(Observer is TGlobalVariable);
      end;
    end;
    ScreenObject := ObsFactor.ScreenObject as TScreenObject;
    WriteObservationCells(Variables, DataSets, Expression, DataSet5, AllCells, ScreenObject, ObsFactor);
  finally
    Variables.Free;
    DataSets.Free;
    Model.DataArrayManager.CacheDataArrays;
  end;
end;

procedure TFluxObsWriter.EvaluateFactor(var Factor: Extended;
  var Expression: TExpression; ACell: TValueCell; DataSets, Variables: TList;
  ObsFactor: TObservationFactor);
var
  DA_Column: Integer;
  DA_Row: Integer;
  DA_Layer: Integer;
  Compiler: TRbwParser;
  ScreenObject: TScreenObject;
  RealVariable: TRealVariable;
  StringVariable: TStringVariable;
  TempFormula: string;
  IntegerVariable: TIntegerVariable;
  Local_VariableIndex: Integer;
  DataArray: TDataArray;
  BooleanVariable: TBooleanVariable;
begin
//  Layer := Model.DataSetLayerToModflowLayer(ACell.Layer);
//  Row := ACell.Row + 1;
//  Column := ACell.Column + 1;
  for Local_VariableIndex := 0 to Variables.Count - 1 do
  begin
    DataArray := DataSets[Local_VariableIndex];
    DA_Layer := ACell.Layer;
    DA_Row := ACell.Row;
    DA_Column := ACell.Column;
    case DataArray.Orientation of
      dsoTop:
        DA_Layer := 0;
      dsoFront:
        DA_Row := 0;
      dsoSide:
        DA_Column := 0;
      dso3D:
        ;
    else
      // do nothing
      Assert(False);
    end;
    //    DataArray.Initialize;
    case DataArray.DataType of
      rdtDouble:
        begin
          RealVariable := Variables[Local_VariableIndex];
          RealVariable.Value := DataArray.RealData[DA_Layer, DA_Row, DA_Column];
        end;
      rdtInteger:
        begin
          IntegerVariable := Variables[Local_VariableIndex];
          IntegerVariable.Value := DataArray.IntegerData[
            DA_Layer, DA_Row, DA_Column];
        end;
      rdtBoolean:
        begin
          BooleanVariable := Variables[Local_VariableIndex];
          BooleanVariable.Value := DataArray.BooleanData[
            DA_Layer, DA_Row, DA_Column];
        end;
      rdtString:
        begin
          StringVariable := Variables[Local_VariableIndex];
          StringVariable.Value := DataArray.StringData[
            DA_Layer, DA_Row, DA_Column];
        end;
    else
      Assert(False);
    end;
  end;
  UpdateGlobalLocations(ACell.Column, ACell.Row, ACell.Layer, eaBlocks, Model);
  UpdateCurrentScreenObject(ObsFactor.ScreenObject as TScreenObject);
  { TODO : Find a way to specify segment }
//  UpdateCurrentSegment(ACell.Segment);
  UpdateCurrentSection(ACell.Section);
  try
    Expression.Evaluate;
  except
    on E: ERbwParserError do
    begin
      ScreenObject := ObsFactor.ScreenObject as TScreenObject;
      frmFormulaErrors.AddFormulaError(ScreenObject.Name,
        Format(StrObservationFactor, [ObservationPackage.PackageIdentifier]),
        Expression.Decompile, E.Message);
      ObsFactor.Factor := '1.';
      Compiler := Model.rpThreeDFormulaCompiler;
      TempFormula := ObsFactor.Factor;
      Compiler.Compile(TempFormula);
      Expression := Compiler.CurrentExpression;
      Expression.Evaluate;
    end;
  end;
  Factor := Expression.DoubleResult;
  if Factor > 1 then
  begin
    Factor := 1;
  end
  else if Factor < 0 then
  begin
    Factor := 0;
  end;
end;

procedure TCustomPackageWriter.IdentifyZoneClusters(var NCLU: Integer;
      var Clusters: TOneDIntegerArray; var UniformLayers: TBooleanDynArray;
      LayerCount: Integer; Param: TModflowSteadyParameter);
var
  MF_LayerIndex: Integer;
//  Group: TLayerGroup;
  LayerUsed: Boolean;
  LayerIndex: Integer;
  ModelLayerIndex: Integer;
  ZoneDataSet: TDataArray;
  ColIndex: Integer;
  RowIndex: Integer;
  FirstValue: Boolean;
begin
  SetLength(Clusters, LayerCount);
  SetLength(UniformLayers, LayerCount);
  ZoneDataSet := Model.DataArrayManager.GetDataSetByName(Param.ZoneName);
  ZoneDataSet.Initialize;
  NCLU := 0;
  if Param.ParameterType = ptLPF_VKCB then
  begin
    MF_LayerIndex := 0;
    for ModelLayerIndex := 0 to Model.Grid.LayerCount - 1 do
    begin
//      Group := Model.LayerStructure.LayerGroups[ModelLayerIndex];
      if Model.IsLayerSimulated(ModelLayerIndex) then
      begin
//        MF_LayerIndex := MF_LayerIndex + Group.ModflowLayerCount;
        Inc(MF_LayerIndex);
      end
      else
      begin
        LayerUsed := False;
        LayerIndex := ModelLayerIndex;
//        Inc(LayerIndex);
        FirstValue := ZoneDataSet.BooleanData[LayerIndex, 0, 0];
        UniformLayers[NCLU] := True;
        for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
        begin
          for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
          begin
            if ZoneDataSet.BooleanData[LayerIndex, RowIndex, ColIndex] then
            begin
              if not LayerUsed then
              begin
                Clusters[NCLU] := MF_LayerIndex;
                Inc(NCLU);
                LayerUsed := True;
              end;
            end;
            if ZoneDataSet.BooleanData[LayerIndex, RowIndex, ColIndex] <>
              FirstValue then
            begin
              UniformLayers[NCLU-1] := False;
              break;
            end;
          end;
          if LayerUsed and not UniformLayers[NCLU-1] then
          begin
            break;
          end;
        end;
      end;
    end;
  end
  else
  begin
    for MF_LayerIndex := 1 to LayerCount do
    begin
      LayerUsed := False;
      LayerIndex := Model.
        ModflowLayerToDataSetLayer(MF_LayerIndex);
      FirstValue := ZoneDataSet.BooleanData[LayerIndex, 0, 0];
      UniformLayers[NCLU] := True;
      for RowIndex := 0 to Model.ModflowGrid.RowCount - 1 do
      begin
        for ColIndex := 0 to Model.ModflowGrid.ColumnCount - 1 do
        begin
          if ZoneDataSet.BooleanData[LayerIndex, RowIndex, ColIndex] then
          begin
            if not LayerUsed then
            begin
              Clusters[NCLU] := MF_LayerIndex;
              Inc(NCLU);
              LayerUsed := True;
            end;
          end;
          if ZoneDataSet.BooleanData[LayerIndex, RowIndex, ColIndex] <>
            FirstValue then
          begin
            UniformLayers[NCLU-1] := False;
            break;
          end;
        end;
        if LayerUsed and not UniformLayers[NCLU-1] then
        begin
          break;
        end;
      end;
    end;
  end;
  Model.DataArrayManager.AddDataSetToCache(ZoneDataSet);
end;

{ TCustomSolverWriter }

function TCustomSolverWriter.SolverFileGeneratedExternally: boolean;
var
  Index: Integer;
begin
  if Model.AlternateSolver then
  begin
    result := True;
  end
  else
  begin
    for Index := 0 to Length(Solvers) - 1 do
    begin
      result := Model.PackageGeneratedExternally(Solvers[Index]);
      if result then
      begin
        Exit;
      end;
    end;
  end;
end;

{ TCustomFlowPackageWriter }

function TCustomFlowPackageWriter.FlowPackageFileGeneratedExternally: boolean;
var
  Index: Integer;
begin
  if Model.AlternateFlowPackage then
  begin
    result := True;
  end
  else
  begin
    for Index := 0 to Length(FlowPackages) - 1 do
    begin
      result := Model.PackageGeneratedExternally(FlowPackages[Index]);
      if result then
      begin
        Exit;
      end;
    end;
  end;
end;

procedure TCustomSubWriter.GetStartAndEndTimeSteps(var ITS2, ISP2, ITS1, ISP1: Integer;
      PrintChoice: TCustomPrintItem);
var
  TimeStepIndex: Integer;
  LengthOfTimeStep: Double;
  Time: Double;
  StressPeriodIndex: Integer;
  StressPeriod: TModflowStressPeriod;
begin
  ISP1 := 0;
  ITS1 := 0;
  ISP2 := 0;
  ITS2 := 0;
  StressPeriod := Model.ModflowFullStressPeriods[0];
  if StartTimeOK(StressPeriod.StartTime, PrintChoice) then
  begin
    ISP1 := 1;
    ITS1 := 1;
  end
  else
  begin
    for StressPeriodIndex := 0 to
      Model.ModflowFullStressPeriods.Count - 1 do
    begin
      StressPeriod := Model.ModflowFullStressPeriods[StressPeriodIndex];
      if StressPeriod.EndTime > PrintChoice.StartTime then
      begin
        ISP1 := StressPeriodIndex + 1;
        if StartTimeOK(StressPeriod.StartTime, PrintChoice) then
        begin
          ITS1 := 1;
        end
        else
        begin
          Time := StressPeriod.StartTime;
          LengthOfTimeStep := StressPeriod.LengthOfFirstTimeStep;
          for TimeStepIndex := 0 to StressPeriod.NumberOfSteps - 1 do
          begin
            Time := Time + LengthOfTimeStep;
            if StartTimeOK(Time, PrintChoice) then
            begin
              ITS1 := TimeStepIndex;
              if ITS1 = 0 then
              begin
                ITS1 := 1;
              end;
              break;
            end;
            LengthOfTimeStep :=
              LengthOfTimeStep * StressPeriod.TimeStepMultiplier;
          end;
          if ITS1 = 0 then
          begin
            ITS1 := StressPeriod.NumberOfSteps;
          end;
        end;
        break;
      end;
    end;
  end;
  StressPeriod := Model.ModflowFullStressPeriods
    [Model.ModflowFullStressPeriods.Count - 1];
  if PrintChoice.EndTime >= StressPeriod.EndTime then
  begin
    ISP2 := Model.ModflowFullStressPeriods.Count;
    ITS2 := StressPeriod.NumberOfSteps;
  end
  else
  begin
    for StressPeriodIndex := ISP1 - 1 to
      Model.ModflowFullStressPeriods.Count - 1 do
    begin
      StressPeriod := Model.ModflowFullStressPeriods[StressPeriodIndex];
      if EndTimeOK(StressPeriod.EndTime, PrintChoice) then
      begin
        ISP2 := StressPeriodIndex + 1;
        if StressPeriod.EndTime = PrintChoice.EndTime then
        begin
          ITS2 := StressPeriod.NumberOfSteps;
        end
        else
        begin
          Time := StressPeriod.StartTime;
          LengthOfTimeStep := StressPeriod.LengthOfFirstTimeStep;
          for TimeStepIndex := 0 to StressPeriod.NumberOfSteps - 1 do
          begin
            Time := Time + LengthOfTimeStep;
            if EndTimeOK(Time, PrintChoice) then
            begin
              ITS2 := TimeStepIndex + 1;
              break;
            end;
            LengthOfTimeStep :=
              LengthOfTimeStep * StressPeriod.TimeStepMultiplier;
          end;
          if ITS2 = 0 then
          begin
            ITS2 := StressPeriod.NumberOfSteps;
          end;
        end;
        break;
      end;
    end;
  end;
end;

const
  Epsilon = 1e-6;

function TCustomSubWriter.StartTimeOK(Time: double; PrintChoice: TCustomPrintItem): boolean;
begin
  result := PrintChoice.StartTime + Abs(PrintChoice.StartTime)*Epsilon <= Time
end;

function TCustomSubWriter.EndTimeOK(Time: double; PrintChoice: TCustomPrintItem): boolean;
begin
  result := Time >= PrintChoice.EndTime - Abs(PrintChoice.EndTime)*Epsilon;
end;

{ TTransientArrayWriter }

class function TTransientArrayWriter.Extension: string;
begin
  result := '';
end;

function TTransientArrayWriter.WriteFile(const AFileName,
  ArrayType: string; ADataArray: TDataArray): string;
var
  ArrayName: string;
  OutputFileName: string;
  OutputDirectory: string;
begin
  ArrayName := ADataArray.Name;
  OutputFileName := AFileName + '.' + Trim(ArrayName);

  result := ExtractFileName(OutputFileName);
  OutputDirectory := ExtractFileDir(OutputFileName);
  OutputDirectory := IncludeTrailingPathDelimiter(OutputDirectory) + StrArrays;
  if not DirectoryExists(OutputDirectory) then
  begin
    CreateDir(OutputDirectory);
  end;
  result := IncludeTrailingPathDelimiter(OutputDirectory) + result;

  OpenFile(result);
  try
    WriteArrayValues(0, ADataArray);
  finally
    CloseFile;
  end;
  ADataArray.CacheData;
end;

{ TCustomNameFileWriter }

constructor TCustomNameFileWriter.Create(AModel: TCustomModel;
  const FileName: string; EvaluationType: TEvaluationType);
begin
  inherited Create(AModel, EvaluationType);
  FFullOutputFiles := TStringList.Create;
  FNameFile := TStringList.Create;
  FInputFiles := TStringList.Create;
  FOutputFiles := TStringList.Create;

  SetCurrentNameFileWriter(self);
  InitilizeNameFile(FileName, FListFileName);
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrInputFileDoesNot);
end;

destructor TCustomNameFileWriter.Destroy;
begin
  FFullOutputFiles.Free;
  FInputFiles.Free;
  FOutputFiles.Free;
  FNameFile.Free;
  inherited;
end;

procedure TCustomNameFileWriter.HandleMF6Files;
begin
  // do nothing
end;

function TCustomNameFileWriter.ArchiveExtension: string;
begin
  result := '';
end;

procedure TCustomNameFileWriter.ClearNameFile;
begin
  NameFile.Clear;
  OutputFiles.Clear;
  InputFiles.Clear;
end;

{ TMt3dmsNameWriter }

function TMt3dmsNameWriter.ArchiveExtension: string;
begin
  Result := '_MT3DMS';
end;

class function TMt3dmsNameWriter.Extension: string;
begin
  result := StrMtName;
end;

procedure TMt3dmsNameWriter.InitilizeNameFile(const FileName: string;
  out OutputListFileName: string);
var
  FtlFileName: string;
begin
  frmErrorsAndWarnings.RemoveErrorGroup(Model, StrMissingFtlFile);
  ClearNameFile;
  AddNameFileComment(Format(StrNameFileForMT3DMS,
    [DateToStr(Now), Model.ProgramName]));
  OutputListFileName := ChangeFileExt(FileName, '.mls');
  WriteToMt3dMsNameFile(StrLIST, Mt3dList, OutputListFileName, foOutput, Model);
  FtlFileName := ChangeFileExt(OutputListFileName, '.ftl');
  if not FileExists(FtlFileName) then
  begin
    frmErrorsAndWarnings.AddError(Model, StrMissingFtlFile,
      Format(StrTheFlowtransportL, [FtlFileName]));
  end;
  WriteToMt3dMsNameFile(StrFTL, Mt3dFtl, FtlFileName, foInput, Model);
  WriteToMt3dMsNameFile(StrDATA, Mt3dCnf, ChangeFileExt(OutputListFileName, '.cnf'), foOutput, Model);
end;

procedure TMt3dmsNameWriter.SaveNameFile(AFileName: string);
var
  ModelName: string;
  NameFileIndex: Integer;
  ALine: string;
  FtlFileName: string;
begin
  inherited;
  ModelName := ExtractFileName(ChangeFileExt((Model as TCustomModel).
    ParentModel.ModelFileName, ''));
  FtlFileName := ModelName + '.ftl';
  for NameFileIndex := 0 to NameFile.Count - 1 do
  begin
    ALine := NameFile[NameFileIndex];
    if Pos(FtlFileName, ALine) > 0 then
    begin
      ALine := StringReplace(ALine, FtlFileName,
        '..\..\output\'+ ModelName + '\' + FtlFileName, []);
      NameFile[NameFileIndex] := ALine;
    end;
  end;


  AFileName := FileName(AFileName) + ArchiveExt;
  NameFile.SaveToFile(AFileName);
  Model.AddMt3dmsInputFile(AFileName);
end;

procedure TCustomNameFileWriter.SaveNameFile(AFileName: string);
var
  NameFileIndex: Integer;
  OutputFileIndex: Integer;
  OutputFile: string;
  ModelName: string;
  ALine: string;
begin
  AFileName := FileName(AFileName);
  HandleMF6Files;
  NameFile.SaveToFile(AFileName);
//  Model.AddModelInputFile(AFileName);

  ModelName := ExtractFileName(ChangeFileExt(AFileName, ''));
  for OutputFileIndex := 0 to FFullOutputFiles.Count - 1 do
  begin
    OutputFile := ExtractFileName(FFullOutputFiles[OutputFileIndex]);

    for NameFileIndex := 0 to NameFile.Count - 1 do
    begin
      ALine := NameFile[NameFileIndex];
      if Pos(OutputFile, ALine) > 0 then
      begin
        ALine := StringReplace(ALine, OutputFile,
          '..\..\output\'+ ModelName + ArchiveExtension + '\' + OutputFile, []);
        NameFile[NameFileIndex] := ALine;
      end;
    end;
  end;

end;

procedure TNameFileWriter.HandleMF6Files;
begin
  if FModel.ModelSelection = msModflow2015 then
  begin
    NameFile.Add('BEGIN INPUT_FILES');
    NameFile.AddStrings(InputFiles);
    NameFile.Add('END INPUT_FILES');
    NameFile.Add('');
    NameFile.Add('BEGIN OUTPUT_FILES');
    NameFile.AddStrings(OutputFiles);
    NameFile.Add('END OUTPUT_FILES');
  end;
end;

procedure TCustomPackageWriter.RemoveNoDefinedError
  (var NoDefinedErrorRoot: string);
begin
  NoDefinedErrorRoot := Format(StrNoDefinedBoundarie,
    [Package.PackageIdentifier]);
  frmErrorsAndWarnings.RemoveErrorGroup(Model, NoDefinedErrorRoot);
end;

procedure TCustomPackageWriter.ShowNoBoundaryError
  (const NoDefinedErrorRoot: string);
begin
  frmErrorsAndWarnings.AddError(Model, NoDefinedErrorRoot,
    Format(StrTheSPackageHasB, [Package.PackageIdentifier]));
end;

procedure TCustomTransientWriter.GetITMP(var ITMP: integer; TimeIndex: integer;
  var List: TValueCellList);
var
  PriorList: TValueCellList;
  IdenticalValues: boolean;
  Cell: TValueCell;
  CellIndex: integer;
  PriorCell: TValueCell;
begin
  List := FValues[TimeIndex];
  ITMP := List.Count;
  if TimeIndex > 0 then
  begin
    PriorList := FValues[TimeIndex - 1];
    if (List.Count = PriorList.Count) and (List.Count > 0) then
    begin
      IdenticalValues := True;
      for CellIndex := 0 to List.Count - 1 do
      begin
        Cell := List[CellIndex] as TValueCell;
        PriorCell := PriorList[CellIndex] as TValueCell;
        if not Cell.IsIdentical(PriorCell) then
        begin
          IdenticalValues := False;
          break;
        end;
      end;
      if IdenticalValues then
      begin
        ITMP := -1;
      end;
    end;
    PriorList.Cache;
  end;
end;

procedure TCustomModflowWriter.WriteMf6_DataSet(DataArray: TDataArray;
  const ID: string);
var
  LayerIndex: integer;
  MF6_ArrayName: string;
begin
  for LayerIndex := 0 to DataArray.LayerCount - 1 do
  begin
    if LayerIndex = 0 then
    begin
      MF6_ArrayName := ID;
    end
    else
    begin
      MF6_ArrayName := '';
    end;
    WriteArray(DataArray, LayerIndex, ID + ' ' + IntToStr(LayerIndex + 1),
      StrNoValueAssigned, MF6_ArrayName, False);
  end;
end;

procedure TCustomModflowWriter.WritePrintFlowsOption;
begin
  { TODO -cMODFLOW-6 : Need to modify for MODFLOW-6 to allow printing and saveing in the same model }
  if Model.ModflowOutputControl.SaveCellFlows = csfListing then
  begin
    WriteString('    PRINT FLOWS');
    NewLine;
  end;
end;

procedure TCustomModflowWriter.WriteSaveFlowsOption;
begin
  { TODO -cMODFLOW-6 : Need to modify for MODFLOW-6 to allow printing and saveing in the same model }
  if Model.ModflowOutputControl.SaveCellFlows = csfBinary then
  begin
    WriteString('    SAVE_FLOWS');
    NewLine;
  end;
end;

procedure TCustomModflowWriter.WriteBeginOptions;
begin
  WriteString('BEGIN OPTIONS');
  NewLine;
end;

procedure TCustomModflowWriter.WriteEndOptions;
begin
  WriteString('END OPTIONS');
  NewLine;
  NewLine;
end;

{ TMf6_SimNameFileWriter }

procedure TMf6_SimNameFileWriter.AddModel(ModelData: TModelData);
begin
  Assert(ModelData.ModelNameFile <> '');
  Assert(ModelData.ModelName <> '');
  Assert(ModelData.SolutionGroup <> '');
  Assert(ModelData.SmsFile <> '');
  Assert(ModelData.MaxIterations > 0);
  FModelDataList.Add(ModelData);
end;

constructor TMf6_SimNameFileWriter.Create(AModel: TCustomModel);
begin
  inherited Create(AModel, etExport);
  FModelDataList := TModelDataList.Create;
end;

destructor TMf6_SimNameFileWriter.Destroy;
begin
  FModelDataList.Free;
  inherited;
end;

class function TMf6_SimNameFileWriter.Extension: string;
begin
  Assert(False);
end;

function TMf6_SimNameFileWriter.GetTDisFileName: string;
begin
  result := FTDisFileName;
end;

function TMf6_SimNameFileWriter.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TMf6_SimNameFileWriter.SetTDisFileName(const Value: string);
begin
  FTDisFileName := Value;
end;

procedure TMf6_SimNameFileWriter.WriteFile(FileName: string);
begin
  if Model.ModelSelection <> msModflow2015 then
  begin
    Exit;
  end;
  FileName := ChangeFileExt(FileName, '.snam');
  OpenFile(FileName);
  try
    WriteOptions;
    WriteTiming;
    WriteModels;
    // WriteExchanges;
    WriteSolutionGroups;

  finally
    CloseFile;
  end;
end;

procedure TMf6_SimNameFileWriter.WriteModels;
var
  ModelIndex: Integer;
begin
  Assert(FModelDataList.Count > 0);
  WriteString('BEGIN MODELS');
  NewLine;

  for ModelIndex := 0 to FModelDataList.Count - 1 do
  begin
    WriteString(FModelDataList[ModelIndex].ModelLine);
    NewLine;
  end;

  WriteString('END MODELS');
  NewLine;
  NewLine;
end;

procedure TMf6_SimNameFileWriter.WriteOptions;
var
  SmsPkg: TSmsPackageSelection;
begin
  SmsPkg := Model.ModflowPackages.SmsPackage;
  if SmsPkg.ContinueModel then
  begin
    WriteBeginOptions;
    WriteString('  CONTINUE');
    NewLine;
    WriteEndOptions;
  end;
end;

procedure TMf6_SimNameFileWriter.WriteSolutionGroups;
var
  ModelIndex: Integer;
  ModelData: TModelData;
  PriorModelData: TModelData;
  isg: Integer;
  NewGroup: boolean;
  NewNumericalLine: Boolean;
begin
  FModelDataList.Sort(TComparer<TModelData>.Construct(
    function (const Left, Right: TModelData): Integer
    begin
      result := AnsiCompareText(Left.SolutionGroup, Right.SolutionGroup);
      if result = 0 then
      begin
        result := AnsiCompareText(Left.SmsFile, Right.SmsFile);
      end;
    end));

  isg := 0;
  for ModelIndex := 0 to FModelDataList.Count - 1 do
  begin
    ModelData := FModelDataList[ModelIndex];
    NewGroup := False;
    NewNumericalLine := False;
    if (ModelIndex = 0) then
    begin
      NewGroup := True;
    end
    else if AnsiCompareText(ModelData.SolutionGroup,
      PriorModelData.SolutionGroup) <> 0 then
    begin
      NewLine;
      WriteString('END SOLUTION_GROUP');
      NewLine;
      NewLine;
      NewGroup := True;
    end;
    if NewGroup then
    begin
      Inc(isg);
      WriteString('BEGIN SOLUTION_GROUP');
      WriteInteger(isg);
      NewLine;

      WriteString('  MXITER');
      WriteInteger(ModelData.MaxIterations);
      NewNumericalLine := True;
    end;

    if AnsiCompareText(ModelData.SmsFile,
      PriorModelData.SmsFile) <> 0 then
    begin
      NewNumericalLine := True;
    end;

    if NewNumericalLine then
    begin
      NewLine;
      WriteString('  NUMERICAL ');
      WriteString('''' +  ModelData.SmsFile + ''' ');
    end;
    WriteString('''' +  ModelData.ModelName + ''' ');

    PriorModelData := ModelData;
  end;


  NewLine;
  WriteString('END SOLUTION_GROUP');
  NewLine;
  NewLine;
end;

procedure TMf6_SimNameFileWriter.WriteTiming;
begin
  Assert(TDisFileName <> '');
  WriteString('BEGIN TIMING');
  NewLine;

  WriteString('  TDIS ');
  WriteString('''' + TDisFileName+ '''');
  NewLine;

  WriteString('END TIMING');
  NewLine;
  NewLine;
end;

function TMf6_SimNameFileWriter._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TMf6_SimNameFileWriter._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

procedure TCustomTransientWriter.WriteDimensionsMF6; var MAXBOUND: integer;
begin
  CountCells(MAXBOUND);
  WriteString('BEGIN DIMENSIONS');
  NewLine;
  WriteString('  MAXBOUND');
  WriteInteger(MAXBOUND);
  NewLine;
  WriteString('END DIMENSIONS');
  NewLine;
  NewLine;
end;

procedure TCustomListWriter.WriteListOptions;
begin
  { TODO -cmodflow2015 : Support additional MODFLOW-6 options }
  // PACKAGENAME not currently supported.
  WriteString('    AUXILIARY IFACE');
  NewLine;

  WriteString('    BOUNDNAMES');
  NewLine;

  PrintListInputOption;
  WritePrintFlowsOption;
  WriteSaveFlowsOption;
  // TIMESERIESFILE not currently supported.
  // NEWTON not currently supported.
end;

procedure TCustomListWriter.WriteOptionsMF6;
begin
  WriteBeginOptions;
  try
    WriteListOptions;
  finally
    WriteEndOptions;
  end;
end;

procedure TCustomListWriter.WriteBoundName(ACell: TValueCell);
var
  NameIndexString: string;
  NameIndex: integer;
  Root: string;
  MaxRootLength: integer;
  ScreenObject: TScreenObject;
  BoundPos: integer;
  BoundName: string;
begin
  if (Model.ModelSelection = msModflow2015) then
  begin
    if ACell.ScreenObject = nil then
    begin
      WriteString(' _ ');
    end
    else
    begin
      ScreenObject := ACell.ScreenObject as TScreenObject;
      BoundName := ScreenObject.Name;
      BoundPos := FObjectNames.IndexOf(BoundName);
      if BoundPos >= 0 then
      begin
        BoundName := FBoundNames[BoundPos];
      end
      else
      begin
        BoundPos := FObjectNames.Add(BoundName);
        BoundName := Copy(BoundName, 1, 16);
        if FBoundNames.IndexOf(BoundName) >= 0 then
        begin
          Root := BoundName;
          NameIndex := 1;
          repeat
            NameIndexString := Format('%d', [NameIndex]);
            Inc(NameIndex);
            MaxRootLength := 16 - Length(NameIndexString);
            BoundName := Copy(Root, 1, MaxRootLength) + NameIndexString;
          until (FBoundNames.IndexOf(BoundName) < 0);
        end;
        FBoundNames.Insert(BoundPos, BoundName);
      end;
      BoundName := ' ' + BoundName + ' ';
      WriteString(BoundName);
    end;
  end;
end;

end.
