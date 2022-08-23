namespace RemObjects.Elements.System;

type
  String_Extension = public extension class(java.lang.String)
  public

    property Item[i: &Index]: Char read self[i.GetOffset(length)]; default;
    property Item[r: Range]: String read getSubstringWithRange(r); default;

  private

    method getSubstringWithRange(aRange: Range): String;
    begin
      var lLength := self.length;
      var lStart := aRange.fStart.GetOffset(lLength);
      var lEnd := aRange.fEnd.GetOffset(lLength);
      result := substring(lStart, lEnd); // Java String expects end, *not* length!
    end;

  end;

end.