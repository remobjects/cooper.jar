namespace RemObjects.Elements.System;

interface

type
  ArrayUtils = public static class
  public
    class method asIterable(x: array of Boolean): sequence of nullable Boolean;iterator;
    class method asIterable(x: array of SByte): sequence of nullable SByte;iterator;
    class method asIterable(x: array of Char): sequence of nullable Char;iterator;
    class method asIterable(x: array of Double): sequence of nullable Double;iterator;
    class method asIterable(x: array of Single): sequence of nullable Single;iterator;
    class method asIterable(x: array of Integer): sequence of nullable Integer;iterator;
    class method asIterable(x: array of Int64): sequence of nullable Int64;iterator;
    class method asIterable(x: array of Int16): sequence of nullable Int16;iterator;

    class method asIterableUnsigned(x: array of SByte): sequence of remobjects.elements.system.UnsignedByte;iterator;
    class method asIterableUnsigned(x: array of Integer): sequence of remobjects.elements.system.UnsignedInteger;iterator;
    class method asIterableUnsigned(x: array of Int64): sequence of remobjects.elements.system.UnsignedLong;iterator;
    class method asIterableUnsigned(x: array of Int16): sequence of remobjects.elements.system.UnsignedShort; iterator;

    class method asIterable<T>(x: array of T): sequence of T; iterator;
    class method fill(a: array of Object; val: Object);
    begin
      var ct := if val <> nil then val.getClass().getDeclaredConstructor();
      if ct <> nil then
        ct.setAccessible(true);
      for i: Integer := 0 to length(a) -1 do begin
        if i = 0 then
          a[i] := val
        else begin
          a[i] := if ct = nil then nil else ct.newInstance();
        end;
      end;
    end;

    class method getSubArray<T>(val: array of T; aStart, aLength: Integer): array of T;
    begin
      result := java.util.Arrays.copyOfRange(val, aStart, aStart+aLength);
    end;

    class method getSubArray<T>(val: array of T; aRange: Range): array of T;
    begin
      var lLength := length(val);
      var lStart := aRange.fStart.GetOffset(lLength);
      var lEnd := aRange.fEnd.GetOffset(lLength);
      result := getSubArray(val, lStart, lEnd-lStart);
    end;

  end;

implementation

class method ArrayUtils.asIterable(x: array of Boolean): sequence of nullable Boolean;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of SByte): sequence of nullable SByte;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Char): sequence of nullable Char;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Double): sequence of nullable Double;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Single): sequence of nullable Single;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Integer): sequence of nullable Integer;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Int64): sequence of nullable Int64;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable(x: array of Int16): sequence of nullable Int16;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterable<T>(x: array of T): sequence of T;
begin
  for i: Integer := 0 to length(x) -1 do
    yield x[i];
end;

class method ArrayUtils.asIterableUnsigned(x: array of SByte): sequence of remobjects.elements.system.UnsignedByte;
begin
  for i: Integer := 0 to length(x) -1 do
    yield new remobjects.elements.system.UnsignedByte(x[i]);
end;

class method ArrayUtils.asIterableUnsigned(x: array of Integer): sequence of remobjects.elements.system.UnsignedInteger;
begin
  for i: Integer := 0 to length(x) -1 do
    yield new remobjects.elements.system.UnsignedInteger(x[i]);
end;

class method ArrayUtils.asIterableUnsigned(x: array of Int64): sequence of remobjects.elements.system.UnsignedLong;
begin
  for i: Integer := 0 to length(x) -1 do
    yield new remobjects.elements.system.UnsignedLong(x[i]);
end;

class method ArrayUtils.asIterableUnsigned(x: array of Int16): sequence of remobjects.elements.system.UnsignedShort;
begin
  for i: Integer := 0 to length(x) -1 do
    yield new remobjects.elements.system.UnsignedShort(x[i]);
end;



end.