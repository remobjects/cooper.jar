namespace RemObjects.Elements;

type
  WrappedException = public class(Exception)
  public
    constructor(aObj: Object);
    begin
      inherited constructor(aObj.toString);
      Object := aObj;
    end;

    class method Wrap(o: Object): Exception;
    begin
      if o = nil then exit nil;
      if o is Exception then exit Exception(o);
      exit new WrappedException(o);
    end;

    property Object: Object; readonly;
  end;


end.