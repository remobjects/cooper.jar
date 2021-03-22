namespace RemObjects.Elements.System;

interface

type
  VarParameter<T> = public sealed class
  private
  public
    constructor; empty;
    constructor(aVal: T);
    Value: T; // KEEP as variable
  end;

  ObsoleteMarker = public interface(java.lang.annotation.Annotation)
    method message: String;
    method fatal: Boolean;
  end;

  OutParameter = public interface(java.lang.annotation.Annotation)
  end;

  ValueTypeParameter = public interface(java.lang.annotation.Annotation)
  end;

  RecordType = public interface(java.lang.annotation.Annotation)
  end;

  ReadOnlyMethod = public interface(java.lang.annotation.Annotation)
  end;

implementation

constructor VarParameter<T>(aVal: T);
begin
  Value := aVal;
end;

end.