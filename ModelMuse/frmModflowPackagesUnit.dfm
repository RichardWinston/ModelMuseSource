object frmModflowPackages: TfrmModflowPackages
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpKeyword = 'MODFLOW_Packages_Dialog_Box'
  Caption = 'MODFLOW Packages and Programs'
  ClientHeight = 555
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 177
    Top = 0
    Height = 514
    Align = alLeft
    MinSize = 1
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitLeft = 121
    ExplicitTop = -14
    ExplicitHeight = 252
  end
  object jvplPackages: TJvPageList
    Left = 187
    Top = 0
    Width = 595
    Height = 514
    ActivePage = jvspCHD
    PropagateEnable = False
    Align = alClient
    OnChange = jvplPackagesChange
    object jvspLPF: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'LPF_Layer_Property_Flow_Package'
      Caption = 'LPF (Layer Property Flow)'
      object splitLprParameter: TJvNetscapeSplitter
        Left = 121
        Top = 291
        Height = 223
        Align = alLeft
        MinSize = 1
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        ExplicitLeft = 256
        ExplicitTop = 96
        ExplicitHeight = 100
      end
      object JvNetscapeSplitter3: TJvNetscapeSplitter
        Left = 0
        Top = 281
        Width = 595
        Height = 10
        Cursor = crVSplit
        Align = alTop
        MinSize = 1
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        ExplicitLeft = -4
        ExplicitTop = 283
        ExplicitWidth = 605
      end
      inline frameLpfParameterDefinition: TframeArrayParameterDefinition
        Left = 131
        Top = 291
        Width = 464
        Height = 223
        Align = alClient
        Enabled = False
        TabOrder = 2
        TabStop = True
        ExplicitLeft = 131
        ExplicitTop = 291
        ExplicitWidth = 464
        ExplicitHeight = 223
        inherited pnlParameterCount: TPanel
          Top = 175
          Width = 464
          ExplicitTop = 175
          ExplicitWidth = 464
          inherited btnDelete: TBitBtn
            Left = 351
            Top = 9
            Enabled = True
            TabOrder = 1
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 351
            ExplicitTop = 9
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            Enabled = True
            TabOrder = 0
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 458
          Height = 112
          Enabled = True
          Columns = <
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = False
              ButtonWidth = 20
              CheckMax = False
              CheckMin = False
              ComboUsed = False
              Format = rcf4String
              LimitToList = False
              MaxLength = 10
              ParentButtonFont = False
              WordWrapCaptions = False
              WordWrapCells = False
              CaseSensitivePicklist = False
              CheckStyle = csCheck
              AutoAdjustColWidths = True
            end
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = False
              ButtonWidth = 20
              CheckMax = False
              CheckMin = False
              ComboUsed = False
              Format = rcf4Real
              LimitToList = False
              MaxLength = 0
              ParentButtonFont = False
              WordWrapCaptions = False
              WordWrapCells = False
              CaseSensitivePicklist = False
              CheckStyle = csCheck
              AutoAdjustColWidths = True
            end
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = False
              ButtonWidth = 20
              CheckMax = False
              CheckMin = False
              ComboUsed = False
              Format = rcf4Boolean
              LimitToList = False
              MaxLength = 0
              ParentButtonFont = False
              WordWrapCaptions = False
              WordWrapCells = False
              CaseSensitivePicklist = False
              CheckStyle = csCheck
              AutoAdjustColWidths = True
            end
            item
              AutoAdjustRowHeights = False
              ButtonCaption = '...'
              ButtonFont.Charset = DEFAULT_CHARSET
              ButtonFont.Color = clWindowText
              ButtonFont.Height = -11
              ButtonFont.Name = 'Tahoma'
              ButtonFont.Style = []
              ButtonUsed = False
              ButtonWidth = 20
              CheckMax = False
              CheckMin = False
              ComboUsed = False
              Format = rcf4Boolean
              LimitToList = False
              MaxLength = 0
              ParentButtonFont = False
              WordWrapCaptions = False
              WordWrapCells = False
              CaseSensitivePicklist = False
              CheckStyle = csCheck
              AutoAdjustColWidths = True
            end>
          ExplicitWidth = 458
          ExplicitHeight = 112
          ColWidths = (
            64
            64
            64
            64)
        end
        inherited pnlTop: TPanel
          Width = 464
          ExplicitWidth = 464
        end
      end
      object tvLpfParameterTypes: TTreeView
        Left = 0
        Top = 291
        Width = 121
        Height = 223
        Align = alLeft
        Enabled = False
        HideSelection = False
        Indent = 20
        ReadOnly = True
        TabOrder = 1
        OnChange = tvLpfParameterTypesChange
      end
      inline framePkgLPF: TframePackageLpf
        Left = 0
        Top = 0
        Width = 595
        Height = 281
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 281
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rdgOptions: TRbwDataGrid4
          Width = 567
          ExplicitWidth = 567
          RowHeights = (
            24
            24
            24
            24
            24
            24)
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgLPF.lblComments
            end
            item
              Control = framePkgLPF.memoComments
            end
            item
              Control = framePkgLPF.rdgOptions
            end>
          OnEnabledChange = framePkgLPFrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspHUF: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'HUF2_Hydrogeologic_Unit_Flow'
      Caption = 'jvspHUF'
      object JvNetscapeSplitter4: TJvNetscapeSplitter
        Left = 0
        Top = 275
        Width = 595
        Height = 10
        Cursor = crVSplit
        Align = alTop
        MinSize = 1
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        ExplicitTop = 204
        ExplicitWidth = 605
      end
      object JvNetscapeSplitter5: TJvNetscapeSplitter
        Left = 121
        Top = 285
        Height = 229
        Align = alLeft
        MinSize = 1
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        ExplicitLeft = 256
        ExplicitTop = 96
        ExplicitHeight = 100
      end
      inline framePkgHuf: TframePackageHuf
        Left = 0
        Top = 0
        Width = 595
        Height = 275
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        DesignSize = (
          595
          275)
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited cbSaveHeads: TCheckBox
          Width = 441
          ExplicitWidth = 441
        end
        inherited cbSaveFlows: TCheckBox
          Width = 417
          ExplicitWidth = 417
        end
        inherited rgElevationSurfaceChoice: TRadioGroup
          Width = 313
          ExplicitWidth = 313
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgHuf.lblComments
            end
            item
              Control = framePkgHuf.memoComments
            end
            item
              Control = framePkgHuf.cbSaveHeads
            end
            item
              Control = framePkgHuf.cbSaveFlows
            end
            item
              Control = frameHufParameterDefinition
            end
            item
              Control = tvHufParameterTypes
            end>
          OnEnabledChange = framePkgHufrcSelectionControllerEnabledChange
        end
      end
      object tvHufParameterTypes: TTreeView
        Left = 0
        Top = 285
        Width = 121
        Height = 229
        Align = alLeft
        Enabled = False
        HideSelection = False
        Indent = 20
        ReadOnly = True
        TabOrder = 1
        OnChange = tvHufParameterTypesChange
      end
      inline frameHufParameterDefinition: TframeListParameterDefinition
        Left = 131
        Top = 285
        Width = 464
        Height = 229
        Align = alClient
        Enabled = False
        TabOrder = 2
        TabStop = True
        ExplicitLeft = 131
        ExplicitTop = 285
        ExplicitWidth = 464
        ExplicitHeight = 229
        inherited pnlParameterCount: TPanel
          Top = 181
          Width = 464
          ExplicitTop = 181
          ExplicitWidth = 464
          inherited btnDelete: TBitBtn
            Left = 351
            Top = 9
            Enabled = True
            TabOrder = 1
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 351
            ExplicitTop = 9
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            TabOrder = 0
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 458
          Height = 175
          Enabled = True
          ExplicitWidth = 458
          ExplicitHeight = 175
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspCHD: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'CHD_Time_Variant_Specified_Head'
      Caption = 'CHD (Time-Variant Specified-Head Package)'
      inline framePkgCHD: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgCHD.lblComments
            end
            item
              Control = framePkgCHD.memoComments
            end
            item
              Control = frameChdParameterDefinition
            end>
          Left = 120
        end
      end
      inline frameChdParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            Top = 9
            TabOrder = 1
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
            ExplicitTop = 9
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 24
            TabOrder = 0
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 24
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspGHB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'GHB_General_Head_Boundary_Package'
      Caption = 'GHB (General Head Boundary)'
      inline framePkgGHB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgGHB.lblComments
            end
            item
              Control = framePkgGHB.memoComments
            end
            item
              Control = frameGhbParameterDefinition
            end>
        end
      end
      inline frameGhbParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspPCG: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'PCG_Preconditioned_Conjugate_Gradiant'
      Caption = 'PCG (Preconditioned Conjugate-Gradient)'
      inline framePCG: TframePCG
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited lblPCGMaxOuter: TLabel
          Top = 127
          ExplicitTop = 127
        end
        inherited lblPCGMaxInner: TLabel
          Top = 155
          ExplicitTop = 155
        end
        inherited lblPCGMethod: TLabel
          Top = 183
          ExplicitTop = 183
        end
        inherited lblPCGMaxChangeHead: TLabel
          Top = 295
          ExplicitTop = 295
        end
        inherited lblPCGMaxResidual: TLabel
          Top = 323
          ExplicitTop = 323
        end
        inherited lblPCGRelaxation: TLabel
          Top = 351
          ExplicitTop = 351
        end
        inherited lblPCGMaxEigen: TLabel
          Top = 379
          ExplicitTop = 379
        end
        inherited lblPCGPrintInterval: TLabel
          Top = 406
          ExplicitTop = 406
        end
        inherited lblPCGPrintControl: TLabel
          Top = 434
          ExplicitTop = 434
        end
        inherited lblPCGDampingFactor: TLabel
          Top = 461
          ExplicitTop = 461
        end
        inherited lblPCGDampPcgT: TLabel
          Top = 489
          ExplicitTop = 489
        end
        inherited memoComments: TMemo
          Width = 574
          ExplicitWidth = 574
        end
        inherited rdePCGMaxOuter: TRbwDataEntry
          Top = 124
          Width = 242
          ExplicitTop = 124
          ExplicitWidth = 242
        end
        inherited rdePCGMaxInner: TRbwDataEntry
          Top = 152
          Width = 242
          ExplicitTop = 152
          ExplicitWidth = 242
        end
        inherited comboPCGPrecondMeth: TJvImageComboBox
          Top = 180
          Width = 242
          ExplicitTop = 180
          ExplicitWidth = 242
        end
        inherited rdePCGMaxHeadChange: TRbwDataEntry
          Top = 292
          Width = 242
          ExplicitTop = 292
          ExplicitWidth = 242
        end
        inherited rdePCGMaxResChange: TRbwDataEntry
          Top = 320
          Width = 242
          ExplicitTop = 320
          ExplicitWidth = 242
        end
        inherited rdePCGRelax: TRbwDataEntry
          Top = 348
          Width = 242
          ExplicitTop = 348
          ExplicitWidth = 242
        end
        inherited comboPCGEigenValue: TJvImageComboBox
          Top = 376
          Width = 242
          ExplicitTop = 376
          ExplicitWidth = 242
        end
        inherited rdePCGPrintInt: TRbwDataEntry
          Top = 403
          Width = 242
          ExplicitTop = 403
          ExplicitWidth = 242
        end
        inherited comboPCGPrint: TJvImageComboBox
          Top = 431
          Width = 242
          ExplicitTop = 431
          ExplicitWidth = 242
        end
        inherited rdePCGDamp: TRbwDataEntry
          Top = 458
          Width = 242
          ExplicitTop = 458
          ExplicitWidth = 242
        end
        inherited rdePCGDampPcgT: TRbwDataEntry
          Top = 486
          Width = 242
          ExplicitTop = 486
          ExplicitWidth = 242
        end
        inherited gbIHCOFADD: TGroupBox
          Top = 202
          Anchors = [akLeft, akBottom]
          ExplicitTop = 202
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePCG.lblComments
            end
            item
              Control = framePCG.memoComments
            end
            item
              Control = framePCG.comboPCGPrecondMeth
            end
            item
              Control = framePCG.comboPCGPrint
            end
            item
              Control = framePCG.rdePCGDamp
            end
            item
              Control = framePCG.rdePCGMaxHeadChange
            end
            item
              Control = framePCG.rdePCGMaxInner
            end
            item
              Control = framePCG.rdePCGMaxOuter
            end
            item
              Control = framePCG.rdePCGMaxResChange
            end
            item
              Control = framePCG.rdePCGPrintInt
            end
            item
              Control = framePCG.rdePCGDampPcgT
            end
            item
              Control = framePCG.rbIHCOFADD_0
            end
            item
              Control = framePCG.rbIHCOFADD_1
            end>
        end
      end
    end
    object jvspWEL: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'WEL_Well_Package_Pane'
      Caption = 'jvspWEL'
      inline framePkgWEL: TframePackageWell
        Left = 0
        Top = 0
        Width = 595
        Height = 241
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 241
        DesignSize = (
          595
          241)
        inherited memoComments: TMemo
          Width = 564
          Height = 124
          ExplicitWidth = 564
          ExplicitHeight = 124
        end
        inherited cbTabfiles: TCheckBox
          Width = 569
          ExplicitWidth = 569
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgWEL.lblComments
            end
            item
              Control = framePkgWEL.memoComments
            end
            item
              Control = framePkgWEL.rdePhiRamp
            end
            item
              Control = frameWelParameterDefinition
            end
            item
              Control = framePkgWEL.cbTabfiles
            end>
          Left = 408
          Top = 96
        end
      end
      inline frameWelParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 241
        Width = 595
        Height = 273
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 241
        ExplicitWidth = 595
        ExplicitHeight = 273
        inherited pnlParameterCount: TPanel
          Top = 225
          Width = 595
          ExplicitTop = 225
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 219
          ExplicitWidth = 589
          ExplicitHeight = 219
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspRIV: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RIV_River_Package'
      Caption = 'jvspRIV'
      inline framePkgRIV: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgRIV.lblComments
            end
            item
              Control = framePkgRIV.memoComments
            end
            item
              Control = frameRivParameterDefinition
            end>
        end
      end
      inline frameRivParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspDRN: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'DRN_Drain_Package_Pane'
      Caption = 'jvspDRN'
      inline framePkgDRN: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgDRN.lblComments
            end
            item
              Control = framePkgDRN.memoComments
            end
            item
              Control = frameDrnParameterDefinition
            end>
        end
      end
      inline frameDrnParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspDRT: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'DRT_Drain_Return_Package_Pane'
      Caption = 'jvspDRT'
      inline framePkgDRT: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgDRT.lblComments
            end
            item
              Control = framePkgDRT.memoComments
            end
            item
              Control = frameDrtParameterDefinition
            end>
        end
      end
      inline frameDrtParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspRCH: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RCH_Recharge_Package_Pane'
      Caption = 'jvspRCH'
      inline framePkgRCH: TframePackageRCH
        Left = 0
        Top = 0
        Width = 595
        Height = 249
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 249
        inherited memoComments: TMemo
          Width = 574
          Height = 81
          ExplicitWidth = 574
          ExplicitHeight = 81
        end
        inherited pnLayerOption: TPanel
          Top = 149
          Width = 595
          ExplicitTop = 149
          ExplicitWidth = 595
          inherited lblLayerOption: TLabel
            Width = 141
            Caption = 'Recharge location option'
            ExplicitWidth = 141
          end
          inherited cbTimeVaryingLayers: TCheckBox
            Caption = 'Time varying recharge layers'
          end
          inherited rgAssignmentMethod: TRadioGroup
            Width = 574
            ExplicitWidth = 574
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgRCH.lblComments
            end
            item
              Control = framePkgRCH.memoComments
            end
            item
              Control = framePkgRCH.cbTimeVaryingLayers
            end
            item
              Control = framePkgRCH.comboLayerOption
            end
            item
              Control = framePkgRCH.lblLayerOption
            end
            item
              Control = framePkgRCH.rgAssignmentMethod
            end
            item
              Control = frameRchParameterDefinition
            end>
          OnEnabledChange = framePkgRCHrcSelectionControllerEnabledChange
        end
      end
      inline frameRchParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 249
        Width = 595
        Height = 265
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 249
        ExplicitWidth = 595
        ExplicitHeight = 265
        inherited pnlParameterCount: TPanel
          Top = 217
          Width = 595
          ExplicitTop = 217
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 211
          ExplicitWidth = 589
          ExplicitHeight = 211
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspEVT: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'EVT_Evapotranspiration_Package'
      Caption = 'jvspEVT'
      inline framePkgEVT: TframePackageTransientLayerChoice
        Left = 0
        Top = 0
        Width = 595
        Height = 201
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 574
          ExplicitWidth = 574
        end
        inherited pnLayerOption: TPanel
          Width = 595
          ExplicitWidth = 595
          inherited lblLayerOption: TLabel
            Width = 110
            Caption = 'EVT location option'
            ExplicitWidth = 110
          end
          inherited cbTimeVaryingLayers: TCheckBox
            Caption = 'Time varying EVT layers'
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgEVT.lblComments
            end
            item
              Control = framePkgEVT.memoComments
            end
            item
              Control = framePkgEVT.cbTimeVaryingLayers
            end
            item
              Control = framePkgEVT.comboLayerOption
            end
            item
              Control = framePkgEVT.lblLayerOption
            end
            item
              Control = frameEvtParameterDefinition
            end>
          OnEnabledChange = framePkgEVTrcSelectionControllerEnabledChange
        end
      end
      inline frameEvtParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 201
        Width = 595
        Height = 313
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 201
        ExplicitWidth = 595
        ExplicitHeight = 313
        inherited pnlParameterCount: TPanel
          Top = 265
          Width = 595
          ExplicitTop = 265
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 259
          ExplicitWidth = 589
          ExplicitHeight = 259
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspETS: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'ETS_Evapotranspiration_Segments_Package'
      Caption = 'jvspETS'
      inline framePkgETS: TframeEtsPackage
        Left = 0
        Top = 0
        Width = 595
        Height = 226
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 574
          ExplicitWidth = 574
        end
        inherited pnLayerOption: TPanel
          Width = 595
          ExplicitWidth = 595
          inherited lblLayerOption: TLabel
            Width = 110
            Caption = 'ETS location option'
            ExplicitWidth = 110
          end
          inherited cbTimeVaryingLayers: TCheckBox
            Caption = 'Time varying ETS layers'
          end
          inherited seSegments: TJvSpinEdit
            Height = 26
            ExplicitHeight = 26
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgETS.lblComments
            end
            item
              Control = framePkgETS.memoComments
            end
            item
              Control = framePkgETS.cbTimeVaryingLayers
            end
            item
              Control = framePkgETS.comboLayerOption
            end
            item
              Control = framePkgETS.lblLayerOption
            end
            item
              Control = framePkgETS.seSegments
            end
            item
              Control = framePkgETS.lblSegments
            end
            item
              Control = frameEtsParameterDefinition
            end>
        end
      end
      inline frameEtsParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 226
        Width = 595
        Height = 288
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 226
        ExplicitWidth = 595
        ExplicitHeight = 288
        inherited pnlParameterCount: TPanel
          Top = 240
          Width = 595
          ExplicitTop = 240
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 234
          ExplicitWidth = 589
          ExplicitHeight = 234
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspRES: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RES_Reservoir_Package_Pane'
      Caption = 'jvspRES'
      inline framePkgRES: TframePackageRes
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 574
          Height = 367
          ExplicitWidth = 574
          ExplicitHeight = 367
        end
        inherited pnLayerOption: TPanel
          Top = 438
          Width = 595
          ExplicitTop = 438
          ExplicitWidth = 595
          inherited lblLayerOption: TLabel
            Top = 5
            ExplicitTop = 5
          end
          inherited lblTableSize: TLabel
            Top = 54
            ExplicitTop = 54
          end
          inherited cbPrintStage: TCheckBox
            Width = 561
            Height = 18
            ExplicitWidth = 561
            ExplicitHeight = 18
          end
          inherited seTableSize: TJvSpinEdit
            Top = 51
            Height = 26
            ExplicitTop = 51
            ExplicitHeight = 26
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgRES.lblComments
            end
            item
              Control = framePkgRES.memoComments
            end
            item
              Control = framePkgRES.cbTimeVaryingLayers
            end
            item
              Control = framePkgRES.comboLayerOption
            end
            item
              Control = framePkgRES.lblLayerOption
            end
            item
              Control = framePkgRES.cbPrintStage
            end
            item
              Control = framePkgRES.seTableSize
            end
            item
              Control = framePkgRES.lblTableSize
            end>
        end
      end
    end
    object jvspLAK: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'LAK_Lake_Package_Pane'
      Caption = 'jvspLAK'
      inline framePkgLAK: TframePackageLAK
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblTheta: TLabel
          Left = 168
          Top = 295
          ExplicitLeft = 168
          ExplicitTop = 295
        end
        inherited lblIterations: TLabel
          Left = 168
          Top = 323
          ExplicitLeft = 168
          ExplicitTop = 323
        end
        inherited lblConvergenceCriterion: TLabel
          Left = 168
          Top = 351
          ExplicitLeft = 168
          ExplicitTop = 351
        end
        inherited lblSurfDepth: TLabel
          Left = 168
          Top = 375
          ExplicitLeft = 168
          ExplicitTop = 375
        end
        inherited memoComments: TMemo
          Width = 574
          Height = 224
          ExplicitWidth = 574
          ExplicitHeight = 224
        end
        inherited rdeTheta: TRbwDataEntry
          Top = 292
          Width = 146
          ExplicitTop = 292
          ExplicitWidth = 146
        end
        inherited rdeIterations: TRbwDataEntry
          Top = 320
          Width = 146
          ExplicitTop = 320
          ExplicitWidth = 146
        end
        inherited rdeConvergenceCriterion: TRbwDataEntry
          Top = 348
          Width = 146
          ExplicitTop = 348
          ExplicitWidth = 146
        end
        inherited cbPrintLake: TCheckBox
          Top = 400
          ExplicitTop = 400
        end
        inherited rdeSurfDepth: TRbwDataEntry
          Top = 372
          Width = 146
          ExplicitTop = 372
          ExplicitWidth = 146
        end
        inherited rgBathymetry: TRadioGroup
          Top = 423
          Width = 345
          Height = 75
          ExplicitTop = 423
          ExplicitWidth = 345
          ExplicitHeight = 75
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgLAK.lblComments
            end
            item
              Control = framePkgLAK.memoComments
            end
            item
              Control = framePkgLAK.cbPrintLake
            end
            item
              Control = framePkgLAK.rdeIterations
            end
            item
              Control = framePkgLAK.rdeConvergenceCriterion
            end
            item
              Control = framePkgLAK.rdeTheta
            end
            item
              Control = framePkgLAK.lblConvergenceCriterion
            end
            item
              Control = framePkgLAK.lblIterations
            end
            item
              Control = framePkgLAK.lblTheta
            end
            item
              Control = framePkgLAK.rdeSurfDepth
            end
            item
              Control = framePkgLAK.lblSurfDepth
            end
            item
              Control = framePkgLAK.rgBathymetry
            end>
        end
      end
    end
    object jvspSFR: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SFR_Stream_Flow_Routing_Package'
      Caption = 'jvspSFR'
      object pcSFR: TJvPageControl
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        ActivePage = tabSfrGeneral
        Align = alClient
        TabOrder = 0
        ClientBorderWidth = 0
        object tabSfrGeneral: TTabSheet
          Caption = 'General'
          inline framePkgSFR: TframePackageSFR
            Left = 0
            Top = 0
            Width = 595
            Height = 491
            Align = alClient
            TabOrder = 0
            TabStop = True
            ExplicitWidth = 595
            ExplicitHeight = 491
            inherited lblPrintStreams: TLabel
              Left = 231
              Top = 168
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 231
              ExplicitTop = 168
            end
            inherited lblStreamTolerance: TLabel
              Left = 112
              Top = 269
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 269
            end
            inherited lblSfrTrailingWaveIncrements: TLabel
              Left = 112
              Top = 293
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 293
            end
            inherited lblSfrMaxTrailingWaves: TLabel
              Left = 112
              Top = 316
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 316
            end
            inherited lblSfrMaxUnsatCells: TLabel
              Left = 112
              Top = 339
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 339
            end
            inherited lblNUMTIM: TLabel
              Left = 112
              Top = 385
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 385
            end
            inherited lblWeight: TLabel
              Left = 112
              Top = 407
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 407
            end
            inherited lblFLWTOL: TLabel
              Left = 112
              Top = 429
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 112
              ExplicitTop = 429
            end
            inherited memoComments: TMemo
              Left = 20
              Width = 582
              Height = 48
              Anchors = [akLeft, akTop, akRight, akBottom]
              ExplicitLeft = 20
              ExplicitWidth = 582
              ExplicitHeight = 48
            end
            inherited cbSfrUnsatflow: TCheckBox95
              Left = 6
              Top = 116
              Anchors = [akLeft, akBottom]
              OnClick = framePkgSFRcbSfrUnsatflowClick
              ExplicitLeft = 6
              ExplicitTop = 116
            end
            inherited cbSfrLpfHydraulicCond: TCheckBox95
              Left = 6
              Top = 136
              Width = 356
              Anchors = [akLeft, akBottom]
              OnClick = framePkgSFRcbSfrLpfHydraulicCondClick
              ExplicitLeft = 6
              ExplicitTop = 136
              ExplicitWidth = 356
            end
            inherited rgSfr2ISFROPT: TRadioGroup
              Left = 6
              Top = 197
              Anchors = [akLeft, akBottom]
              OnClick = framePkgSFRrgSfr2ISFROPTClick
              ExplicitLeft = 6
              ExplicitTop = 197
            end
            inherited comboPrintStreams: TComboBox
              Left = 6
              Top = 165
              Width = 219
              Anchors = [akLeft, akBottom]
              ItemIndex = 1
              Text = 'Print flows in listing file'
              ExplicitLeft = 6
              ExplicitTop = 165
              ExplicitWidth = 219
              ExplicitHeight = 24
            end
            inherited cbGage8: TCheckBox
              Left = 6
              Top = 450
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 450
            end
            inherited rdeDLEAK: TRbwDataEntry
              Left = 6
              Top = 269
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 269
            end
            inherited rdeNstrail: TRbwDataEntry
              Left = 6
              Top = 293
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 293
              ExplicitHeight = 18
            end
            inherited rdeNsfrsets: TRbwDataEntry
              Left = 6
              Top = 316
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 316
              ExplicitHeight = 18
            end
            inherited rdeIsuzn: TRbwDataEntry
              Left = 6
              Top = 339
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 339
              ExplicitHeight = 18
            end
            inherited cbIRTFLG: TCheckBox
              Left = 6
              Top = 359
              Width = 555
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 359
              ExplicitWidth = 555
            end
            inherited rdeNUMTIM: TRbwDataEntry
              Left = 6
              Top = 385
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 385
              ExplicitHeight = 18
            end
            inherited rdeWeight: TRbwDataEntry
              Left = 6
              Top = 407
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 407
              ExplicitHeight = 18
            end
            inherited rdeFLWTOL: TRbwDataEntry
              Left = 6
              Top = 429
              Height = 18
              Anchors = [akLeft, akBottom]
              ExplicitLeft = 6
              ExplicitTop = 429
              ExplicitHeight = 18
            end
            inherited cbUseGsflowFormat: TCheckBox
              Left = 408
              Top = 169
              ExplicitLeft = 408
              ExplicitTop = 169
            end
            inherited cbSeepageLoss: TCheckBox
              Width = 288
              OnClick = framePkgSFRcbSeepageLossClick
              ExplicitWidth = 288
            end
            inherited rcSelectionController: TRbwController
              ControlList = <
                item
                  Control = framePkgSFR.lblComments
                end
                item
                  Control = framePkgSFR.memoComments
                end
                item
                  Control = framePkgSFR.rdeDLEAK
                end
                item
                  Control = framePkgSFR.cbSfrUnsatflow
                end
                item
                  Control = framePkgSFR.comboPrintStreams
                end
                item
                  Control = framePkgSFR.rgSfr2ISFROPT
                end
                item
                  Control = framePkgSFR.cbIRTFLG
                end
                item
                  Control = framePkgSFR.cbGage8
                end
                item
                  Control = framePkgSFR.cbUseGsflowFormat
                end>
              OnEnabledChange = framePkgSFRrcSelectionControllerEnabledChange
            end
          end
        end
        object tabSfrParameters: TTabSheet
          Caption = 'Parameters'
          ImageIndex = 1
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object splitSFR: TSplitter
            Left = 0
            Top = 257
            Width = 595
            Height = 5
            Cursor = crVSplit
            Align = alTop
            ExplicitWidth = 603
          end
          inline frameSFRParameterDefinition: TframeListParameterDefinition
            Left = 0
            Top = 0
            Width = 595
            Height = 257
            Align = alTop
            Enabled = False
            TabOrder = 0
            TabStop = True
            ExplicitWidth = 595
            ExplicitHeight = 257
            inherited pnlParameterCount: TPanel
              Top = 209
              Width = 595
              ExplicitTop = 209
              ExplicitWidth = 595
              inherited lblNumParameters: TLabel
                Width = 157
                Caption = 'Number of SFR parameters'
                ExplicitWidth = 157
              end
              inherited btnDelete: TBitBtn
                Left = 481
                OnClick = frameSFRParameterDefinitionbtnDeleteClick
                ExplicitLeft = 481
              end
              inherited seNumberOfParameters: TJvSpinEdit
                Left = 6
                Height = 26
                OnChange = frameSFRParameterDefinitionseNumberOfParametersChange
                ExplicitLeft = 6
                ExplicitHeight = 26
              end
            end
            inherited dgParameters: TRbwDataGrid4
              Width = 589
              Height = 203
              OnSelectCell = frameSFRParameterDefinitiondgParametersSelectCell
              OnSetEditText = frameSFRParameterDefinitiondgParametersSetEditText
              ExplicitWidth = 589
              ExplicitHeight = 203
              ColWidths = (
                64
                64)
            end
          end
          object jplSfrParameters: TJvPageList
            Left = 0
            Top = 262
            Width = 595
            Height = 227
            PropagateEnable = False
            Align = alClient
          end
        end
      end
    end
    object jvspUZF: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'UZF_Unsaturated_Zone_Flow_Package'
      Caption = 'jvspUZF'
      inline framePkgUZF: TframePackageUZF
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        DesignSize = (
          595
          514)
        inherited lblComments: TLabel
          Top = 39
          ExplicitTop = 39
        end
        inherited memoComments: TMemo
          Width = 574
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 574
        end
        inherited pnLayerOption: TPanel
          Top = 137
          Width = 595
          Height = 377
          ExplicitTop = 137
          ExplicitWidth = 595
          ExplicitHeight = 377
          inherited lblLayerOption: TLabel
            Width = 290
            Caption = 'Recharge and discharge location option (NUZTOP) '
            ExplicitWidth = 290
          end
          inherited lblVerticalKSource: TLabel
            Top = 56
            Width = 278
            Caption = 'Vertical hydraulic conductivity source (IUZFOPT) '
            ExplicitTop = 56
            ExplicitWidth = 278
          end
          inherited lblNumberOfTrailingWaves: TLabel
            Top = 111
            Width = 210
            Caption = 'Number of trailing waves (NTRAIL2) '
            ExplicitTop = 111
            ExplicitWidth = 210
          end
          inherited lblNumberOfWaveSets: TLabel
            Top = 160
            Width = 185
            Caption = 'Number of wave sets (NSETS2) '
            ExplicitTop = 160
            ExplicitWidth = 185
          end
          inherited lblSURFDEP: TLabel
            Width = 209
            Caption = 
              'The average height of undulations in the land surface altitude (' +
              'SURFDEP)'
            ExplicitWidth = 209
          end
          inherited comboLayerOption: TComboBox
            Top = 26
            ExplicitTop = 26
          end
          inherited comboVerticalKSource: TComboBox
            Top = 79
            Width = 449
            ExplicitTop = 79
            ExplicitWidth = 449
          end
          inherited rdeNumberOfTrailingWaves: TRbwDataEntry
            Top = 132
            ExplicitTop = 132
          end
          inherited rdeNumberOfWaveSets: TRbwDataEntry
            Top = 181
            ExplicitTop = 181
          end
          inherited chklstOptions: TCheckListBox
            Top = 209
            Width = 584
            ExplicitTop = 209
            ExplicitWidth = 584
          end
          inherited rgAssignmentMethod: TRadioGroup
            Left = 288
            Top = 111
            Width = 305
            Height = 92
            ExplicitLeft = 288
            ExplicitTop = 111
            ExplicitWidth = 305
            ExplicitHeight = 92
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgUZF.lblComments
            end
            item
              Control = framePkgUZF.memoComments
            end
            item
              Control = framePkgUZF.chklstOptions
            end
            item
              Control = framePkgUZF.comboLayerOption
            end
            item
              Control = framePkgUZF.lblLayerOption
            end
            item
              Control = framePkgUZF.rdeSURFDEP
            end
            item
              Control = framePkgUZF.lblSURFDEP
            end
            item
              Control = framePkgUZF.rdeNumberOfTrailingWaves
            end
            item
              Control = framePkgUZF.lblNumberOfTrailingWaves
            end
            item
              Control = framePkgUZF.rdeNumberOfWaveSets
            end
            item
              Control = framePkgUZF.lblNumberOfWaveSets
            end
            item
              Control = framePkgUZF.comboVerticalKSource
            end
            item
              Control = framePkgUZF.lblVerticalKSource
            end
            item
              Control = framePkgUZF.rgAssignmentMethod
            end>
          OnEnabledChange = framePkgUZFrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspGMG: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'GMG_Geometric_Multigrid_Package'
      Caption = 'jvspGMG'
      inline framePkgGMG: TframeGMG
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited memoComments: TMemo
          Width = 574
          Height = 143
          ExplicitWidth = 574
          ExplicitHeight = 143
        end
        inherited pcGMG: TJvPageControl
          Top = 214
          Width = 595
          Height = 300
          ActivePage = framePkgGMG.tabDampRelax
          ExplicitTop = 214
          ExplicitWidth = 595
          ExplicitHeight = 300
          inherited tabControlAndPrint: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 617
            ExplicitHeight = 227
            inherited lblGmgRclose: TLabel
              Top = 12
              ExplicitTop = 12
            end
            inherited lblGmgIiter: TLabel
              Top = 44
              ExplicitTop = 44
            end
            inherited lblGmgHclose: TLabel
              Top = 76
              ExplicitTop = 76
            end
            inherited lblGmgMxiter: TLabel
              Top = 108
              ExplicitTop = 108
            end
            inherited lblGmgIoutgmg: TLabel
              Top = 171
              ExplicitTop = 171
            end
            inherited lblGmgIsm: TLabel
              Top = 142
              ExplicitTop = 142
            end
            inherited rdeGmgRclose: TRbwDataEntry
              Left = 366
              Top = 7
              ExplicitLeft = 366
              ExplicitTop = 7
            end
            inherited rdeGmgIiter: TRbwDataEntry
              Left = 366
              Top = 39
              ExplicitLeft = 366
              ExplicitTop = 39
            end
            inherited rdeGmgHclose: TRbwDataEntry
              Left = 366
              Top = 71
              ExplicitLeft = 366
              ExplicitTop = 71
            end
            inherited rdeGmgMxiter: TRbwDataEntry
              Left = 366
              Top = 103
              ExplicitLeft = 366
              ExplicitTop = 103
            end
            inherited comboGmgIoutgmg: TJvImageComboBox
              Left = 304
              Top = 168
              Width = 239
              ItemHeight = 22
              ExplicitLeft = 304
              ExplicitTop = 168
              ExplicitWidth = 239
            end
            inherited cbGmbIunitmhc: TCheckBox
              Top = 205
              ExplicitTop = 205
            end
            inherited comboGmgIsm: TJvImageComboBox
              Left = 304
              Top = 139
              Width = 239
              ItemHeight = 22
              ExplicitLeft = 304
              ExplicitTop = 139
              ExplicitWidth = 239
            end
          end
          inherited tabDampRelax: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 269
            inherited lblGmgDup: TLabel
              Top = 76
              ExplicitTop = 76
            end
            inherited lblGmgDlow: TLabel
              Top = 108
              ExplicitTop = 108
            end
            inherited lblGmgChglimit: TLabel
              Top = 139
              ExplicitTop = 139
            end
            inherited lblGmgRelax: TLabel
              Top = 203
              ExplicitTop = 203
            end
            inherited lblGmgIadamp: TLabel
              Top = 44
              ExplicitTop = 44
            end
            inherited lblGmgIsc: TLabel
              Top = 171
              ExplicitTop = 171
            end
            inherited lblGmgDamp: TLabel
              Top = 12
              ExplicitTop = 12
            end
            inherited rdeGmgDup: TRbwDataEntry
              Top = 73
              ExplicitTop = 73
            end
            inherited rdeGmgRelax: TRbwDataEntry
              Top = 200
              ExplicitTop = 200
            end
            inherited rdeGmgChglimit: TRbwDataEntry
              Top = 136
              ExplicitTop = 136
            end
            inherited rdeGmgDlow: TRbwDataEntry
              Top = 105
              ExplicitTop = 105
            end
            inherited comboGmgIadamp: TJvImageComboBox
              Left = 304
              Top = 41
              Width = 209
              ItemHeight = 22
              ExplicitLeft = 304
              ExplicitTop = 41
              ExplicitWidth = 209
            end
            inherited comboGmgIsc: TJvImageComboBox
              Left = 304
              Width = 209
              ItemHeight = 22
              ExplicitLeft = 304
              ExplicitWidth = 209
            end
            inherited rdeGmgDamp: TRbwDataEntry
              Top = 9
              ExplicitTop = 9
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgGMG.lblComments
            end
            item
              Control = framePkgGMG.memoComments
            end
            item
              Control = framePkgGMG.rdeGmgDamp
            end
            item
              Control = framePkgGMG.rdeGmgMxiter
            end
            item
              Control = framePkgGMG.rdeGmgHclose
            end
            item
              Control = framePkgGMG.rdeGmgIiter
            end
            item
              Control = framePkgGMG.rdeGmgRclose
            end
            item
              Control = framePkgGMG.comboGmgIsc
            end
            item
              Control = framePkgGMG.comboGmgIsm
            end
            item
              Control = framePkgGMG.cbGmbIunitmhc
            end
            item
              Control = framePkgGMG.comboGmgIoutgmg
            end
            item
              Control = framePkgGMG.comboGmgIadamp
            end>
        end
      end
    end
    object jvspSIP: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SIP_Strongly_Implicit_Procedure_Package'
      Caption = 'jvspSIP'
      inline framePkgSIP: TframeSIP
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited lblSipMxiter: TLabel
          Top = 181
          ExplicitTop = 181
        end
        inherited lblSipNparm: TLabel
          Top = 213
          ExplicitTop = 213
        end
        inherited lblSipAccl: TLabel
          Top = 245
          ExplicitTop = 245
        end
        inherited lblSipHclose: TLabel
          Top = 277
          ExplicitTop = 277
        end
        inherited lblSipIpcalc: TLabel
          Top = 309
          ExplicitTop = 309
        end
        inherited lblSipWseed: TLabel
          Top = 341
          WordWrap = True
          ExplicitTop = 341
        end
        inherited lblSipIprsip: TLabel
          Top = 389
          ExplicitTop = 389
        end
        inherited memoComments: TMemo
          Width = 574
          Height = 110
          ExplicitWidth = 574
          ExplicitHeight = 110
        end
        inherited rdeSipMxiter: TRbwDataEntry
          Left = 417
          Top = 178
          ExplicitLeft = 417
          ExplicitTop = 178
        end
        inherited rdeSipNparm: TRbwDataEntry
          Left = 417
          Top = 206
          ExplicitLeft = 417
          ExplicitTop = 206
        end
        inherited rdeSipAccl: TRbwDataEntry
          Left = 417
          Top = 242
          ExplicitLeft = 417
          ExplicitTop = 242
        end
        inherited rdeSipHclose: TRbwDataEntry
          Left = 417
          Top = 270
          ExplicitLeft = 417
          ExplicitTop = 270
        end
        inherited comboSipIpcalc: TJvImageComboBox
          Left = 326
          Top = 298
          ItemHeight = 22
          ExplicitLeft = 326
          ExplicitTop = 298
        end
        inherited rdeSipWseed: TRbwDataEntry
          Left = 417
          Top = 334
          ExplicitLeft = 417
          ExplicitTop = 334
        end
        inherited rdeSipIprsip: TRbwDataEntry
          Left = 417
          Top = 382
          ExplicitLeft = 417
          ExplicitTop = 382
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSIP.lblComments
            end
            item
              Control = framePkgSIP.memoComments
            end
            item
              Control = framePkgSIP.rdeSipMxiter
            end
            item
              Control = framePkgSIP.rdeSipNparm
            end
            item
              Control = framePkgSIP.rdeSipAccl
            end
            item
              Control = framePkgSIP.rdeSipHclose
            end
            item
              Control = framePkgSIP.comboSipIpcalc
            end
            item
              Control = framePkgSIP.rdeSipIprsip
            end>
        end
      end
    end
    object jvspDE4: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'DE4_Direct_Solver_Package_Pane'
      Caption = 'jvspDE4'
      inline framePkgDE4: TframeDE4
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblDe4Itmx: TLabel
          Top = 189
          ExplicitTop = 189
        end
        inherited lblDe4Mxup: TLabel
          Top = 221
          ExplicitTop = 221
        end
        inherited lblDe4Mxlow: TLabel
          Top = 249
          ExplicitTop = 249
        end
        inherited lblDe4Mxbw: TLabel
          Top = 281
          ExplicitTop = 281
        end
        inherited lblDe4Ifreq: TLabel
          Top = 309
          WordWrap = True
          ExplicitTop = 309
        end
        inherited lblDe4Mutd4: TLabel
          Top = 357
          ExplicitTop = 357
        end
        inherited lblDe4Accl: TLabel
          Top = 385
          ExplicitTop = 385
        end
        inherited lblDe4Hclose: TLabel
          Top = 417
          ExplicitTop = 417
        end
        inherited lblRdeIprd4: TLabel
          Top = 445
          ExplicitTop = 445
        end
        inherited memoComments: TMemo
          Width = 574
          Height = 110
          ExplicitWidth = 574
          ExplicitHeight = 110
        end
        inherited rdeDe4Itmx: TRbwDataEntry
          Left = 439
          Top = 186
          ExplicitLeft = 439
          ExplicitTop = 186
        end
        inherited rdeDe4Mxup: TRbwDataEntry
          Left = 439
          Top = 218
          ExplicitLeft = 439
          ExplicitTop = 218
        end
        inherited rdeDe4Mxlow: TRbwDataEntry
          Left = 439
          Top = 246
          ExplicitLeft = 439
          ExplicitTop = 246
        end
        inherited rdeDe4Mxbw: TRbwDataEntry
          Left = 439
          Top = 278
          ExplicitLeft = 439
          ExplicitTop = 278
        end
        inherited comboDe4Ifreq: TJvImageComboBox
          Left = 344
          Top = 305
          Width = 239
          DroppedWidth = 263
          Items = <
            item
              Brush.Style = bsClear
              Indent = 0
              Text = 'Coefficients constant (1)'
            end
            item
              Brush.Style = bsClear
              Indent = 0
              Text = 'Coefficients vary (2)'
            end
            item
              Brush.Style = bsClear
              Indent = 0
              Text = 'Nonlinear flow equations (3)'
            end>
          ExplicitLeft = 344
          ExplicitTop = 305
          ExplicitWidth = 239
        end
        inherited comboDe4Mutd4: TJvImageComboBox
          Left = 344
          Top = 354
          Width = 241
          DroppedWidth = 272
          ItemHeight = 22
          ExplicitLeft = 344
          ExplicitTop = 354
          ExplicitWidth = 241
        end
        inherited rdeDe4Accl: TRbwDataEntry
          Left = 439
          Top = 382
          ExplicitLeft = 439
          ExplicitTop = 382
        end
        inherited rdeDe4Hclose: TRbwDataEntry
          Left = 439
          Top = 414
          ExplicitLeft = 439
          ExplicitTop = 414
        end
        inherited rdeRdeIprd4: TRbwDataEntry
          Left = 439
          Top = 442
          ExplicitLeft = 439
          ExplicitTop = 442
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgDE4.lblComments
            end
            item
              Control = framePkgDE4.memoComments
            end
            item
              Control = framePkgDE4.rdeDe4Itmx
            end
            item
              Control = framePkgDE4.rdeDe4Mxup
            end
            item
              Control = framePkgDE4.rdeDe4Mxlow
            end
            item
              Control = framePkgDE4.rdeDe4Mxbw
            end
            item
              Control = framePkgDE4.comboDe4Ifreq
            end
            item
              Control = framePkgDE4.comboDe4Mutd4
            end
            item
              Control = framePkgDE4.rdeDe4Accl
            end
            item
              Control = framePkgDE4.rdeDe4Hclose
            end
            item
              Control = framePkgDE4.rdeRdeIprd4
            end>
        end
      end
    end
    object jvspHOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'HOB_Head_Observation_Package'
      Caption = 'jvspHOB'
      inline framePkgHOB: TframePackageHob
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblDryHead: TLabel
          Top = 464
          ExplicitTop = 464
        end
        inherited memoComments: TMemo
          Width = 574
          Height = 389
          ExplicitWidth = 574
          ExplicitHeight = 389
        end
        inherited rdeDryHead: TRbwDataEntry
          Top = 483
          ExplicitTop = 483
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgHOB.lblComments
            end
            item
              Control = framePkgHOB.memoComments
            end
            item
              Control = framePkgHOB.rdeDryHead
            end>
        end
      end
    end
    object jvspHFB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'HFB_Horizontal_Flow_Barrier_Package'
      Caption = 'jvspHFB'
      inline framePkgHFB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 161
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgHFB.lblComments
            end
            item
              Control = framePkgHFB.memoComments
            end
            item
              Control = frameHfbParameterDefinition
            end>
        end
      end
      inline frameHfbParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 161
        Width = 595
        Height = 353
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 161
        ExplicitWidth = 595
        ExplicitHeight = 353
        inherited pnlParameterCount: TPanel
          Top = 305
          Width = 595
          ExplicitTop = 305
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 481
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 481
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            Enabled = True
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 299
          ExplicitWidth = 589
          ExplicitHeight = 299
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspModpath: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'MODPATH'
      Caption = 'jvspModpath'
      inline frameModpath: TframeModpathSelection
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 576
          ExplicitWidth = 576
        end
        inherited pcModpath: TPageControl
          Width = 590
          Height = 375
          ExplicitWidth = 590
          ExplicitHeight = 375
          inherited tabResponse: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 592
            ExplicitHeight = 333
            inherited lblTrackingDirection: TLabel
              Left = 359
              Top = 257
              Width = 109
              Height = 32
              WordWrap = True
              ExplicitLeft = 359
              ExplicitTop = 257
              ExplicitWidth = 109
              ExplicitHeight = 32
            end
            inherited lblWeakSinkThreshold: TLabel
              Top = 309
              ExplicitTop = 309
            end
            inherited lblStopZone: TLabel
              Top = 225
              ExplicitTop = 225
            end
            inherited lblWhichEndpoints: TLabel
              Top = 166
              ExplicitTop = 166
            end
            inherited lblReferenceTime: TLabel
              Left = 359
              Top = 115
              Width = 173
              Height = 32
              ExplicitLeft = 359
              ExplicitTop = 115
              ExplicitWidth = 173
              ExplicitHeight = 32
            end
            inherited comboTrackingDirection: TJvImageComboBox
              Left = 359
              Top = 296
              ItemHeight = 22
              ItemIndex = -1
              ExplicitLeft = 359
              ExplicitTop = 296
            end
            inherited comboWeakSinkTreatment: TJvImageComboBox
              ItemHeight = 22
            end
            inherited cbStopInZone: TCheckBox
              Width = 288
              ExplicitWidth = 288
            end
            inherited rdeStopZone: TRbwDataEntry
              Top = 224
              TabOrder = 7
              ExplicitTop = 224
            end
            inherited comboWhichEndpoints: TJvImageComboBox
              Top = 190
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 190
            end
            inherited rdeReferenceTime: TRbwDataEntry
              Left = 359
              Top = 157
              TabOrder = 5
              ExplicitLeft = 359
              ExplicitTop = 157
            end
            inherited comboEvtSink: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboRchSource: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
          end
          inherited tabVersion5Options: TTabSheet
            inherited lblMaxSize: TLabel
              Width = 322
              Height = 32
              ExplicitWidth = 322
              ExplicitHeight = 32
            end
          end
          inherited tsVersion6Options: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 592
            ExplicitHeight = 333
            inherited lblStopOption: TLabel
              Width = 208
              Caption = 'End of particle tracking (StopOption)'
              ExplicitWidth = 208
            end
            inherited lblStopTime: TLabel
              Top = 123
              ExplicitTop = 123
            end
            inherited lblAdvObs: TLabel
              Left = 3
              ExplicitLeft = 3
            end
            inherited comboWeakSource: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboStopOption: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboBudget: TJvImageComboBox
              ItemHeight = 22
            end
            inherited chkRetardation: TCheckBox
              Width = 302
              ExplicitWidth = 302
            end
            inherited comboAdvObs: TJvImageComboBox
              Top = 292
              ItemHeight = 22
              TabOrder = 11
              ExplicitTop = 292
            end
            inherited comboUzfIface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboMnw2Iface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboResIface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboSfrIface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboEtsIface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboLakIface: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
              TabOrder = 12
            end
          end
          inherited tabOutputTimes: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 582
            ExplicitHeight = 344
            inherited lblMaxTimes: TLabel
              Width = 205
              Height = 32
              ExplicitWidth = 205
              ExplicitHeight = 32
            end
            inherited gbTime: TJvGroupBox
              inherited rdgTimes: TRbwDataGrid4
                FixedCols = 0
                ColWidths = (
                  20
                  20)
              end
              inherited seTimeCount: TJvSpinEdit
                Height = 26
                ExplicitHeight = 26
              end
            end
            inherited comboTimeMethod: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited rdeParticleInterval: TRbwDataEntry
              Top = 94
              ExplicitTop = 94
            end
            inherited rdeMaxTimes: TRbwDataEntry
              Top = 167
              ExplicitTop = 167
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = frameModpath.lblComments
            end
            item
              Control = frameModpath.memoComments
            end
            item
              Control = frameModpath.cbBinary
            end
            item
              Control = frameModpath.cbCompact
            end
            item
              Control = frameModpath.rdeBeginningTime
            end
            item
              Control = frameModpath.rgOutputMode
            end
            item
              Control = frameModpath.comboTrackingDirection
            end
            item
              Control = frameModpath.comboWeakSinkTreatment
            end
            item
              Control = frameModpath.cbStopInZone
            end
            item
              Control = frameModpath.cbStopAfterMaxTime
            end
            item
              Control = frameModpath.cbBigBudget
            end
            item
              Control = frameModpath.cbSummarize
            end
            item
              Control = frameModpath.cbComputeBudget
            end
            item
              Control = frameModpath.rgModpathVersion
            end
            item
              Control = frameModpath.comboWeakSource
            end
            item
              Control = frameModpath.comboStopOption
            end
            item
              Control = frameModpath.comboBudget
            end
            item
              Control = frameModpath.chkRetardation
            end
            item
              Control = frameModpath.comboAdvObs
            end
            item
              Control = frameModpath.comboEtsIface
            end
            item
              Control = frameModpath.comboUzfIface
            end
            item
              Control = frameModpath.comboMnw2Iface
            end
            item
              Control = frameModpath.comboResIface
            end
            item
              Control = frameModpath.comboSfrIface
            end
            item
              Control = frameModpath.comboLakIface
            end>
          OnEnabledChange = frameModpathrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspCHOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'CHOB_Specified_Head_Flow_Observations'
      Caption = 'jvspCHOB'
      inline framePkgCHOB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgCHOB.lblComments
            end
            item
              Control = framePkgCHOB.memoComments
            end>
        end
      end
    end
    object jvspDROB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'DROB_Drain_Observation_Package'
      Caption = 'jvspDROB'
      inline framePkgDROB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgDROB.lblComments
            end
            item
              Control = framePkgDROB.memoComments
            end>
        end
      end
    end
    object jvspGBOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'GBOB_General_Head_Boundary_Observations'
      Caption = 'jvspGBOB'
      inline framePkgGBOB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgGBOB.lblComments
            end
            item
              Control = framePkgGBOB.memoComments
            end>
        end
      end
    end
    object jvspRVOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RVOB_River_Observation_Package'
      Caption = 'jvspRVOB'
      inline framePkgRVOB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgRVOB.lblComments
            end
            item
              Control = framePkgRVOB.memoComments
            end>
        end
      end
    end
    object jvspMNW2: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'MNW2_Multi_Node_Well_Package'
      Caption = 'jvspMNW2'
      inline framePkgMnw2: TframePackageMnw2
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblPrintOption: TLabel
          Top = 356
          ExplicitTop = 356
        end
        inherited memoComments: TMemo
          Width = 564
          Height = 288
          ExplicitWidth = 564
          ExplicitHeight = 288
        end
        inherited comboPrintOption: TJvImageComboBox
          Top = 379
          ItemHeight = 22
          ItemIndex = -1
          ExplicitTop = 379
        end
        inherited gbMnwiOptions: TGroupBox
          Top = 413
          Width = 564
          ExplicitTop = 413
          ExplicitWidth = 564
          inherited cbWellOutput: TCheckBox
            Width = 558
            ExplicitWidth = 558
          end
          inherited cbSummarizeByWell: TCheckBox
            Width = 558
            ExplicitWidth = 558
          end
          inherited cbSummarizeByNode: TCheckBox
            Width = 550
            ExplicitWidth = 550
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgMnw2.lblComments
            end
            item
              Control = framePkgMnw2.memoComments
            end
            item
              Control = framePkgMnw2.lblPrintOption
            end
            item
              Control = framePkgMnw2.comboPrintOption
            end>
        end
      end
    end
    object jvspBCF: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'BCF_Block-Centered_Flow_Package'
      Caption = 'jvspBCF'
      inline framePkgBCF: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 435
          ExplicitWidth = 564
          ExplicitHeight = 435
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgBCF.lblComments
            end
            item
              Control = framePkgBCF.memoComments
            end>
          OnEnabledChange = framePkgBCFrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspSUB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SUB_Subsidence_and_Aquifer_Sys'
      Caption = 'jvspSUB'
      inline framePkgSUB: TframePackageSub
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited pcSub: TPageControl
          Width = 595
          Height = 395
          ActivePage = framePkgSUB.tabControls
          ExplicitWidth = 595
          ExplicitHeight = 395
          inherited tabControls: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 364
            inherited seNumberOfNodes: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited feReadRestart: TJvFilenameEdit
              Left = 14
              Top = 163
              Width = 1475
              Height = 26
              ExplicitLeft = 14
              ExplicitTop = 163
              ExplicitWidth = 1173
              ExplicitHeight = 26
            end
            inherited comboOutputChoice: TJvImageComboBox
              Top = 213
              ItemHeight = 22
              ExplicitTop = 213
            end
          end
          inherited tabPrintSave: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 436
            ExplicitHeight = 252
            inherited lblNumExportPeriods: TLabel
              Left = 67
              Top = 340
              ExplicitLeft = 67
              ExplicitTop = 340
            end
            inherited sbAdd: TSpeedButton
              Left = 512
              Top = 336
              ExplicitLeft = 512
              ExplicitTop = 322
            end
            inherited sbInsert: TSpeedButton
              Left = 541
              Top = 336
              ExplicitLeft = 541
              ExplicitTop = 322
            end
            inherited sbDelete: TSpeedButton
              Left = 570
              Top = 336
              ExplicitLeft = 570
              ExplicitTop = 322
            end
            inherited cbMultiPrintSave: TCheckBox
              Width = 209
              ExplicitWidth = 209
            end
            inherited rdgOutput: TRbwDataGrid4
              Top = 40
              Width = 581
              Height = 290
              ExplicitTop = 40
              ExplicitWidth = 581
              ExplicitHeight = 290
              ColWidths = (
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64)
            end
            inherited seNumExportPeriods: TJvSpinEdit
              Left = 4
              Top = 336
              Height = 26
              ExplicitLeft = 4
              ExplicitTop = 336
              ExplicitHeight = 26
            end
            inherited comboMultiFomat: TJvImageComboBox
              ItemHeight = 22
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSUB.lblComments
            end
            item
              Control = framePkgSUB.memoComments
            end
            item
              Control = framePkgSUB.seNumberOfNodes
            end
            item
              Control = framePkgSUB.rdeAccel1
            end
            item
              Control = framePkgSUB.rdeAccel2
            end
            item
              Control = framePkgSUB.rdeMinIterations
            end
            item
              Control = framePkgSUB.cbSaveRestart
            end
            item
              Control = framePkgSUB.feReadRestart
            end
            item
              Control = framePkgSUB.rdgOutput
            end
            item
              Control = framePkgSUB.seNumExportPeriods
            end
            item
              Control = framePkgSUB.sbAdd
            end
            item
              Control = framePkgSUB.sbInsert
            end
            item
              Control = framePkgSUB.comboOutputChoice
            end
            item
              Control = framePkgSUB.lblOutputChoice
            end>
        end
      end
    end
    object jvspZoneBudget: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'ZONEBUDGET'
      Caption = 'jvspZoneBudget'
      inline frameZoneBudget: TframeZoneBudget
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        HelpType = htKeyword
        HelpKeyword = 'ZONEBUDGET'
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblNumberOfZones: TLabel
          Top = 479
          Width = 159
          Caption = 'Number of composite zones'
          ExplicitTop = 479
          ExplicitWidth = 159
        end
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rdgCompositeZones: TRbwDataGrid4
          Width = 564
          Height = 262
          ExplicitWidth = 564
          ExplicitHeight = 262
          ColWidths = (
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20)
          RowHeights = (
            24
            24)
        end
        inherited seNumberOfZones: TJvSpinEdit
          Top = 476
          Height = 26
          ExplicitTop = 476
          ExplicitHeight = 26
        end
        inherited btnInsertZone: TButton
          Left = 423
          Top = 477
          ExplicitLeft = 423
          ExplicitTop = 477
        end
        inherited btnDeleteZone: TButton
          Left = 504
          Top = 477
          ExplicitLeft = 504
          ExplicitTop = 477
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = frameZoneBudget.lblComments
            end
            item
              Control = frameZoneBudget.memoComments
            end
            item
              Control = frameZoneBudget.btnInsertZone
            end
            item
              Control = frameZoneBudget.btnInsertZone
            end
            item
              Control = frameZoneBudget.cbExportCsv
            end
            item
              Control = frameZoneBudget.cbExportCsv2
            end
            item
              Control = frameZoneBudget.cbExportZblst
            end
            item
              Control = frameZoneBudget.seNumberOfZones
            end>
        end
      end
    end
    object jvspSWT: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SWT_Package'
      Caption = 'jvspSWT'
      inline framePkgSwt: TframePackageSwt
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblComments: TLabel
          Top = 55
          ExplicitTop = 55
        end
        inherited lblPackage: TLabel
          WordWrap = True
        end
        inherited memoComments: TMemo
          Top = 78
          Width = 564
          Height = 52
          ExplicitTop = 78
          ExplicitWidth = 564
          ExplicitHeight = 52
        end
        inherited pcSWT: TPageControl
          Top = 136
          Width = 595
          Height = 378
          ActivePage = framePkgSwt.tabControls
          ExplicitTop = 136
          ExplicitWidth = 595
          ExplicitHeight = 378
          inherited tabControls: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 347
            inherited lblIvoid: TLabel
              Top = 92
              ExplicitTop = 92
            end
            inherited lblIstpcs: TLabel
              Top = 151
              ExplicitTop = 151
            end
            inherited lblIcrcc: TLabel
              Top = 210
              ExplicitTop = 210
            end
            inherited lblOutputChoice: TLabel
              Top = 273
              ExplicitTop = 273
            end
            inherited gbIthk: TGroupBox
              Top = 0
              Width = 751
              Height = 86
              ExplicitTop = 0
              ExplicitWidth = 715
              ExplicitHeight = 86
              inherited rgIthkConstant: TRadioButton
                Width = 673
                ExplicitWidth = 673
              end
              inherited rbIthkVariable: TRadioButton
                Top = 39
                Width = 664
                ExplicitTop = 39
                ExplicitWidth = 664
              end
            end
            inherited comboOutputChoice: TJvImageComboBox
              Top = 297
              ItemHeight = 22
              ExplicitTop = 297
            end
            inherited comboIvoid: TJvImageComboBox
              Top = 114
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 114
            end
            inherited comboIstpcs: TJvImageComboBox
              Top = 173
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 173
            end
            inherited comboIcrcc: TJvImageComboBox
              Top = 236
              Width = 557
              DroppedWidth = 557
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 236
              ExplicitWidth = 557
            end
          end
          inherited tabPrintSave: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 347
            inherited sbAdd: TSpeedButton
              Left = 721
              Top = 433
              ExplicitLeft = 505
              ExplicitTop = 335
            end
            inherited sbInsert: TSpeedButton
              Left = 750
              Top = 433
              ExplicitLeft = 534
              ExplicitTop = 335
            end
            inherited sbDelete: TSpeedButton
              Left = 779
              Top = 433
              ExplicitLeft = 563
              ExplicitTop = 335
            end
            inherited lblNumExportPeriods: TLabel
              Top = 433
              ExplicitTop = 405
            end
            inherited rdgInitialPrintChoices: TRbwDataGrid4
              Width = 754
              FixedCols = 0
              ExplicitWidth = 718
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24
                24
                24
                24
                24)
            end
            inherited rdgOutput: TRbwDataGrid4
              Top = 204
              Width = 754
              Height = 201
              Columns = <
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = True
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = True
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  PickList.Strings = (
                    '11G10.3'
                    '9G13.6'
                    '15F7.1'
                    '15F7.2'
                    '15F7.3'
                    '15F7.4'
                    '20F5.0'
                    '20F5.1'
                    '20F5.2'
                    '20F5.3'
                    '20F5.4'
                    '10G11.4')
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = True
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end>
              ExplicitTop = 204
              ExplicitWidth = 718
              ExplicitHeight = 187
              ColWidths = (
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64
                64)
              RowHeights = (
                24
                24
                24)
            end
            inherited seNumExportPeriods: TJvSpinEdit
              Top = 415
              Height = 26
              ExplicitTop = 401
              ExplicitHeight = 26
            end
            inherited comboMultiFomat: TJvImageComboBox
              ItemHeight = 22
            end
            inherited cbMultiPrintSave: TCheckBox
              Width = 232
              ExplicitWidth = 232
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSwt.lblComments
            end
            item
              Control = framePkgSwt.memoComments
            end
            item
              Control = framePkgSwt.rgIthkConstant
            end
            item
              Control = framePkgSwt.rbIthkVariable
            end
            item
              Control = framePkgSwt.comboIvoid
            end
            item
              Control = framePkgSwt.comboIstpcs
            end
            item
              Control = framePkgSwt.comboIcrcc
            end
            item
              Control = framePkgSwt.comboOutputChoice
            end
            item
              Control = framePkgSwt.rdgInitialPrintChoices
            end
            item
              Control = framePkgSwt.rdgOutput
            end
            item
              Control = framePkgSwt.seNumExportPeriods
            end
            item
              Control = framePkgSwt.sbAdd
            end
            item
              Control = framePkgSwt.sbInsert
            end>
        end
      end
    end
    object jvspHydmod: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'HYD_HYDMOD_Package'
      Caption = 'jvspHydmod'
      inline framePkgHydmod: TframePkgHydmod
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblHYDNOH: TLabel
          Top = 462
          ExplicitTop = 462
        end
        inherited memoComments: TMemo
          Width = 564
          Height = 394
          ExplicitWidth = 564
          ExplicitHeight = 394
        end
        inherited rdeHYDNOH: TRbwDataEntry
          Top = 481
          ExplicitTop = 481
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgHydmod.lblComments
            end
            item
              Control = framePkgHydmod.memoComments
            end
            item
              Control = framePkgHydmod.lblHYDNOH
            end
            item
              Control = framePkgHydmod.rdeHYDNOH
            end>
        end
      end
    end
    object jvspUPW: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'UPW_Upstream_Weighting_Package_Pane'
      Caption = 'jvspUPW'
      object JvNetscapeSplitter6: TJvNetscapeSplitter
        Left = 0
        Top = 233
        Width = 595
        Height = 10
        Cursor = crVSplit
        Align = alTop
        Maximized = False
        Minimized = False
        ButtonCursor = crDefault
        ExplicitTop = 192
        ExplicitWidth = 311
      end
      inline framePkgUPW: TframePackageUpw
        Left = 0
        Top = 0
        Width = 595
        Height = 233
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 233
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited cbPrintHDRY: TCheckBox
          Top = 157
          Width = 449
          ExplicitTop = 157
          ExplicitWidth = 449
        end
        inherited cbNoParCheck: TCheckBox
          Width = 145
          Height = 40
          ExplicitWidth = 145
          ExplicitHeight = 40
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgUPW.lblComments
            end
            item
              Control = framePkgUPW.memoComments
            end
            item
              Control = framePkgUPW.cbPrintHDRY
            end
            item
              Control = framePkgUPW.cbNoParCheck
            end>
          OnEnabledChange = framePkgUPWrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspNWT: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'NWT_Newton_Solver_Package_Pane'
      Caption = 'jvspNWT'
      inline framePkgNwt: TframePackageNwt
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited pcNWT: TPageControl
          Width = 595
          Height = 357
          OnChange = framePkgNwtpcNWTChange
          ExplicitWidth = 595
          ExplicitHeight = 357
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 326
            inherited lblSolverMethod: TLabel
              Left = 126
              ExplicitLeft = 126
            end
            inherited lblThicknessFactor: TLabel
              Left = 126
              Width = 319
              Height = 32
              WordWrap = True
              ExplicitLeft = 126
              ExplicitWidth = 319
              ExplicitHeight = 32
            end
            inherited lblMaxOuterIt: TLabel
              Left = 126
              ExplicitLeft = 126
            end
            inherited lblFluxTolerance: TLabel
              Left = 126
              ExplicitLeft = 126
            end
            inherited lblHeadTolerance: TLabel
              Left = 126
              ExplicitLeft = 126
            end
            inherited lblOptions: TLabel
              Left = 126
              ExplicitLeft = 126
            end
            inherited rdeHeadTolerance: TRbwDataEntry
              Width = 117
              ExplicitWidth = 117
            end
            inherited rdeFluxTolerance: TRbwDataEntry
              Width = 117
              ExplicitWidth = 117
            end
            inherited spinMaxOuterIt: TJvSpinEdit
              Width = 117
              Height = 26
              ExplicitWidth = 117
              ExplicitHeight = 26
            end
            inherited rdeThicknessFactor: TRbwDataEntry
              Width = 117
              ExplicitWidth = 117
            end
            inherited comboSolverMethod: TJvImageComboBox
              Width = 118
              ItemHeight = 22
              ItemIndex = -1
              ExplicitWidth = 118
            end
            inherited cbPrintFlag: TCheckBox
              Width = 390
              ExplicitWidth = 390
            end
            inherited cbCorrectForCellBottom: TCheckBox
              Width = 566
              ExplicitWidth = 566
            end
            inherited comboOptions: TJvImageComboBox
              Left = 1
              Width = 119
              ItemHeight = 22
              ItemIndex = -1
              ExplicitLeft = 1
              ExplicitWidth = 119
            end
            inherited cbContinue: TCheckBox
              Width = 582
              ExplicitWidth = 582
            end
          end
          inherited tabAdditional: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 449
            ExplicitHeight = 291
            inherited lblDbdTheta: TLabel
              Left = 86
              Width = 448
              Height = 16
              ExplicitLeft = 86
              ExplicitWidth = 448
              ExplicitHeight = 16
            end
            inherited lblDbdKappa: TLabel
              Left = 86
              Top = 38
              Width = 455
              Height = 16
              ExplicitLeft = 86
              ExplicitTop = 38
              ExplicitWidth = 455
              ExplicitHeight = 16
            end
            inherited lblDbdGamma: TLabel
              Left = 86
              Top = 88
              Width = 363
              ExplicitLeft = 86
              ExplicitTop = 88
              ExplicitWidth = 363
            end
            inherited lblMomentumCoefficient: TLabel
              Left = 86
              Top = 127
              Width = 200
              Height = 16
              Caption = 'Momentum coefficient (MOMFACT)'
              WordWrap = False
              ExplicitLeft = 86
              ExplicitTop = 127
              ExplicitWidth = 200
              ExplicitHeight = 16
            end
            inherited Label4: TLabel
              Left = 86
              Top = 175
              Width = 425
              ExplicitLeft = 86
              ExplicitTop = 175
              ExplicitWidth = 425
            end
            inherited lblBackTol: TLabel
              Left = 85
              Top = 216
              Width = 450
              Height = 48
              ExplicitLeft = 85
              ExplicitTop = 216
              ExplicitWidth = 450
              ExplicitHeight = 48
            end
            inherited lblReductionFactor: TLabel
              Left = 86
              Top = 276
              Width = 467
              Height = 32
              ExplicitLeft = 86
              ExplicitTop = 276
              ExplicitWidth = 467
              ExplicitHeight = 32
            end
            inherited rdeDbdTheta: TRbwDataEntry
              Left = 2
              ExplicitLeft = 2
            end
            inherited rdeDbdKappa: TRbwDataEntry
              Left = 2
              Top = 42
              ExplicitLeft = 2
              ExplicitTop = 42
            end
            inherited rdeDbdGamma: TRbwDataEntry
              Left = 2
              Top = 87
              ExplicitLeft = 2
              ExplicitTop = 87
            end
            inherited rdeMomentumCoefficient: TRbwDataEntry
              Left = 2
              Top = 124
              ExplicitLeft = 2
              ExplicitTop = 124
            end
            inherited cbUseResidualControl: TCheckBox
              Left = 2
              Top = 152
              Width = 423
              ExplicitLeft = 2
              ExplicitTop = 152
              ExplicitWidth = 423
            end
            inherited seMaxReductions: TJvSpinEdit
              Left = 1
              Top = 175
              Width = 79
              Height = 26
              ExplicitLeft = 1
              ExplicitTop = 175
              ExplicitWidth = 79
              ExplicitHeight = 26
            end
            inherited rdeBackTol: TRbwDataEntry
              Left = 1
              Top = 224
              ExplicitLeft = 1
              ExplicitTop = 224
            end
            inherited rdeReductionFactor: TRbwDataEntry
              Left = 2
              Top = 281
              ExplicitLeft = 2
              ExplicitTop = 281
            end
          end
          inherited tabGmresVariables: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 449
            ExplicitHeight = 291
            inherited lblIluMethod: TLabel
              Left = 2
              Top = 35
              ExplicitLeft = 2
              ExplicitTop = 35
            end
            inherited lblFillLimit1: TLabel
              Left = 89
              Top = 100
              ExplicitLeft = 89
              ExplicitTop = 100
            end
            inherited lblFillLimit2: TLabel
              Left = 89
              Top = 132
              ExplicitLeft = 89
              ExplicitTop = 132
            end
            inherited lblTolerance: TLabel
              Left = 89
              Top = 164
              Width = 333
              Height = 16
              WordWrap = False
              ExplicitLeft = 89
              ExplicitTop = 164
              ExplicitWidth = 333
              ExplicitHeight = 16
            end
            inherited lblRestarts: TLabel
              Left = 89
              Top = 192
              ExplicitLeft = 89
              ExplicitTop = 192
            end
            inherited seMaxIterationsGmres: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited comboIluMethod: TJvImageComboBox
              Left = 2
              Top = 63
              Width = 358
              DroppedWidth = 358
              ItemHeight = 22
              ItemIndex = -1
              ExplicitLeft = 2
              ExplicitTop = 63
              ExplicitWidth = 358
            end
            inherited seFillLimit1: TJvSpinEdit
              Left = 2
              Top = 97
              Height = 26
              ExplicitLeft = 2
              ExplicitTop = 97
              ExplicitHeight = 26
            end
            inherited seFillLimit2: TJvSpinEdit
              Left = 2
              Top = 129
              Height = 26
              ExplicitLeft = 2
              ExplicitTop = 129
              ExplicitHeight = 26
            end
            inherited rdeTolerance: TRbwDataEntry
              Left = 2
              Top = 161
              ExplicitLeft = 2
              ExplicitTop = 161
            end
            inherited seRestarts: TJvSpinEdit
              Left = 2
              Top = 189
              Height = 26
              ExplicitLeft = 2
              ExplicitTop = 189
              ExplicitHeight = 26
            end
          end
          inherited TabChi_MD_Variables: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 449
            ExplicitHeight = 291
            inherited lblAccelMethod: TLabel
              Left = 239
              ExplicitLeft = 239
            end
            inherited lblOrderingScheme: TLabel
              Left = 239
              ExplicitLeft = 239
            end
            inherited lblFillLevel: TLabel
              Left = 86
              Top = 66
              ExplicitLeft = 86
              ExplicitTop = 66
            end
            inherited lblNumOrtho: TLabel
              Left = 86
              Top = 87
              Width = 452
              Height = 16
              ExplicitLeft = 86
              ExplicitTop = 87
              ExplicitWidth = 452
              ExplicitHeight = 16
            end
            inherited lblResRedCrit: TLabel
              Left = 86
              Top = 157
              Width = 302
              Height = 16
              WordWrap = False
              ExplicitLeft = 86
              ExplicitTop = 157
              ExplicitWidth = 302
              ExplicitHeight = 16
            end
            inherited lblDropTolerance: TLabel
              Left = 86
              Top = 209
              Width = 247
              Height = 16
              WordWrap = False
              ExplicitLeft = 86
              ExplicitTop = 209
              ExplicitWidth = 247
              ExplicitHeight = 16
            end
            inherited lblHeadClosure: TLabel
              Left = 86
              Top = 237
              Width = 360
              Height = 16
              WordWrap = False
              ExplicitLeft = 86
              ExplicitTop = 237
              ExplicitWidth = 360
              ExplicitHeight = 16
            end
            inherited lblMaxIterChimd: TLabel
              Left = 86
              Top = 265
              ExplicitLeft = 86
              ExplicitTop = 265
            end
            inherited comboAccelMethod: TJvImageComboBox
              Width = 230
              ItemHeight = 22
              ItemIndex = -1
              ExplicitWidth = 230
            end
            inherited comboOrderingScheme: TJvImageComboBox
              Width = 230
              DroppedWidth = 230
              ItemHeight = 22
              ItemIndex = -1
              ExplicitWidth = 230
            end
            inherited seFillLevel: TJvSpinEdit
              Left = 2
              Height = 26
              ExplicitLeft = 2
              ExplicitHeight = 26
            end
            inherited seNumOrtho: TJvSpinEdit
              Left = 2
              Top = 93
              Height = 26
              ExplicitLeft = 2
              ExplicitTop = 93
              ExplicitHeight = 26
            end
            inherited cbApplyReducedPreconditioning: TCheckBox
              Left = 2
              Top = 131
              ExplicitLeft = 2
              ExplicitTop = 131
            end
            inherited rdeResRedCrit: TRbwDataEntry
              Left = 2
              Top = 154
              ExplicitLeft = 2
              ExplicitTop = 154
            end
            inherited cbUseDropTolerance: TCheckBox
              Left = 2
              Top = 183
              Width = 439
              ExplicitLeft = 2
              ExplicitTop = 183
              ExplicitWidth = 439
            end
            inherited rdeDropTolerance: TRbwDataEntry
              Left = 2
              Top = 206
              ExplicitLeft = 2
              ExplicitTop = 206
            end
            inherited rdeHeadClosure: TRbwDataEntry
              Left = 2
              Top = 234
              ExplicitLeft = 2
              ExplicitTop = 234
            end
            inherited seMaxIterChimd: TJvSpinEdit
              Left = 2
              Top = 262
              Height = 26
              ExplicitLeft = 2
              ExplicitTop = 262
              ExplicitHeight = 26
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgNwt.lblComments
            end
            item
              Control = framePkgNwt.memoComments
            end
            item
              Control = framePkgNwt.rdeHeadTolerance
            end
            item
              Control = framePkgNwt.rdeFluxTolerance
            end
            item
              Control = framePkgNwt.spinMaxOuterIt
            end
            item
              Control = framePkgNwt.rdeThicknessFactor
            end
            item
              Control = framePkgNwt.comboSolverMethod
            end
            item
              Control = framePkgNwt.cbPrintFlag
            end
            item
              Control = framePkgNwt.cbCorrectForCellBottom
            end
            item
              Control = framePkgNwt.comboOptions
            end
            item
              Control = framePkgNwt.rdeDbdTheta
            end
            item
              Control = framePkgNwt.rdeDbdKappa
            end
            item
              Control = framePkgNwt.rdeDbdGamma
            end
            item
              Control = framePkgNwt.rdeMomentumCoefficient
            end
            item
              Control = framePkgNwt.cbUseResidualControl
            end
            item
              Control = framePkgNwt.seMaxReductions
            end
            item
              Control = framePkgNwt.rdeBackTol
            end
            item
              Control = framePkgNwt.rdeReductionFactor
            end
            item
              Control = framePkgNwt.seMaxIterationsGmres
            end
            item
              Control = framePkgNwt.comboIluMethod
            end
            item
              Control = framePkgNwt.rdeTolerance
            end
            item
              Control = framePkgNwt.seRestarts
            end
            item
              Control = framePkgNwt.comboAccelMethod
            end
            item
              Control = framePkgNwt.comboOrderingScheme
            end
            item
              Control = framePkgNwt.seFillLevel
            end
            item
              Control = framePkgNwt.seNumOrtho
            end
            item
              Control = framePkgNwt.cbApplyReducedPreconditioning
            end
            item
              Control = framePkgNwt.rdeResRedCrit
            end
            item
              Control = framePkgNwt.cbUseDropTolerance
            end
            item
              Control = framePkgNwt.rdeDropTolerance
            end
            item
              Control = framePkgNwt.rdeHeadClosure
            end
            item
              Control = framePkgNwt.seMaxIterChimd
            end>
          OnEnabledChange = framePkgNwtrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspMt3dmsBasic: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'BTN_Basic_Transport_Package'
      Caption = 'jvspMt3dmsBasic'
      inline framePkgMt3dBasic: TframeMt3dBasicPkg
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblComments: TLabel
          Width = 247
          Caption = 'Comments (first two lines are the Heading)'
          ExplicitWidth = 247
        end
        inherited lblInactiveConcentration: TLabel
          Top = 150
          ExplicitTop = 150
        end
        inherited edMassUnit: TLabeledEdit
          Width = 65
          Height = 26
          EditLabel.ExplicitLeft = 84
          EditLabel.ExplicitTop = 124
          EditLabel.ExplicitWidth = 106
          ExplicitWidth = 65
          ExplicitHeight = 26
        end
        inherited grpInitialConcentrationTimes: TGroupBox
          Width = 576
          ExplicitWidth = 576
          inherited lblStressPeriod: TLabel
            Left = 8
            ExplicitLeft = 8
          end
          inherited lblTimeStep: TLabel
            Left = 216
            ExplicitLeft = 216
          end
          inherited lblTransportStep: TLabel
            Left = 392
            ExplicitLeft = 392
          end
          inherited seStressPeriod: TJvSpinEdit
            Left = 108
            Top = 21
            Height = 26
            TabOrder = 0
            ExplicitLeft = 108
            ExplicitTop = 21
            ExplicitHeight = 26
          end
          inherited seTimeStep: TJvSpinEdit
            Left = 290
            Height = 26
            TabOrder = 1
            ExplicitLeft = 290
            ExplicitHeight = 26
          end
          inherited seTransportStep: TJvSpinEdit
            Left = 497
            Height = 26
            TabOrder = 2
            ExplicitLeft = 497
            ExplicitHeight = 26
          end
        end
        inherited pnlSpecies: TPanel
          Top = 265
          Width = 595
          Height = 249
          ExplicitTop = 265
          ExplicitWidth = 595
          ExplicitHeight = 249
          inherited Splitter1: TSplitter
            Left = 300
            Height = 247
            ExplicitLeft = 300
            ExplicitHeight = 321
          end
          inherited frameGridImmobile: TframeGrid
            Left = 305
            Width = 289
            Height = 247
            ExplicitLeft = 305
            ExplicitWidth = 289
            ExplicitHeight = 247
            inherited Panel: TPanel
              Top = 206
              Width = 289
              ExplicitTop = 206
              ExplicitWidth = 289
              inherited sbAdd: TSpeedButton
                Left = 147
                ExplicitLeft = 147
              end
              inherited sbInsert: TSpeedButton
                Left = 175
                ExplicitLeft = 175
              end
              inherited sbDelete: TSpeedButton
                Left = 203
                ExplicitLeft = 203
              end
              inherited seNumber: TJvSpinEdit
                Height = 26
                ExplicitHeight = 26
              end
            end
            inherited Grid: TRbwDataGrid4
              Width = 289
              Height = 206
              Columns = <
                item
                  AutoAdjustRowHeights = True
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = True
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -13
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = 'Select...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -13
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = True
                  ButtonWidth = 80
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = False
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end>
              ExplicitWidth = 289
              ExplicitHeight = 206
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24)
            end
          end
          inherited frameGridMobile: TframeGrid
            Width = 299
            Height = 247
            ExplicitWidth = 299
            ExplicitHeight = 247
            inherited Panel: TPanel
              Top = 206
              Width = 299
              ExplicitTop = 206
              ExplicitWidth = 299
              inherited seNumber: TJvSpinEdit
                Height = 26
                ExplicitHeight = 26
              end
            end
            inherited Grid: TRbwDataGrid4
              Width = 299
              Height = 206
              Columns = <
                item
                  AutoAdjustRowHeights = True
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -11
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = True
                  ButtonCaption = '...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -13
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = False
                  ButtonWidth = 20
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4Boolean
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = True
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end
                item
                  AutoAdjustRowHeights = False
                  ButtonCaption = 'Select...'
                  ButtonFont.Charset = DEFAULT_CHARSET
                  ButtonFont.Color = clWindowText
                  ButtonFont.Height = -13
                  ButtonFont.Name = 'Tahoma'
                  ButtonFont.Style = []
                  ButtonUsed = True
                  ButtonWidth = 80
                  CheckMax = False
                  CheckMin = False
                  ComboUsed = False
                  Format = rcf4String
                  LimitToList = False
                  MaxLength = 0
                  ParentButtonFont = False
                  WordWrapCaptions = False
                  WordWrapCells = False
                  CaseSensitivePicklist = False
                  CheckStyle = csCheck
                  AutoAdjustColWidths = True
                end>
              ExplicitWidth = 299
              ExplicitHeight = 206
              ColWidths = (
                64
                64
                64)
              RowHeights = (
                24
                24)
            end
          end
        end
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgMt3dBasic.lblComments
            end
            item
              Control = framePkgMt3dBasic.memoComments
            end
            item
              Control = framePkgMt3dBasic.edMassUnit
            end
            item
              Control = framePkgMt3dBasic.rdeInactiveConcentration
            end
            item
              Control = framePkgMt3dBasic.rdeMinimumSaturatedFraction
            end
            item
              Control = framePkgMt3dBasic.frameGridMobile
            end
            item
              Control = framePkgMt3dBasic.frameGridImmobile
            end>
        end
      end
    end
    object jvspMt3dmsGCG: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'GCG_Generalized_Conjugate_Grad'
      Caption = 'jvspMt3dmsGCG'
      inline frameMt3dmsGcgPackage: TframeMt3dmsGcgPackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited spinMaxOuter: TJvSpinEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited spinMaxInner: TJvSpinEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited comboPreconditioner: TComboBox
          Width = 259
          ExplicitWidth = 259
          ExplicitHeight = 24
        end
        inherited comboDispersion: TComboBox
          Width = 425
          ExplicitWidth = 425
          ExplicitHeight = 24
        end
        inherited spinPrintoutInterval: TJvSpinEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = frameMt3dmsGcgPackage.lblComments
            end
            item
              Control = frameMt3dmsGcgPackage.memoComments
            end
            item
              Control = frameMt3dmsGcgPackage.spinMaxOuter
            end
            item
              Control = frameMt3dmsGcgPackage.spinMaxInner
            end
            item
              Control = frameMt3dmsGcgPackage.comboPreconditioner
            end
            item
              Control = frameMt3dmsGcgPackage.comboDispersion
            end
            item
              Control = frameMt3dmsGcgPackage.rdeConvergence
            end
            item
              Control = frameMt3dmsGcgPackage.spinPrintoutInterval
            end>
        end
      end
    end
    object jvspMt3dmsAdv: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'ADV_Advection_Package_Pane'
      Caption = 'jvspMt3dmsAdv'
      inline frameMt3dmsAdvPkg: TframeMt3dmsAdvPkg
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited pcAdvection: TPageControl
          Top = 146
          Width = 595
          Height = 368
          ExplicitTop = 146
          ExplicitWidth = 595
          ExplicitHeight = 368
          inherited tabAdvection1: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 337
            inherited lbllMethod: TLabel
              Top = 6
              Width = 155
              Height = 32
              WordWrap = True
              ExplicitTop = 6
              ExplicitWidth = 155
              ExplicitHeight = 32
            end
            inherited lblParticleTracking: TLabel
              Top = 51
              ExplicitTop = 51
            end
            inherited lbNumCellsParticle: TLabel
              Left = 2
              Top = 115
              Width = 424
              Height = 32
              WordWrap = True
              ExplicitLeft = 2
              ExplicitTop = 115
              ExplicitWidth = 424
              ExplicitHeight = 32
            end
            inherited lblMaxParticlesCount: TLabel
              Left = 2
              Top = 157
              ExplicitLeft = 2
              ExplicitTop = 157
            end
            inherited lblConcWeight: TLabel
              Left = 2
              Top = 189
              ExplicitLeft = 2
              ExplicitTop = 189
            end
            inherited lblNegConcGrad: TLabel
              Left = 2
              Top = 217
              ExplicitLeft = 2
              ExplicitTop = 217
            end
            inherited lblInitParticlesSmall: TLabel
              Left = 2
              Top = 245
              Width = 360
              Height = 32
              WordWrap = True
              ExplicitLeft = 2
              ExplicitTop = 245
              ExplicitWidth = 360
              ExplicitHeight = 32
            end
            inherited lblInitParticlesLarge: TLabel
              Left = 2
              Top = 289
              Width = 360
              Height = 32
              WordWrap = True
              ExplicitLeft = 2
              ExplicitTop = 289
              ExplicitWidth = 360
              ExplicitHeight = 32
            end
            inherited Label12: TLabel
              Top = 83
              ExplicitTop = 83
            end
            inherited comboAdvSolScheme: TComboBox
              Left = 224
              Width = 350
              ItemIndex = 3
              Text = 'Modified method of characterisitics MMOC (2)'
              ExplicitLeft = 224
              ExplicitWidth = 350
              ExplicitHeight = 24
            end
            inherited comboParticleTrackingAlg: TComboBox
              Left = 269
              Top = 48
              ExplicitLeft = 269
              ExplicitTop = 48
              ExplicitHeight = 24
            end
            inherited adeMaxParticleMovement: TRbwDataEntry
              Left = 485
              Top = 112
              ExplicitLeft = 485
              ExplicitTop = 112
            end
            inherited adeConcWeight: TRbwDataEntry
              Left = 485
              Top = 186
              ExplicitLeft = 485
              ExplicitTop = 186
            end
            inherited adeNeglSize: TRbwDataEntry
              Left = 485
              Top = 214
              ExplicitLeft = 485
              ExplicitTop = 214
            end
            inherited comboAdvWeightingScheme: TComboBox
              Left = 344
              Top = 80
              Width = 230
              ExplicitLeft = 344
              ExplicitTop = 80
              ExplicitWidth = 230
              ExplicitHeight = 24
            end
            inherited spinMaxParticlesCount: TJvSpinEdit
              Left = 485
              Top = 154
              Height = 26
              ExplicitLeft = 485
              ExplicitTop = 154
              ExplicitHeight = 26
            end
            inherited spinInitParticlesSmall: TJvSpinEdit
              Left = 485
              Top = 242
              Height = 26
              ExplicitLeft = 485
              ExplicitTop = 242
              ExplicitHeight = 26
            end
            inherited spinInitParticlesLarge: TJvSpinEdit
              Left = 485
              Top = 286
              Height = 26
              ExplicitLeft = 485
              ExplicitTop = 286
              ExplicitHeight = 26
            end
          end
          inherited tabAdvection2: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 593
            ExplicitHeight = 305
            inherited lblInitParticlePlanes: TLabel
              Top = 35
              ExplicitTop = 35
            end
            inherited lblMinParticles: TLabel
              Left = 2
              Top = 67
              ExplicitLeft = 2
              ExplicitTop = 67
            end
            inherited lblMaxParticles: TLabel
              Left = 2
              Top = 99
              ExplicitLeft = 2
              ExplicitTop = 99
            end
            inherited lblSinkParticlePlacement: TLabel
              Left = 2
              Top = 131
              ExplicitLeft = 2
              ExplicitTop = 131
            end
            inherited lblSinkParticlePlanes: TLabel
              Left = 2
              Top = 163
              ExplicitLeft = 2
              ExplicitTop = 163
            end
            inherited lblSinkParticleN: TLabel
              Left = 2
              Top = 195
              ExplicitLeft = 2
              ExplicitTop = 195
            end
            inherited lblCritConcGrad: TLabel
              Left = 2
              Top = 227
              ExplicitLeft = 2
              ExplicitTop = 227
            end
            inherited comboInitPartPlace: TComboBox
              Left = 437
              Width = 108
              ExplicitLeft = 437
              ExplicitWidth = 108
              ExplicitHeight = 24
            end
            inherited comboInitPartSinkChoice: TComboBox
              Left = 437
              Top = 128
              Width = 108
              ExplicitLeft = 437
              ExplicitTop = 128
              ExplicitWidth = 108
              ExplicitHeight = 24
            end
            inherited adeCritRelConcGrad: TRbwDataEntry
              Left = 437
              Top = 224
              Width = 108
              ExplicitLeft = 437
              ExplicitTop = 224
              ExplicitWidth = 108
            end
            inherited spinInitParticlePlanes: TJvSpinEdit
              Left = 437
              Top = 32
              Width = 108
              Height = 26
              ExplicitLeft = 437
              ExplicitTop = 32
              ExplicitWidth = 108
              ExplicitHeight = 26
            end
            inherited spinMinParticles: TJvSpinEdit
              Left = 437
              Top = 64
              Width = 108
              Height = 26
              ExplicitLeft = 437
              ExplicitTop = 64
              ExplicitWidth = 108
              ExplicitHeight = 26
            end
            inherited spinMaxParticles: TJvSpinEdit
              Left = 437
              Top = 96
              Width = 108
              Height = 26
              ExplicitLeft = 437
              ExplicitTop = 96
              ExplicitWidth = 108
              ExplicitHeight = 26
            end
            inherited spinSinkParticlePlanes: TJvSpinEdit
              Left = 437
              Top = 160
              Width = 108
              Height = 26
              ExplicitLeft = 437
              ExplicitTop = 160
              ExplicitWidth = 108
              ExplicitHeight = 26
            end
            inherited spinSinkParticleN: TJvSpinEdit
              Left = 437
              Top = 192
              Width = 108
              Height = 26
              ExplicitLeft = 437
              ExplicitTop = 192
              ExplicitWidth = 108
              ExplicitHeight = 26
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = frameMt3dmsAdvPkg.lblComments
            end
            item
              Control = frameMt3dmsAdvPkg.memoComments
            end
            item
              Control = frameMt3dmsAdvPkg.comboAdvSolScheme
            end
            item
              Control = frameMt3dmsAdvPkg.comboAdvWeightingScheme
            end
            item
              Control = frameMt3dmsAdvPkg.adeMaxParticleMovement
            end
            item
              Control = frameMt3dmsAdvPkg.spinMaxParticlesCount
            end>
        end
      end
    end
    object jvspMt3dmsDsp: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'DSP_Dispersion_Package_Pane'
      Caption = 'jvspMt3dmsDsp'
      inline frameMt3dmsDispersionPkg: TframeMt3dmsDispersionPkg
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited cbMultiDiffusion: TCheckBox
          Width = 545
          Height = 44
          ExplicitWidth = 545
          ExplicitHeight = 44
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = frameMt3dmsDispersionPkg.lblComments
            end
            item
              Control = frameMt3dmsDispersionPkg.memoComments
            end
            item
              Control = frameMt3dmsDispersionPkg.cbMultiDiffusion
            end>
        end
      end
    end
    object jvspMt3dmsSsm: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SSM_Sink__Source_Mixing_Packag'
      Caption = 'jvspMt3dmsSsm'
      inline framePkgSSM: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 463
          ExplicitWidth = 564
          ExplicitHeight = 463
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSSM.lblComments
            end
            item
              Control = framePkgSSM.memoComments
            end>
        end
      end
    end
    object jvspMt3dmsRct: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RCT_Chemical_Reactions_Package'
      Caption = 'jvspMt3dmsRctPkg'
      inline framePkgMt3dmsRct: TframeMt3dmsChemReactionPkg
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited cbInitialConcChoice: TCheckBox
          Width = 561
          ExplicitWidth = 561
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgMt3dmsRct.lblComments
            end
            item
              Control = framePkgMt3dmsRct.memoComments
            end
            item
              Control = framePkgMt3dmsRct.comboSorptionChoice
            end
            item
              Control = framePkgMt3dmsRct.comboKineticChoice
            end
            item
              Control = framePkgMt3dmsRct.cbInitialConcChoice
            end>
        end
      end
    end
    object jvspMt3dmsTOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'TOB_Transport_Observation_Pack'
      Caption = 'jvspMt3dmsTOB'
      inline framePkgMt3dmsTob: TframeMt3dmsTransObsPkg
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited grpbxConcentrationObservations: TGroupBox
          inherited lblSaveType: TLabel
            Top = 70
            ExplicitTop = 70
          end
          inherited rdeConcScaleFactor: TRbwDataEntry
            Top = 42
            ExplicitTop = 42
          end
          inherited comboSaveConcType: TJvImageComboBox
            ItemHeight = 22
            ItemIndex = -1
          end
          inherited cbLogTransform: TCheckBox
            Top = 125
            ExplicitTop = 125
          end
          inherited cbInterpolate: TCheckBox
            Top = 149
            ExplicitTop = 149
          end
        end
        inherited grpbxMassFluxObservations: TGroupBox
          Left = 17
          ExplicitLeft = 17
          inherited comboSaveMassFluxType: TJvImageComboBox
            ItemHeight = 22
            ItemIndex = -1
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgMt3dmsTob.lblComments
            end
            item
              Control = framePkgMt3dmsTob.memoComments
            end
            item
              Control = framePkgMt3dmsTob.cbSaveBinary
            end
            item
              Control = framePkgMt3dmsTob.rdeConcScaleFactor
            end
            item
              Control = framePkgMt3dmsTob.comboSaveConcType
            end
            item
              Control = framePkgMt3dmsTob.cbLogTransform
            end
            item
              Control = framePkgMt3dmsTob.cbInterpolate
            end
            item
              Control = framePkgMt3dmsTob.rdeMassFluxScaleFactor
            end
            item
              Control = framePkgMt3dmsTob.comboSaveMassFluxType
            end>
        end
      end
    end
    object jvspPCGN: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'PCGN_Preconditioned_Conjugate_'
      Caption = 'jvspPCGN'
      inline framePackagePcgn: TframePackagePcgn
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited lblComments: TLabel
          Top = 56
          ExplicitTop = 56
        end
        inherited lblPackage: TLabel
          Anchors = [akLeft, akTop, akRight]
          WordWrap = True
        end
        inherited memoComments: TMemo
          Top = 80
          Width = 564
          Height = 71
          ExplicitTop = 80
          ExplicitWidth = 564
          ExplicitHeight = 71
        end
        inherited pcControls: TPageControl
          Width = 595
          Height = 357
          ExplicitWidth = 595
          ExplicitHeight = 357
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 592
            ExplicitHeight = 362
            inherited seIter_mo: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seIter_mi: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seIfill: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited cbUnit_pc: TCheckBox
              Width = 470
              ExplicitWidth = 470
            end
          end
          inherited tabNonLinear: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 326
            inherited lblMcnvg: TLabel
              WordWrap = True
            end
            inherited lblRate_C: TLabel
              Top = 255
              ExplicitTop = 255
            end
            inherited lblIpunit: TLabel
              Top = 280
              ExplicitTop = 280
            end
            inherited comboDampingMode: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited comboAcnvg: TJvImageComboBox
              ItemHeight = 22
              ItemIndex = -1
            end
            inherited seMcnvg: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited rdeRate_C: TRbwDataEntry
              Top = 252
              ExplicitTop = 252
            end
            inherited comboIpunit: TJvImageComboBox
              Top = 280
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 280
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePackagePcgn.lblComments
            end
            item
              Control = framePackagePcgn.memoComments
            end
            item
              Control = framePackagePcgn.seIter_mo
            end
            item
              Control = framePackagePcgn.seIter_mi
            end
            item
              Control = framePackagePcgn.rdeCLOSE_R
            end
            item
              Control = framePackagePcgn.rdeClose_H
            end
            item
              Control = framePackagePcgn.rdeRelax
            end
            item
              Control = framePackagePcgn.seIfill
            end
            item
              Control = framePackagePcgn.cbUnit_pc
            end
            item
              Control = framePackagePcgn.cbUnit_ts
            end
            item
              Control = framePackagePcgn.comboDampingMode
            end
            item
              Control = framePackagePcgn.rdeDamp
            end
            item
              Control = framePackagePcgn.rdeDamp_Lb
            end
            item
              Control = framePackagePcgn.rdeRate_D
            end
            item
              Control = framePackagePcgn.rdeChglimit
            end
            item
              Control = framePackagePcgn.comboAcnvg
            end
            item
              Control = framePackagePcgn.comboIpunit
            end>
        end
      end
    end
    object jvspSTR: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'STR_Stream_package'
      Caption = 'jvspSTR'
      inline framePkgStr: TframePackageStr
        Left = 0
        Top = 0
        Width = 595
        Height = 201
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 201
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited cbCalculateStage: TCheckBox
          Height = 20
          ExplicitHeight = 20
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgStr.lblComments
            end
            item
              Control = framePkgStr.memoComments
            end
            item
              Control = framePkgStr.cbCalculateStage
            end
            item
              Control = frameStrParameterDefinition
            end>
        end
      end
      inline frameStrParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 201
        Width = 595
        Height = 313
        Align = alClient
        Enabled = False
        TabOrder = 1
        TabStop = True
        ExplicitTop = 201
        ExplicitWidth = 595
        ExplicitHeight = 313
        inherited pnlParameterCount: TPanel
          Top = 265
          Width = 595
          ExplicitTop = 265
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 491
            OnClick = frameParameterDefinition_btnDeleteClick
            ExplicitLeft = 491
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 259
          ExplicitWidth = 589
          ExplicitHeight = 259
          ColWidths = (
            64
            64)
        end
      end
    end
    object jvspSTOB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'STOB_Stream_Observation_Packag'
      Caption = 'jvspSTOB'
      inline framePkgSTOB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSTOB.lblComments
            end
            item
              Control = framePkgSTOB.memoComments
            end>
        end
      end
    end
    object jvspFHB: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'FHB_Flow_and_Head_Boundary_Pac'
      Caption = 'jvspFHB'
      inline framePkgFHB: TframePackage
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 446
          ExplicitWidth = 564
          ExplicitHeight = 446
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgFHB.lblComments
            end
            item
              Control = framePkgFHB.memoComments
            end>
        end
      end
    end
    object jvspFMP: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'FMP_Farm_Process'
      Caption = 'jvspFMP'
      inline frameFmpParameterDefinition: TframeListParameterDefinition
        Left = 0
        Top = 360
        Width = 595
        Height = 154
        Align = alBottom
        Enabled = False
        TabOrder = 0
        TabStop = True
        ExplicitTop = 360
        ExplicitWidth = 595
        ExplicitHeight = 154
        inherited pnlParameterCount: TPanel
          Top = 106
          Width = 595
          ExplicitTop = 106
          ExplicitWidth = 595
          inherited btnDelete: TBitBtn
            Left = 491
            ExplicitLeft = 491
          end
          inherited seNumberOfParameters: TJvSpinEdit
            Height = 26
            OnChange = frameParameterDefinition_seNumberOfParametersChange
            ExplicitHeight = 26
          end
        end
        inherited dgParameters: TRbwDataGrid4
          Width = 589
          Height = 100
          ExplicitWidth = 589
          ExplicitHeight = 100
          ColWidths = (
            64
            64)
        end
      end
      inline framePkgFrm: TframePkgFarm
        Left = 0
        Top = 0
        Width = 595
        Height = 360
        Align = alClient
        TabOrder = 1
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 360
        inherited splttrFarm: TJvNetscapeSplitter
          Left = 128
          Height = 360
          ExplicitLeft = 128
          ExplicitHeight = 350
        end
        inherited memoComments: TMemo
          Width = 163
          Height = 47
          ExplicitWidth = 163
          ExplicitHeight = 47
        end
        inherited jvplFarm: TJvPageList
          Left = 138
          Width = 457
          Height = 360
          OnChange = framePkgFrmjvplFarmChange
          ExplicitLeft = 138
          ExplicitWidth = 457
          ExplicitHeight = 360
          inherited jvspOptions: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited rgAssignmentMethod: TRadioGroup
              Width = 345
              ExplicitWidth = 345
            end
            inherited comboCropIrrigationRequirement: TComboBox
              ExplicitHeight = 24
            end
            inherited comboRecomputeFlows: TComboBox
              ExplicitHeight = 24
            end
          end
          inherited jvspParameters: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
          end
          inherited jvspWhenToRead: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited comboRootingDepth: TComboBox
              ExplicitHeight = 24
            end
            inherited comboConsumptiveUse: TComboBox
              ExplicitHeight = 24
            end
            inherited comboInefficiencyLosses: TComboBox
              ExplicitHeight = 24
            end
            inherited comboPrecipitation: TComboBox
              ExplicitHeight = 24
            end
          end
          inherited jvspWaterPolicy: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited comboDeficiency: TComboBox
              ExplicitHeight = 24
            end
            inherited frameEfficiencyBehavior: TframeRadioGrid
              Width = 457
              ExplicitWidth = 457
              inherited grpDescription: TGroupBox
                Width = 454
                ExplicitWidth = 454
                inherited lblTop: TLabel
                  Left = 168
                  ExplicitLeft = 168
                end
                inherited lblLeft: TMMJLabel
                  Width = 18
                  Height = 106
                  ExplicitWidth = 18
                  ExplicitHeight = 106
                end
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 417
                  Height = 233
                  Margins.Top = 20
                  ExplicitTop = 40
                  ExplicitWidth = 417
                  ExplicitHeight = 233
                end
              end
            end
          end
          inherited jvspCropConsumptiveUse: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited frameCropConsumptiveUse: TframeRadioGrid
              Width = 457
              Height = 360
              ExplicitWidth = 457
              ExplicitHeight = 360
              inherited grpDescription: TGroupBox
                Width = 454
                Height = 357
                ExplicitWidth = 454
                ExplicitHeight = 357
                inherited lblLeft: TMMJLabel
                  Width = 18
                  Height = 188
                  ExplicitWidth = 18
                  ExplicitHeight = 188
                end
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 417
                  Height = 312
                  FixedCols = 0
                  OnSelectCell = frameCropConsumptiveUserdgGridSelectCell
                  ExplicitTop = 40
                  ExplicitWidth = 417
                  ExplicitHeight = 312
                  ColWidths = (
                    64
                    64
                    64)
                  RowHeights = (
                    24
                    24
                    24)
                end
              end
            end
          end
          inherited jvspSurfaceWater: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited comboRoutedDelivery: TComboBox
              ExplicitHeight = 24
            end
            inherited comboRoutedReturnFlow: TComboBox
              ExplicitHeight = 24
            end
            inherited comboAllotment: TComboBox
              ExplicitHeight = 24
            end
          end
          inherited jvspMandatoryPrintFlags1: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited lblSaveRecharge: TLabel
              Top = 72
              ExplicitTop = 72
            end
            inherited lblSupplyAndDemand: TLabel
              Top = 128
              ExplicitTop = 128
            end
            inherited comboSaveWellFlowRates: TComboBox
              ExplicitHeight = 24
            end
            inherited comboSaveRecharge: TComboBox
              Top = 94
              ExplicitTop = 94
              ExplicitHeight = 24
            end
            inherited comboSupplyAndDemand: TComboBox
              Top = 150
              ExplicitTop = 150
              ExplicitHeight = 24
            end
          end
          inherited jvspOptionalPrintFlags: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited frameAcreageOptimizationPrintSettings: TframeRadioGrid
              Top = 60
              Width = 457
              Height = 300
              TabOrder = 1
              ExplicitTop = 60
              ExplicitWidth = 457
              ExplicitHeight = 300
              inherited grpDescription: TGroupBox
                Width = 454
                Height = 297
                ExplicitWidth = 454
                ExplicitHeight = 297
                inherited lblTop: TLabel
                  Left = 256
                  ExplicitLeft = 256
                end
                inherited lblLeft: TMMJLabel
                  Width = 18
                  Height = 86
                  ExplicitWidth = 18
                  ExplicitHeight = 86
                end
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 401
                  Height = 252
                  FixedCols = 0
                  ExplicitTop = 40
                  ExplicitWidth = 401
                  ExplicitHeight = 252
                  RowHeights = (
                    24
                    24
                    24
                    24
                    24
                    24)
                end
              end
            end
            inherited comboDiversionBudgetLocation: TComboBox
              TabOrder = 2
              ExplicitHeight = 24
            end
            inherited frameRoutingInformationPrintFlag: TframeRadioGrid
              Width = 457
              ExplicitWidth = 457
              inherited grpDescription: TGroupBox
                Width = 454
                ExplicitWidth = 454
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 401
                  Height = 97
                  FixedCols = 0
                  ExplicitTop = 40
                  ExplicitWidth = 401
                  ExplicitHeight = 97
                  ColWidths = (
                    64
                    64
                    64
                    64)
                  RowHeights = (
                    24
                    24
                    24)
                end
              end
            end
          end
          inherited jvspMandatoryPrintFlags2: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited frameET_PrintFlag: TframeRadioGrid
              Width = 457
              ExplicitWidth = 457
              inherited grpDescription: TGroupBox
                Width = 454
                ExplicitWidth = 454
                inherited lblLeft: TMMJLabel
                  Left = 3
                  Top = 29
                  ExplicitLeft = 3
                  ExplicitTop = 29
                end
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 401
                  Height = 163
                  FixedCols = 0
                  ExplicitTop = 40
                  ExplicitWidth = 401
                  ExplicitHeight = 163
                  ColWidths = (
                    64
                    64
                    64
                    64
                    64
                    64)
                  RowHeights = (
                    24
                    24
                    24)
                end
              end
            end
            inherited frameFarmBudgetPrintFlag: TframeRadioGrid
              Top = 81
              Width = 457
              Height = 279
              ExplicitTop = 81
              ExplicitWidth = 457
              ExplicitHeight = 279
              inherited grpDescription: TGroupBox
                Width = 454
                Height = 276
                ExplicitWidth = 454
                ExplicitHeight = 276
                inherited lblLeft: TMMJLabel
                  Top = 24
                  Width = 18
                  Height = 146
                  ExplicitTop = 24
                  ExplicitWidth = 18
                  ExplicitHeight = 146
                end
                inherited rdgGrid: TRbwDataGrid4
                  Top = 40
                  Width = 401
                  Height = 231
                  FixedCols = 0
                  ExplicitTop = 40
                  ExplicitWidth = 401
                  ExplicitHeight = 231
                  ColWidths = (
                    60
                    60
                    60
                    60
                    60)
                  RowHeights = (
                    24
                    24
                    24)
                end
              end
            end
          end
          inherited jvspMnwNwtOptions: TJvStandardPage
            Width = 457
            Height = 360
            ExplicitWidth = 457
            ExplicitHeight = 360
            inherited grpMNWOptions: TGroupBox
              Width = 457
              ExplicitWidth = 457
              inherited lblRPCT: TLabel
                Width = 277
                ExplicitWidth = 277
              end
              inherited lblHPCT: TLabel
                Width = 256
                ExplicitWidth = 256
              end
              inherited lblQClose: TLabel
                Width = 240
                Height = 48
                ExplicitWidth = 240
                ExplicitHeight = 48
              end
            end
            inherited grpNwtOptions: TGroupBox
              Width = 457
              ExplicitWidth = 457
              inherited lblPSIRAMPF: TLabel
                Width = 277
                Height = 32
                ExplicitWidth = 277
                ExplicitHeight = 32
              end
              inherited lblSATTHK: TLabel
                Width = 247
                Height = 48
                ExplicitWidth = 247
                ExplicitHeight = 48
              end
            end
          end
        end
        inherited tvpglstFarm: TJvPageListTreeView
          Width = 128
          Height = 360
          Items.Links = {00000000}
          ExplicitWidth = 128
          ExplicitHeight = 360
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgFrm.lblComments
            end
            item
              Control = framePkgFrm.memoComments
            end
            item
              Control = framePkgFrm.comboRecomputeFlows
            end
            item
              Control = framePkgFrm.rgAssignmentMethod
            end
            item
              Control = framePkgFrm.comboCropIrrigationRequirement
            end
            item
              Control = framePkgFrm.frameCropConsumptiveUse
            end
            item
              Control = framePkgFrm.comboSaveWellFlowRates
            end
            item
              Control = framePkgFrm.comboSaveRecharge
            end
            item
              Control = framePkgFrm.comboSupplyAndDemand
            end
            item
              Control = framePkgFrm.frameFarmBudgetPrintFlag
            end
            item
              Control = framePkgFrm.rgAssignmentMethod
            end
            item
              Control = framePkgFrm.comboRoutedDelivery
            end
            item
              Control = framePkgFrm.comboRoutedReturnFlow
            end
            item
              Control = framePkgFrm.comboAllotment
            end
            item
              Control = framePkgFrm.frameEfficiencyBehavior
            end
            item
              Control = framePkgFrm.comboDeficiency
            end
            item
              Control = framePkgFrm.comboRootingDepth
            end
            item
              Control = framePkgFrm.comboConsumptiveUse
            end
            item
              Control = framePkgFrm.comboPrecipitation
            end
            item
              Control = framePkgFrm.comboInefficiencyLosses
            end
            item
              Control = frameFmpParameterDefinition
            end
            item
              Control = framePkgFrm.cbGroundwaterAllotments
            end
            item
              Control = framePkgFrm.cbResetQMax
            end
            item
              Control = framePkgFrm.cbMnwClose
            end
            item
              Control = framePkgFrm.rdePSIRAMPF
            end
            item
              Control = framePkgFrm.rdeSATTHK
            end>
          OnEnabledChange = framePkgFrmrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspCFP: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'CFP_Conduit_Flow_Process'
      Caption = 'jvspCFP'
      inline framePkgCFP: TframePackageCFP
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited pgcConduits: TPageControl
          Top = 135
          Width = 595
          ExplicitTop = 135
          ExplicitWidth = 595
          inherited tabCFP: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 348
            inherited cbPipes: TCheckBox
              OnClick = framePkgCFPcbPipesClick
            end
            inherited seMaxIterations: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited comboPipeExchange: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboElevationChoice: TJvImageComboBox
              ItemHeight = 22
            end
          end
          inherited tabCRCH_COC: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 29
            ExplicitWidth = 522
            ExplicitHeight = 346
            inherited cbConduitRecharge: TCheckBox
              Width = 493
              ExplicitWidth = 493
            end
            inherited seOutputInterval: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgCFP.lblComments
            end
            item
              Control = framePkgCFP.memoComments
            end
            item
              Control = framePkgCFP.cbPipes
            end
            item
              Control = framePkgCFP.cbLayers
            end>
          OnEnabledChange = framePkgCFPrcSelectionControllerEnabledChange
        end
      end
    end
    object jvspSWI: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SWI2_Seawater_Intrusion_Packag'
      Caption = 'jvspSWI'
      inline framePackageSWI: TframePackageSWI
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        DesignSize = (
          595
          514)
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited pcSWI: TPageControl
          Width = 595
          Height = 432
          ExplicitWidth = 595
          ExplicitHeight = 432
          inherited tabBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 587
            ExplicitHeight = 401
            inherited lblDensityChoice: TLabel
              Left = 364
              ExplicitLeft = 364
            end
            inherited lblObservations: TLabel
              Left = 256
              ExplicitLeft = 256
            end
            inherited lblMaxAdaptiveSteps: TLabel
              Width = 365
              ExplicitWidth = 365
            end
            inherited lblMinAdaptiveSteps: TLabel
              Width = 362
              ExplicitWidth = 362
            end
            inherited lblAdaptiveFactor: TLabel
              Width = 409
              ExplicitWidth = 409
            end
            inherited comboObservations: TJvImageComboBox
              Width = 238
              DroppedWidth = 238
              ItemHeight = 22
              ExplicitWidth = 238
            end
            inherited seNumberOfSurfaces: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited cbSaveZeta: TCheckBox
              Width = 301
              ExplicitWidth = 301
            end
            inherited comboDensityChoice: TJvImageComboBox
              Width = 346
              DroppedWidth = 346
              ItemHeight = 22
              ItemIndex = -1
              ExplicitWidth = 346
            end
            inherited cbAdaptive: TCheckBox
              Width = 429
              ExplicitWidth = 429
            end
            inherited seMaxAdaptiveSteps: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seMinAdaptiveSteps: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited rdeAdaptiveFactor: TRbwDataEntry
              Left = 13
              ExplicitLeft = 13
            end
            inherited comboModflowPrecision: TJvImageComboBox
              ItemHeight = 22
            end
          end
          inherited tabSolver: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 27
            ExplicitWidth = 437
            ExplicitHeight = 409
            inherited lblSolver: TLabel
              Left = 139
              ExplicitLeft = 139
            end
            inherited lblPrintoutInterval: TLabel
              Top = 35
              ExplicitTop = 35
            end
            inherited lblPCGPrintControl: TLabel
              Top = 68
              Caption = 'Printing control (MUTSOL)'
              ExplicitTop = 68
            end
            inherited lblPCGMethod: TLabel
              Left = 281
              Top = 151
              ExplicitLeft = 281
              ExplicitTop = 151
            end
            inherited lblEigenValue: TLabel
              Left = 187
              ExplicitLeft = 187
            end
            inherited comboSolver: TJvImageComboBox
              Width = 130
              ItemHeight = 22
              ExplicitWidth = 130
            end
            inherited sePrintoutInterval: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seMaxIterOuter: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seMaxIterInner: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited comboPCGPrecondMeth: TJvImageComboBox
              Top = 148
              Width = 273
              DroppedWidth = 273
              ExplicitTop = 148
              ExplicitWidth = 273
            end
            inherited comboEigenValue: TJvImageComboBox
              Width = 178
              ExplicitWidth = 178
            end
          end
          inherited tabDensity: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 29
            ExplicitWidth = 437
            ExplicitHeight = 407
            inherited rdgDensity: TRbwDataGrid4
              Height = 407
              FixedCols = 0
              ExplicitHeight = 407
              ColWidths = (
                64
                64)
              RowHeights = (
                24
                24
                24
                24
                24)
            end
          end
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePackageSWI.lblComments
            end
            item
              Control = framePackageSWI.memoComments
            end
            item
              Control = framePackageSWI.seNumberOfSurfaces
            end
            item
              Control = framePackageSWI.comboDensityChoice
            end
            item
              Control = framePackageSWI.cbSaveZeta
            end
            item
              Control = framePackageSWI.comboObservations
            end
            item
              Control = framePackageSWI.rdeToeslope
            end
            item
              Control = framePackageSWI.rdeTipSlope
            end
            item
              Control = framePackageSWI.rdeAlpha
            end
            item
              Control = framePackageSWI.rdeBeta
            end
            item
              Control = framePackageSWI.cbAdaptive
            end
            item
              Control = framePackageSWI.comboSolver
            end
            item
              Control = framePackageSWI.sePrintoutInterval
            end
            item
              Control = framePackageSWI.comboPCGPrint
            end
            item
              Control = framePackageSWI.rdgDensity
            end>
        end
      end
    end
    object jvspSWR: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'SWR_Surface_Water_Routing_Proc'
      Caption = 'jvspSWR'
      inline framePkgSWR: TframePackageSwr
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        inherited jvplSwr: TJvPageList
          HelpType = htKeyword
          HelpKeyword = 'SWR_Surface_Water_Routing_Proc'
          OnChange = framePkgSWRjvplSwrChange
          inherited jvspSolutionOptions: TJvStandardPage
            inherited lblScaling: TLabel
              Top = 296
              ExplicitTop = 296
            end
            inherited lblReordering: TLabel
              Top = 344
              ExplicitTop = 344
            end
            inherited lblNewton: TLabel
              Top = 398
              ExplicitTop = 398
            end
            inherited cbSwrOnly: TCheckBox
              Height = 41
              WordWrap = True
              ExplicitHeight = 41
            end
            inherited cbContinueNonConverge: TCheckBox
              Top = 50
              ExplicitTop = 50
            end
            inherited cbUpstreamWeighting: TCheckBox
              Top = 90
              ExplicitTop = 90
            end
            inherited cbInexactNewton: TCheckBox
              Top = 130
              ExplicitTop = 130
            end
            inherited cbUseSteadyStateStorage: TCheckBox
              Top = 164
              ExplicitTop = 164
            end
            inherited cbUseLaggedStagesAndFlows: TCheckBox
              Top = 201
              ExplicitTop = 201
            end
            inherited cbUseLinearDepthScaling: TCheckBox
              Top = 249
              Height = 41
              ExplicitTop = 249
              ExplicitHeight = 41
            end
            inherited comboScaling: TJvImageComboBox
              Top = 318
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 318
            end
            inherited comboReordering: TJvImageComboBox
              Top = 363
              ItemHeight = 22
              ExplicitTop = 363
            end
            inherited comboNewton: TJvImageComboBox
              Top = 420
              ItemHeight = 22
              ItemIndex = -1
              ExplicitTop = 420
            end
          end
          inherited jvspTimeStepOptions: TJvStandardPage
            inherited lblTimeStepIncreaseFrequency: TLabel
              Width = 185
              Height = 32
              ExplicitWidth = 185
              ExplicitHeight = 32
            end
            inherited lblMinGradientForDiffusiveFlow: TLabel
              Width = 206
              Height = 32
              ExplicitWidth = 206
              ExplicitHeight = 32
            end
            inherited lblMaxRainfallForStepAdjustment: TLabel
              Width = 218
              Height = 32
              ExplicitWidth = 218
              ExplicitHeight = 32
            end
            inherited lblMaxStageChangePerStep: TLabel
              Width = 190
              ExplicitWidth = 190
            end
            inherited lblMaxInflowChange: TLabel
              Width = 193
              ExplicitWidth = 193
            end
            inherited seTimeStepIncreaseFrequency: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
          end
          inherited jvspSpecificationMethod: TJvStandardPage
            inherited grpSpecificationMethod: TGroupBox
              inherited rgRainfallSpecification: TRadioGroup
                Items.Strings = (
                  'Specify by reach (> 0)'
                  'Specify by cell (< 0)')
              end
              inherited rgEvapSpecification: TRadioGroup
                Items.Strings = (
                  'Specify by reach (> 0)'
                  'Specify by cell (< 0)')
              end
              inherited rgLateralInflowSpecification: TRadioGroup
                Items.Strings = (
                  'Specify by reach (> 0)'
                  'Specify by cell (< 0)')
              end
              inherited rgStageSpecification: TRadioGroup
                Items.Strings = (
                  'Specify by reach (> 0)'
                  'Specify by cell (< 0)')
              end
            end
            inherited grpAssignmentMethod: TGroupBox
              Left = 227
              Width = 212
              Align = alClient
              ExplicitLeft = 227
              ExplicitWidth = 212
              inherited rgRainAssignmentMethod: TRadioGroup
                Width = 206
                ExplicitWidth = 206
              end
              inherited rgEvapAssignmentMethod: TRadioGroup
                Width = 206
                ExplicitWidth = 206
              end
              inherited rgLateralInflowAssignmentMethod: TRadioGroup
                Width = 206
                ExplicitWidth = 206
              end
              inherited rgStageAssignmentMethod: TRadioGroup
                Width = 206
                ExplicitWidth = 206
              end
            end
          end
          inherited jvspPrintOptions: TJvStandardPage
            inherited lblPrintInflowsAndOutflows: TLabel
              Top = 5
              Width = 252
              ExplicitTop = 5
              ExplicitWidth = 252
            end
            inherited lblSaveSwrTimeStepLength: TLabel
              Width = 160
              Height = 32
              ExplicitWidth = 160
              ExplicitHeight = 32
            end
            inherited lblSaveRiver: TLabel
              Top = 338
              ExplicitTop = 338
            end
            inherited lblSaveObs: TLabel
              Top = 392
              ExplicitTop = 392
            end
            inherited lblSaveFrequency: TLabel
              Top = 475
              Width = 207
              ExplicitTop = 475
              ExplicitWidth = 207
            end
            inherited lblObsFormat: TLabel
              Top = 448
              ExplicitTop = 448
            end
            inherited comboPrintInflowsAndOutflows: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboPrintStage: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboPrintReachExchangeAndProperties: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboPrintReachLateralFlow: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboPrintStructureFlow: TJvImageComboBox
              ItemHeight = 22
            end
            inherited comboSaveSwrTimeStepLength: TJvImageComboBox
              ItemHeight = 22
            end
            inherited cbSaveConvergenceHistory: TCheckBox
              Top = 299
              ExplicitTop = 299
            end
            inherited comboSaveRiver: TJvImageComboBox
              Top = 358
              Items = <
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'None'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'SAVE_RIVER_PACKAGE'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'SAVE_RIVER_PACKAGE_ALL'
                end>
              ExplicitTop = 358
            end
            inherited comboSaveObs: TJvImageComboBox
              Top = 414
              Items = <
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'None'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'SAVE_SWROBSERVATIONS'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'SAVE_SWROBSERVATIONS_ALL'
                end>
              ExplicitTop = 414
            end
            inherited rdeSaveFrequency: TRbwDataEntry
              Top = 478
              ExplicitTop = 478
            end
            inherited cbSaveAverageSimulatedResults: TCheckBox
              Top = 257
              ExplicitTop = 257
            end
            inherited comboObsFormat: TJvImageComboBox
              Top = 445
              ItemHeight = 22
              ExplicitTop = 445
            end
          end
          inherited jvspSolverMandatory: TJvStandardPage
            inherited lblMaxOuterIterations: TLabel
              Width = 213
              ExplicitWidth = 213
            end
            inherited lblMaxInnerIterations: TLabel
              Width = 212
              ExplicitWidth = 212
            end
            inherited lblMaxLineSearchIterations: TLabel
              Width = 188
              ExplicitWidth = 188
            end
            inherited lblSteadyStateDampingFactor: TLabel
              Width = 165
              Height = 32
              Caption = 'Steady state damping factor (DAMPSS) '
              WordWrap = True
              ExplicitWidth = 165
              ExplicitHeight = 32
            end
            inherited lblTransientDampingFactor: TLabel
              Top = 361
              ExplicitTop = 361
            end
            inherited lblConvergencePrintoutInterval: TLabel
              Top = 390
              ExplicitTop = 390
            end
            inherited lblPrintConvergence: TLabel
              Top = 419
              ExplicitTop = 419
            end
            inherited comboSolver: TJvImageComboBox
              ItemHeight = 22
            end
            inherited seMaxOuterIterations: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seMaxInnerIterations: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited seMaxLineSearchIterations: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited comboFlowToleranceOption: TJvImageComboBox
              Top = 193
              ItemIndex = -1
              Items = <
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'None'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'USE_FRACTIONAL_TOLR'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'USE_L2NORM_TOLR'
                end>
              ExplicitTop = 193
            end
            inherited comboExchangeToleranceOption: TJvImageComboBox
              ItemIndex = -1
              Items = <
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'None'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'USE_GLOBAL_TOLA'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'USE_ABSOLUTE_TOLA'
                end>
            end
            inherited rdeExchangeTolerance: TRbwDataEntry
              Top = 288
              ExplicitTop = 288
            end
            inherited rdeSteadyStateDampingFactor: TRbwDataEntry
              Top = 322
              ExplicitTop = 322
            end
            inherited rdeTransientDampingFactor: TRbwDataEntry
              Top = 358
              ExplicitTop = 358
            end
            inherited seConvergencePrintoutInterval: TJvSpinEdit
              Top = 386
              Height = 26
              ExplicitTop = 386
              ExplicitHeight = 26
            end
            inherited comboPrintConvergence: TJvImageComboBox
              Top = 438
              ItemIndex = -1
              Items = <
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'Print max residual every time step (0)'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'Print number of iterations (1)'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'Print none (2)'
                end
                item
                  Brush.Style = bsClear
                  Indent = 0
                  Text = 'Print if convergence fails (3)'
                end>
              ExplicitTop = 438
            end
          end
          inherited jvspSolverOptional: TJvStandardPage
            inherited lblPreconditioner: TLabel
              Left = 255
              ExplicitLeft = 255
            end
            inherited lblPrintLineSearchInterval: TLabel
              Width = 249
              ExplicitWidth = 249
            end
            inherited comboPreconditioner: TJvImageComboBox
              Width = 243
              ItemHeight = 22
              ItemIndex = -1
              ExplicitWidth = 243
            end
            inherited seMaxLevels: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
            inherited sePrintLineSearchInterval: TJvSpinEdit
              Height = 26
              ExplicitHeight = 26
            end
          end
        end
        inherited tvpglstSwr: TJvPageListTreeView
          Items.Links = {00000000}
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSWR.lblComments
            end
            item
              Control = framePkgSWR.memoComments
            end>
        end
      end
    end
    object jvspMNW1: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'MNW1_Multi_Node_Well_Package_V'
      Caption = 'jvspMNW1'
      inline framePkgMnw1: TframePackageMnw1
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        inherited seMaxIterations: TJvSpinEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited comboLosstype: TJvImageComboBox
          ItemHeight = 22
          ItemIndex = -1
        end
        inherited fedWellFileName: TJvFilenameEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited fedByNode: TJvFilenameEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited fedQSum: TJvFilenameEdit
          Height = 26
          ExplicitHeight = 26
        end
        inherited comboByNodeFrequency: TJvImageComboBox
          ItemHeight = 22
        end
        inherited comboQSumFrequency: TJvImageComboBox
          ItemHeight = 22
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgMnw1.lblComments
            end
            item
              Control = framePkgMnw1.memoComments
            end
            item
              Control = framePkgMnw1.seMaxIterations
            end
            item
              Control = framePkgMnw1.comboLosstype
            end
            item
              Control = framePkgMnw1.fedWellFileName
            end
            item
              Control = framePkgMnw1.fedByNode
            end
            item
              Control = framePkgMnw1.fedQSum
            end>
        end
      end
    end
    object jvspNPF: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      Caption = 'jvspNPF'
      inline framePkgNpf: TframePackageNpf
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited rdgOptions: TRbwDataGrid4
          Width = 564
          Height = 338
          ExplicitWidth = 564
          ExplicitHeight = 338
          RowHeights = (
            24
            24
            24
            24
            24
            24)
        end
        inherited comboInterblockMethod: TJvImageComboBox
          Width = 564
          DroppedWidth = 564
          ItemHeight = 22
          ExplicitWidth = 564
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgNpf.lblComments
            end
            item
              Control = framePkgNpf.memoComments
            end
            item
              Control = framePkgNpf.comboInterblockMethod
            end
            item
              Control = framePkgNpf.rdgOptions
            end>
        end
      end
    end
    object jvspSTO: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      Caption = 'jvspSTO'
      inline framePkgSto: TframePkgSto
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        Enabled = False
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited comboStorageChoice: TJvImageComboBox
          ItemHeight = 22
          ItemIndex = -1
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSto.lblComments
            end
            item
              Control = framePkgSto.memoComments
            end
            item
              Control = framePkgSto
            end
            item
              Control = framePkgSto.cbNewton
            end>
        end
      end
    end
    object jvspSMS: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      Caption = 'jvspSMS'
      inline framePkgSMS: TframePkgSms
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          ExplicitWidth = 564
        end
        inherited comboPrintOption: TJvImageComboBox
          ItemHeight = 22
          ItemIndex = -1
          TabOrder = 2
        end
        inherited comboComplexity: TJvImageComboBox
          ItemHeight = 22
          TabOrder = 3
        end
        inherited rdgOptions: TRbwDataGrid4
          Width = 595
          Height = 266
          FixedCols = 0
          ExplicitWidth = 595
          ExplicitHeight = 266
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
        inherited seSolutionGroupMaxIter: TJvSpinEdit
          Left = 271
          Top = 184
          Height = 26
          TabOrder = 1
          ExplicitLeft = 271
          ExplicitTop = 184
          ExplicitHeight = 26
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgSMS.lblComments
            end
            item
              Control = framePkgSMS.memoComments
            end
            item
              Control = framePkgSMS.comboPrintOption
            end
            item
              Control = framePkgSMS.comboComplexity
            end
            item
              Control = framePkgSMS.rdgOptions
            end
            item
              Control = framePkgSMS.seSolutionGroupMaxIter
            end
            item
              Control = framePkgSMS.cbContinue
            end>
        end
      end
    end
    object jvspRIP: TJvStandardPage
      Left = 0
      Top = 0
      Width = 595
      Height = 514
      HelpType = htKeyword
      HelpKeyword = 'RIP_Riparian_Pkg'
      Caption = 'jvspRIP'
      inline framePkgRip: TframePackageRip
        Left = 0
        Top = 0
        Width = 595
        Height = 514
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 595
        ExplicitHeight = 514
        inherited memoComments: TMemo
          Width = 564
          Height = 412
          ExplicitWidth = 564
          ExplicitHeight = 412
        end
        inherited cbWritePlantGroupFlows: TCheckBox
          Top = 480
          ExplicitTop = 480
        end
        inherited rcSelectionController: TRbwController
          ControlList = <
            item
              Control = framePkgRip.lblComments
            end
            item
              Control = framePkgRip.memoComments
            end
            item
              Control = framePkgRip.cbWritePlantGroupFlows
            end>
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 514
    Width = 782
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      782
      41)
    object btnHelp: TBitBtn
      Left = 441
      Top = 6
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnHelpClick
    end
    object btnOK: TBitBtn
      Left = 555
      Top = 6
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 669
      Top = 6
      Width = 108
      Height = 33
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 514
    Align = alLeft
    TabOrder = 0
    object pnlModel: TPanel
      Left = 1
      Top = 1
      Width = 175
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblModel: TLabel
        Left = 8
        Top = 11
        Width = 34
        Height = 16
        Caption = 'Model'
      end
      object comboModel: TComboBox
        Left = 8
        Top = 32
        Width = 162
        Height = 24
        Style = csDropDownList
        TabOrder = 0
        OnChange = comboModelChange
      end
    end
    object tvPackages: TTreeView
      Left = 1
      Top = 65
      Width = 175
      Height = 448
      Align = alClient
      HideSelection = False
      Indent = 20
      ReadOnly = True
      StateImages = ilCheckImages
      TabOrder = 1
      OnChange = tvPackagesChange
      OnCustomDrawItem = tvPackagesCustomDrawItem
      OnExpanded = tvPackagesExpanded
      OnMouseUp = tvPackagesMouseUp
    end
  end
  object rbwLpfParamCountController: TRbwController
    ControlList = <
      item
        Control = frameLpfParameterDefinition.btnDelete
      end
      item
        Control = frameLpfParameterDefinition.dgParameters
      end
      item
        Control = frameLpfParameterDefinition.lblNumParameters
      end
      item
        Control = frameLpfParameterDefinition.seNumberOfParameters
      end>
    Left = 72
    Top = 216
  end
  object ilCheckImages: TImageList
    Left = 136
    Top = 96
    Bitmap = {
      494C010108000D003C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      00000000000000000000000000000000000000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000C0C0C00000000000000000000000000000000000C0C0C000C0C0
      C0000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000000000000000C0C0
      C0000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000000000000000C0C0
      C0000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      80000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000000000000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000000000000808080008080
      80000000000000000000000000000000000000000000C0C0C00080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000000000000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      00000000000000000000000000000000000000000000C0C0C000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC00E2EFF100E2EF
      F100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EF
      F100E2EFF1000000000000000000000000000000000099A8AC00E2EFF100E2EF
      F100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EF
      F100E2EFF1000000000000000000000000000000000099A8AC00E2EFF100E2EF
      F100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EF
      F100E2EFF1000000000000000000000000000000000099A8AC00E2EFF100E2EF
      F100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EFF100E2EF
      F100E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000D8E9EC0000000000D8E9EC0000000000D8E9EC0000000000D8E9EC000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F7100D8E9
      EC0000000000D8E9EC0099A8AC00D8E9EC0000000000D8E9EC0000000000D8E9
      EC00E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000D8E9EC0099A8AC0099A8AC0099A8AC00D8E9EC0000000000D8E9EC000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F7100D8E9
      EC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC00D8E9EC0000000000D8E9
      EC00E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      000099A8AC0099A8AC00D8E9EC0099A8AC0099A8AC0099A8AC00D8E9EC000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F7100D8E9
      EC0099A8AC00D8E9EC0000000000D8E9EC0099A8AC0099A8AC0099A8AC00D8E9
      EC00E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000D8E9EC0000000000D8E9EC0000000000D8E9EC0099A8AC0099A8AC000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F7100D8E9
      EC0000000000D8E9EC0000000000D8E9EC0000000000D8E9EC0099A8AC00D8E9
      EC00E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F71000000
      0000D8E9EC0000000000D8E9EC0000000000D8E9EC0000000000D8E9EC000000
      0000E2EFF1000000000000000000000000000000000099A8AC00646F7100646F
      7100646F7100646F7100646F7100646F7100646F7100646F7100646F7100646F
      7100E2EFF1000000000000000000000000000000000099A8AC00646F7100646F
      7100646F7100646F7100646F7100646F7100646F7100646F7100646F7100646F
      7100E2EFF1000000000000000000000000000000000099A8AC00646F7100646F
      7100646F7100646F7100646F7100646F7100646F7100646F7100646F7100646F
      7100E2EFF1000000000000000000000000000000000099A8AC00646F7100646F
      7100646F7100646F7100646F7100646F7100646F7100646F7100646F7100646F
      7100E2EFF1000000000000000000000000000000000099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFC3FFC3FBFFFFC3FE3CFE3CF800FE00FE7EFE7EF800FE00F
      CFF7CE77800FC007CFF7CC37800FC007CFF7CC37800FC007CFF7CE77800FC007
      E7EFE7EF800FE00FE3CFE3CF800FE00FF00FF00F800FF00FFC3FFC3F800FFC3F
      FFFFFFFF8007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF80078007800780079FF79FF79FF795579FF79FF79DF788A7
      9FF79FF798F790579FF79FF7907780279FF79FF7923790179FF79FF797178207
      9FF79FF79F9795179FF79FF79FD78A879FF79FF79FF795578007800780078007
      8007800780078007FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object rbwHufParamCountController: TRbwController
    ControlList = <
      item
        Control = frameHufParameterDefinition.btnDelete
      end
      item
        Control = frameHufParameterDefinition.dgParameters
      end
      item
        Control = frameHfbParameterDefinition.lblNumParameters
      end
      item
        Control = frameHfbParameterDefinition.seNumberOfParameters
      end>
    Left = 48
    Top = 256
  end
end
