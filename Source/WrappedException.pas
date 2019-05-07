namespace com.remobjects.elements.system;

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
      exit new WrappedException(o);
    end;

    property Object: Object; readonly;
  end;


end.