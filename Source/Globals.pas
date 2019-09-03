namespace com.remobjects.elements.system;

interface
 
{$G+}
operator Pow(a, b: Double): Double; public;
operator Pow(a, b: Int64): Int64; public;
operator Pow(a, b: Integer): Integer; public;

type
  AnsiChar = public record mapped to SByte end;

extension method &Class.IsFloat: Boolean;
extension method &Class.IsIntegerOrFloat: Boolean;
extension method &Class.IsInteger: Boolean;
extension method &Class.IsSigned: Boolean;

operator &Add(aLeft, aRight: String): String; public;
begin 
  if aLeft = nil then exit aRight;
  if aRight = nil then exit aLeft;
  exit aLeft.concat(aRight);
end;

operator &Add(aLeft: Object; aRight: String): String; public;
begin 
  if aLeft = nil then exit aRight.toString();
  if aRight = nil then exit aLeft.toString();
  exit aLeft.toString().concat(aRight.toString());
end;

operator &Add(aLeft: String; aRight: Object): String; public;
begin 
  if aLeft = nil then exit aRight.toString();
  if aRight = nil then exit aLeft.toString();
  exit aLeft.toString().concat(aRight.toString());
end;

operator Equal(aLeft, aRight: String): Boolean; public;
begin 
  if object(aLeft) = nil then exit Object(aRight) = nil;
  if aRight = nil then exit false;

  exit aLeft.equals(aRight)
end;

operator Equal(aLeft: Char; aRight: String): Boolean; public;
begin 
  if aRight = nil then exit false;

  exit aLeft.toString().equals(aRight)
end;

operator Equal(aRight: String; aLeft: Char): Boolean; public;
begin 
  if aRight = nil then exit false;

  exit aLeft.toString().equals(aRight)
end;



operator NotEqual(aLeft, aRight: String): Boolean; public;
begin 
  exit not (aLeft = aRight);
end;

operator NotEqual(aLeft: Char; aRight: String): Boolean; public;
begin 
  exit not (aLeft = aRight);
end;

operator NotEqual(aRight: String; aLeft: Char): Boolean; public;
begin 
  exit not (aLeft = aRight);
end;

implementation

extension method &Class.IsFloat: Boolean;
begin 
  exit (self = typeOf(nullable Single)) or (self = typeOf(nullable Double));
end;

extension method &Class.IsInteger: Boolean;
begin 
  exit (self = typeOf(nullable SByte)) or (self = typeOf(nullable Int16)) or 
  (self = typeOf(nullable Int32)) or (self = typeOf(nullable Int64)) or 
  (self = typeOf(UnsignedByte)) or (self = typeOf(UnsignedShort)) or 
  (self = typeOf(UnsignedInteger)) or (self = typeOf(UnsignedLong));
end;

extension method &Class.IsIntegerOrFloat: Boolean;
begin 
  exit (self = typeOf(nullable Single)) or (self = typeOf(nullable Double)) or 
    (self = typeOf(nullable SByte)) or (self = typeOf(nullable Int16)) or 
    (self = typeOf(nullable Int32)) or (self = typeOf(nullable Int64)) or 
    (self = typeOf(UnsignedByte)) or (self = typeOf(UnsignedShort)) or 
    (self = typeOf(UnsignedInteger)) or (self = typeOf(UnsignedLong));
end;

extension method &Class.IsSigned: Boolean;
begin 
  exit (self = typeOf(nullable SByte)) or (self = typeOf(nullable Int16)) or 
  (self = typeOf(nullable Int32)) or (self = typeOf(nullable Int64));
end;



operator Pow(a, b: Double): Double; 
begin
  exit java.lang.Math.pow(a,b);
end;

operator Pow(a, b: Int64): Int64; 
begin
  result := 1;
  if b < 0 then exit 0;
  while b <> 0 do begin 
    if (b and 1) <> 0 then result := result * a;
    a := a * a;
    b := b shr 1;
  end;
end;

operator Pow(a, b: Integer): Integer; 
begin
  result := 1;
  if b < 0 then exit 0;
  while b <> 0 do begin 
    if (b and 1) <> 0 then result := result * a;
    a := a * a;
    b := b shr 1;
  end;
end;


end.
