unit MeshRenumberingTypes;

interface

uses
  Generics.Collections, Generics.Defaults, FastGEO;

type
  {
    @name indicates the type of node.
    @value(ntInner The node is in the interior of the mesh and may be moved or
      eliminated to improve the mesh.)

    @value(ntEdge The node is on the external boundary of the mesh.
      It may not be moved or eliminated.)

    @value(ntSubDomain The node is on an internal boundary of the mesh.
      It may not be moved or eliminated.)

  }
  TNodeType = (ntInner, ntEdge, ntSubDomain);

  TRenumberingAlgorithm = (raNone, CuthillMcKee, raSloanRandolph);

  IElement = interface;

  INode = interface(IInterface)
    function GetActiveElementCount: integer;
    function GetActiveElement(Index: integer): IElement;
    function GetNodeNumber: integer;
    procedure SetNodeNumber(Value: integer);
    function GetLocation: TPoint2D;
    procedure SetLocation(const Value: TPoint2D);
    function GetNodeType: TNodeType;
    property ActiveElementCount: integer read GetActiveElementCount;
    property ActiveElements[Index: integer]: IElement read GetActiveElement;
    property NodeNumber: integer read GetNodeNumber write SetNodeNumber;
    property Location: TPoint2D read GetLocation write SetLocation;
    property NodeType: TNodeType read GetNodeType;
  end;

  TINodeList = TList<INode>;
  TINodeComparer = TComparer<INode>;

  IElement = interface(IInterface)
    function GetActiveNode(Index: integer): INode;
    function GetActiveNodeCount: integer;
    function GetElementNumber: integer;
    procedure SetElementNumber(Value: integer);
    property NodeCount: integer read GetActiveNodeCount;
    property Nodes[Index: integer]: INode read GetActiveNode;
    property ElementNumber: integer read GetElementNumber
      write SetElementNumber;
  end;

  TIElementList = TList<IElement>;
  TIElementComparer = TComparer<IElement>;

  IMesh = interface(IInterface)
    function GetActiveNode(Index: integer): INode;
    function GetActiveNodeCount: integer;
    function GetActiveElementCount: integer;
    function GetActiveElement(Index: integer): IElement;
    property NodeCount: integer read GetActiveNodeCount;
    property Nodes[Index: integer]: INode read GetActiveNode;
    property ElementCount: integer read GetActiveElementCount;
    property Elements[Index: integer]: IElement read GetActiveElement;
  end;



implementation

end.
