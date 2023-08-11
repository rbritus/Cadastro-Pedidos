unit Repository.InterfacePadrao;

interface

type
  IRepository<T: class> = interface
  ['{57CAB7C4-45A7-4D0B-835A-9F2296E7246A}']
    function GetScriptInsert: string;
    function GetScriptUpdate: string;
    function GetScriptDelete: string;
    function GetScriptLoad: string;
    function GetScriptLoadList: string;
    function GetScriptLoadFilter: string;
  end;

implementation

end.
