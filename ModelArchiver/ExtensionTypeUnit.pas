unit ExtensionTypeUnit;

interface

uses sysUtils, Generics.Collections, Generics.Defaults;

Type
  TExtensionType = (etModelInput, etModelOutput, etModpathInput,
  etModpathOutput, etZoneBudgetInput, etZoneBudgetOutput, etMt3dmsInput,
  etMt3dmsOutput, etAncillary);

  TExtensionObject = Class(TObject)
    Extension: string;
    ExtensionType: TExtensionType;
    Description: string;
  end;

  TExtensionList = class (TObjectList<TExtensionObject>)
  public
    procedure SetDefaultExtensions;
    procedure SortRecords;
  end;

function ExtractFileExtendedExt(FileName: string): string;

implementation

function ExtractFileExtendedExt(FileName: string): string;
var
  AnExt: string;
begin
  result := '';
  repeat
    AnExt := ExtractFileExt(FileName);
    result := AnExt + result;
//    result := ExtractFileExt(FileName);
    FileName := ChangeFileExt(FileName, '');
  until ((AnExt = '') or AnsiSameText(AnExt, '.reference'));
end;

{ TExtensionList }

procedure TExtensionList.SetDefaultExtensions;
var
  ExtRec: TExtensionObject;
begin
  Clear;

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.nam';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.nam.archive';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mt_nam';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mt_nam.archive';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mto';
  ExtRec.ExtensionType := etMt3dmsOutput;
  ExtRec.Description := 'MT3DMS Observation Output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.jtf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'Jupiter Template file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.dis';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Discretization file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bas';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Basic Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lpf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Layer Property Flow Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zon';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Zone Array input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mlt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Mulitplier Array input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.chd';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Time-Variant Specified Head Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.pcg';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Preconditioned Conjugate Gradient Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ghb';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW General Head Boundary Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.wel';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Well Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.riv';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW River Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.drn';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Drain Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.drt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Drain-Return Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rch';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Recharge Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.evt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ets';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Segments Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.res';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Reservoir Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lak';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Lake Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sfr';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Streamflow Routing Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.uzf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Unsaturated Zone Flow Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gmg';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Geometric Multigrid Flow Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sip';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Strongly Implicit Procedure Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.de4';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Direct Solver Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.oc';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Output Control input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gag';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Gage Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_hob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Head Observation Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.hfb';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Horizontal Flow Barrier Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.strt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODPATH Starting Locations input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpm';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Main input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpbas';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Basic input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.tim';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Time input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mprsp';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Response input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mprsp.archive';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Response input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpsim';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODPATH Simulation input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpsim.archive';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODPATH Simulation input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.huf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Hydrogeologic Unit Flow Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.kdep';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Hydraulic-Conductivity Depth-Dependence Capability input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lvda';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Model-Layer Variable-Direction Horizontal Anisotropy Capability input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mnw2';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Multi-Node Well Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bcf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Block-Centered Flow Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sub';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Subsidence and Aquifer-System Compaction Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zb_zones';
  ExtRec.ExtensionType := etZonebudgetInput;
  ExtRec.Description := 'ZONEBUDGET Zoned input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zb_response';
  ExtRec.ExtensionType := etZonebudgetInput;
  ExtRec.Description := 'ZONEBUDGET Response file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zb_response.archive';
  ExtRec.ExtensionType := etZonebudgetInput;
  ExtRec.Description := 'ZONEBUDGET Response file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.swt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Subsidence and Aquifer-System Compaction Package for Water-Table Aquifers input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.hyd';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW HYDMOD Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lgr';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-LGR Local Grid Refinement input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lgr.archive';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-LGR Local Grid Refinement input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.nwt';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-NWT Newton Solver Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.upw';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-NWT Upstream Weighting Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.btn';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Basic Transport Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.adv';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Advection Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.dsp';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Dispersion Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ssm';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Sink and Source Mixing Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rct';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Chemical Reactions Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gcg';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Generalized Conjugate Gradient Solver Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.tob';
  ExtRec.ExtensionType := etMt3dmsInput;
  ExtRec.Description := 'MT3DMS Transport Observation Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lmt';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Link to MT3DMS output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.pcgn';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Preconditioned Conjugate Gradient Solver with Improved Nonlinear Control input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.FluxBcs';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Flow time-dependent sources and boundary conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.UFluxBcs';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA concentration or enerty time-dependent sources and boundary conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SPecPBcs';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Specified pressure time-dependent sources and boundary conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SPecUBcs';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Specified concentration or temperature time-dependent sources and boundary conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.8d';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA input file data set 8D';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.inp';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Main input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ics';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Initial Conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.str';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Stream Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fhb';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Flow and Head Boundary Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fmp';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ROOT';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 11';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SW_Losses';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 13';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.PSI';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 14';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ET_Func';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 15';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.TimeSeries';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 16';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.IFALLOW';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 17';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.CropFunc';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 34';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.WaterCost';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 35';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.FID';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 26';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.OFE';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 7';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.CID';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 28';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.CropUse';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 30a';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ETR';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 30b';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ET_Frac';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Farm Process input file data set 12';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.cfp';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-CFP Conduit Flow Process input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.swi';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Seawater Intrusion Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.swr';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-NWT Surface-Water Routing Process input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mnw1';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Multi-Node Well Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ic';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-6 Initial Conditions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.npf';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-6 Node Property Flow package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sto';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-6 Storage package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sms';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-6 Sparse Matrix Solution package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.tdis';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-6 Time-Discretization input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rip';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-OWHM Riparean Evapotranspiration Package input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lkin';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Lake input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bcof';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Fluid Source Boundary Condition input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bcos';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Solute or Energy Source Boundary Condition input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bcop';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Specified Pressure input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bcou';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA Specified Concentration or Temperature input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fil';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA File Assignment input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fil.archive';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'SUTRA File Assignment input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.pval';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Parameter Value input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rch.R_Mult*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Recharge Multiplier Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.evt.ET_Mult*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Multiplier Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ets.ETS_Mult*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Segments Multiplier Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rch.R_Zone*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Recharge Zone Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.evt.ET_Zone*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Zone Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ets.ETS_Zone*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Evapotranspiration Segments Zone Array';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ftl';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW MT3DMS Flow Transport Link input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lst';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Listing file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fhd';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Formatted Head file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bhd';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Binary Head file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fdn';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Formatted Drawdown file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bdn';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Binary Drawdown file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.cbc';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Cell-By-Cell flow file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.huf_fhd';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW HUF Formatted Head file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.huf_bhd';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW HUF Binary Head file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.huf_flow';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW HUF Flow File';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Sub_Out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Combined SUB output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swt_Out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Combined SWT output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubSubOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Subsidence output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubComMlOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Compaction by model layer output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubComIsOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Compaction by interbed system output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubVdOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Vertical displacement output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubNdCritHeadOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Critical head for no-delay interbeds output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SubDCritHeadOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SUB Critical head for delay interbeds output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtSubOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Subsidence output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtComMLOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Compaction by model layer output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtComIsOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Compaction by interbed system output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtVDOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Vertical displacement output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtPreConStrOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Preconsolidation stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtDeltaPreConStrOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Change in preconsolidation stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtGeoStatOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Geostatic stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtDeltaGeoStatOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Change in geostatic stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtEffStressOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Effective stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtDeltaEffStressOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Change in effective stress output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtVoidRatioOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Void ratio output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtThickCompSedOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Thickness of compressible sediments output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.SwtLayerCentElevOut';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWT Layer-center elevation output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ucn';
  ExtRec.ExtensionType := etMt3dmsOutput;
  ExtRec.Description := 'MT3DMS Concentration output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zta';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Zeta Surface output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachGroupFlows_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Group Flows ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachGroupFlows_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Group Flows binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachStage_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Stage ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachStage_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Stage binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachExchange_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Exchange ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_ReachExchange_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Reach Exchange binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_LateralFlow_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Lateral Flow ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_LateralFlow_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Lateral Flow binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_StructureFlow_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Structure Flow ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_StructureFlow_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Structure Flow binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_TimeStepLength_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Time Step Length ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_TimeStepLength_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Time Step Length binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_Convergence';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Convergence output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_RIV';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW River package file created by the SWR Package';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_Obs_A';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Observation ASCII output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_Obs_B';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Observation binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.Swr_DirectRunoff';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SWR Direct Runoff output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.nod';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Node output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ele';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Element output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.OUT';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA main output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.FDS_BIN';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Farm Process Demand and Supply binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.FB_COMPACT_BIN_OUT';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Farm Process Farm Compact Budget binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.FB_DETAILS_BIN_OUT';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Farm Process Farm Detailed Budget binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fpb';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'Footprint binary output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fpt';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'Footprint text output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bfh_head';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW-LGR Boundary Flow and Head Package file for heads';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.bfh_flux';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW-LGR Boundary Flow and Head Package file for flows';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.csv';
  ExtRec.ExtensionType := etZonebudgetOutput;
  ExtRec.Description := 'ZONEBUDGET Comma Separated Values file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.2.csv';
  ExtRec.ExtensionType := etZonebudgetOutput;
  ExtRec.Description := 'ZONEBUDGET Comma Separated Values file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.hob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Head Observations output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_chob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Specified Heads input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_gbob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Observations of Flow at General Head Boundaries input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_rvob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Rivers input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_drob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Drains input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ob_stob';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Streams input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rvob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Rivers output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.chob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Specified Heads output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gbob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Observations of Flow at General Head Boundaries output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.drob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Drains output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.stob_out';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW Observations of Flow at Streams output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.obs';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Observation Output file in OBS format';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.obc';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Observation Output file in OBC format';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.rst';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Restart file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.smy';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA Simulation Progress file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.zblst';
  ExtRec.ExtensionType := etZonebudgetOutput;
  ExtRec.Description := 'ZONEBUDGET Listing File';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gsf';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'PEST Grid Specification file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gpt';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'ModelMuse text file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.gpb';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'ModelMuse binary file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mmZLib';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'ModelMuse compressed binary file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.axml';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'ModelMuse Archive Information file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.reference';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'Georeference file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.shp';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile shapes file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.shx';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile shape index file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.dbf';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile attribute database';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.prj';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Projection file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sbn';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile spatial index of the features';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sbx';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile spatial index of the features';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fbn';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile spatial index of the read-only features';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.fbx';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile spatial index of the read-only features';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ain';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile attribute index of the active fields in a table';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.aix';
  ExtRec.ExtensionType := etAncillary;
  ExtRec.Description := 'Shapefile attribute index of the active fields in a table';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.aix';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile geocoding index for read-write datasets';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mxs';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile geocoding index for read-write datasets (ODB format)';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.atx';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile an attribute index for the .dbf file in the form of shapefile.columnname.atx (ArcGIS 8 and later)';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.shp.xml';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile geospatial metadata in XML format, such as ISO 19115 or other XML schema';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.cpg';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile used to specify the code page (only for .dbf) for identifying the character encoding to be used';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.qix';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'Shapefile an alternative quadtree spatial index used by MapServer and GDAL/OGR software';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpn';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mpn.archive';
  ExtRec.ExtensionType := etModpathInput;
  ExtRec.Description := 'MODPATH Name file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.end';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Endpoint file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.end_bin';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Binary Endpoint file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.path';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Pathline file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.path_bin';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Binary Pathline file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ts';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Timeseries file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.ts_bin';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Binary Timeseries file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.cbf';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Budget file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mplst';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Listing file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.log';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH log file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.mls';
  ExtRec.ExtensionType := etMt3dmsOutput;
  ExtRec.Description := 'MT3DMS listing file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '._mas';
  ExtRec.ExtensionType := etMt3dmsOutput;
  ExtRec.Description := 'MT3DMS Mass Budget Output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.dat';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'PHAST thermodynamic database input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.trans.dat';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'PHAST transport input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.chem.dat';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'PHAST chemical-reactions input file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.chem.dat';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST chemical-reactions output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.head.dat';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST head output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.h5';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST data output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.kd';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST fluid and solute-dispersive conductance distributions output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.head';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST potentiometric head output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.xyz.head';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST potentiometric head output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.comps';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST component concentration distributions output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.xyz.comps';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST component concentration distributions output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.chem';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST selected chemical information output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.xyz.chem';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST selected chemical information output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.vel';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST velocity distribution output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.xyz.vel';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST velocity distribution output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.wel';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST well data output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.xyz.wel';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST well data output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.bal';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST regional fluid-flow and solute-flow rates and the regional cumulative-flow results output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.bcf';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST fluid and solute flow rates through boundaries output file';
  Add(ExtRec);


  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.cnf';
  ExtRec.ExtensionType := etMt3dmsOutput;
  ExtRec.Description := 'MT3DMS Grid Configuration output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.O.probdef';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST Flow and transport problem definition output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sel';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'PHAST Selected Output';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.sfrg*';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW SFR Gage output';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.lakg*';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW LAK Gage output';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.restart.gz';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'SUTRA restart file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.advobs';
  ExtRec.ExtensionType := etModpathOutput;
  ExtRec.Description := 'MODPATH Advection Observation file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.UzfRch';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW UZF Recharge output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.UzfDisch';
  ExtRec.ExtensionType := etModelOutput;
  ExtRec.Description := 'MODFLOW UZF Discharge output file';
  Add(ExtRec);

  ExtRec := TExtensionObject.Create;
  ExtRec.Extension := '.wel_tab*';
  ExtRec.ExtensionType := etModelInput;
  ExtRec.Description := 'MODFLOW-NWT Well tab file';
  Add(ExtRec);

  SortRecords;
end;

procedure TExtensionList.SortRecords;
begin
  Sort(TComparer<TExtensionObject>.Construct(function
    (const Left, Right: TExtensionObject): Integer
  begin
    Result := AnsiCompareText(Left.Extension,Right.Extension);
  end));
end;

end.
