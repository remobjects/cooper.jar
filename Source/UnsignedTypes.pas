namespace remobjects.elements.system;
// Note: Since this is the library that *implements* unsigned types, you can't actually use them here.
interface

type
  Unsigned = public interface(java.lang.annotation.Annotation)
  end;

  UnsignedByte = public sealed class(Number, Comparable<UnsignedByte>)
  private
    fValue: SByte;
    const MASK: Int16 = $FF;
    class method ToShort(aValue: SByte): Int16;
  public
    const
      MAX_VALUE: SByte = SByte($FF);
      MIN_VALUE: SByte = 0;
  public
    constructor(aValue: SByte);
    constructor(aValue: String);

    method compareTo(Value: UnsignedByte): Integer;
    method intValue: RemObjects.Oxygene.System.Integer; override;
    method longValue: RemObjects.Oxygene.System.Int64; override;
    method floatValue: RemObjects.Oxygene.System.Single; override;
    method doubleValue: RemObjects.Oxygene.System.Double; override;
    method byteValue: RemObjects.Oxygene.System.SByte; override;
    method shortValue: RemObjects.Oxygene.System.SmallInt; override;

    class method unsignedToDouble(aValue: SByte): Double;
    class method unsignedToFloat(aValue: SByte): Single;
    class method doubleToUnsigned(aValue: Double): SByte;
    class method floatToUnsigned(aValue: Single): SByte;
    class method unsignedDivide(aValue, aWith: SByte): SByte;
    class method unsignedRemainder(aValue, aWith: SByte): SByte;

    class method parseByte(aValue: String): SByte;
    class method parseByte(aValue: String; Radix: Int32): SByte;

    class method valueOf(aValue: SByte): UnsignedByte;
    method equals(aOther: Object): Boolean; override;
    method hashCode: Integer; override;
    method toString: String; override;
    class method toString(aValue: SByte): String;
  end;

  UnsignedShort = public sealed class(Number, Comparable<UnsignedShort>)
  private
    fValue: Int16;
    const MASK: Integer = $FFFF;
    class method ToInt(aValue: Int16): Integer;
  public
    const
      MAX_VALUE: Int16 = Int16($FFFF);
      MIN_VALUE: Int16 = 0;
  public
    constructor(aValue: Int16);
    constructor(aValue: String);

    method compareTo(Value: UnsignedShort): Integer;
    method intValue: RemObjects.Oxygene.System.Integer; override;
    method longValue: RemObjects.Oxygene.System.Int64; override;
    method floatValue: RemObjects.Oxygene.System.Single; override;
    method doubleValue: RemObjects.Oxygene.System.Double; override;
    method byteValue: RemObjects.Oxygene.System.SByte; override;
    method shortValue: RemObjects.Oxygene.System.SmallInt; override;

    class method unsignedToDouble(aValue: Int16): Double;
    class method unsignedToFloat(aValue: Int16): Single;
    class method doubleToUnsigned(aValue: Double): Int16;
    class method floatToUnsigned(aValue: Single): Int16;
    class method unsignedDivide(aValue, aWith: Int16): Int16;
    class method unsignedRemainder(aValue, aWith: Int16): Int16;

    class method parseShort(aValue: String): Int16;
    class method parseShort(aValue: String; Radix: Int32): Int16;

    class method valueOf(aValue: Int16): UnsignedShort;
    method toString: String; override;
    method &equals(aOther: Object): Boolean; override;
    method hashCode: Integer; override;
    class method toString(aValue: Int16): String;
  end;

  UnsignedInteger = public sealed class(Number, Comparable<UnsignedInteger>)
  private
    fValue: Int32;
    const MASK: Int64 = $FFFFFFFF;
    class method ToLong(aValue: Int32): Int64;
  public
    const
      MAX_VALUE: Int32 = Int32($FFFFFFFF);
      MIN_VALUE: Int32 = 0;
  public
    constructor(aValue: Int32);
    constructor(aValue: String);
    method compareTo(Value: UnsignedInteger): Integer;
    method intValue: RemObjects.Oxygene.System.Integer; override;
    method longValue: RemObjects.Oxygene.System.Int64; override;
    method floatValue: RemObjects.Oxygene.System.Single; override;
    method doubleValue: RemObjects.Oxygene.System.Double; override;
    method byteValue: RemObjects.Oxygene.System.SByte; override;
    method shortValue: RemObjects.Oxygene.System.SmallInt; override;

    class method unsignedToDouble(aValue: Int32): Double;
    class method unsignedToFloat(aValue: Int32): Single;
    class method doubleToUnsigned(aValue: Double): Int32;
    class method floatToUnsigned(aValue: Single): Int32;
    class method unsignedDivide(aValue, aWith: Int32): Int32;
    class method unsignedRemainder(aValue, aWith: Int32): Int32;

    class method parseInt(aValue: String): Int32;
    class method parseInt(aValue: String; Radix: Int32): Int32;

    class method valueOf(aValue: Int32): UnsignedInteger;
    method toString: String; override;
    method &equals(aOther: Object): Boolean; override;
    method hashCode: Integer; override;
    class method toString(aValue: Int32): String;
    class method toString(aValue: Int32; Radix: Int32): String;
    class method toBinaryString(aValue: Int32): String;
    class method toHexString(aValue: Int32): String;
    class method toOctalString(aValue: Int32): String;
  end;

  UnsignedLong = public sealed class(Number, Comparable<UnsignedLong>)
  private
    fValue: Int64;
    class method UnsignedCompare(X,Y: Int64): Integer;
  public
    const
      MAX_VALUE: Int64 = $FFFFFFFFFFFFFFFF;
      MIN_VALUE: Int64 = 0;
  public
    constructor(aValue: Int64);
    constructor(aValue: String);
    method compareTo(Value: UnsignedLong): Integer;
    method intValue: RemObjects.Oxygene.System.Integer; override;
    method longValue: RemObjects.Oxygene.System.Int64; override;
    method floatValue: RemObjects.Oxygene.System.Single; override;
    method doubleValue: RemObjects.Oxygene.System.Double; override;
    method byteValue: RemObjects.Oxygene.System.SByte; override;
    method shortValue: RemObjects.Oxygene.System.SmallInt; override;

    class method unsignedToDouble(aValue: Int64): Double;
    class method unsignedToFloat(aValue: Int64): Single;
    class method doubleToUnsigned(aValue: Double): Int64;
    class method floatToUnsigned(aValue: Single): Int64;
    class method unsignedDivide(aValue, aWith: Int64): Int64;
    class method unsignedRemainder(aValue, aWith: Int64): Int64;

    class method parseLong(aValue: String): Int64;
    class method parseLong(aValue: String; Radix: Int32): Int64;

    class method valueOf(aValue: Int64): UnsignedLong;
    method toString: String; override;
    method &equals(aOther: Object): Boolean; override;
    method hashCode: Integer; override;
    class method toString(aValue: Int64): String;
    class method toString(aValue: Int64; Radix: Int32): String;
    class method toBinaryString(aValue: Int64): String;
    class method toHexString(aValue: Int64): String;
    class method toOctalString(aValue: Int64): String;
  end;


implementation

{ UnsignedByte }

class method UnsignedByte.unsignedToDouble(aValue: SByte): Double;
begin
  exit Double(aValue) + if aValue < 0 then 256.0 else 0.0;
end;

class method UnsignedByte.unsignedToFloat(aValue: SByte): Single;
begin
  exit Single(aValue) + if aValue < 0 then Single(256.0) else Single(0.0);
end;

class method UnsignedByte.doubleToUnsigned(aValue: Double): SByte;
begin
  if aValue > 127.0 then
    exit SByte(Double(aValue) - 256.0)
  else
    exit SByte(aValue);
end;

class method UnsignedByte.floatToUnsigned(aValue: Single): SByte;
begin
  if aValue > Single(127.0) then
    exit SByte(Single(aValue) - Single(256.0))
  else
    exit SByte(aValue);
end;

constructor UnsignedByte(aValue: SByte);
begin
  fValue := aValue;
end;

constructor UnsignedByte(aValue: String);
begin
  fValue := parseByte(aValue, 10);
end;

method UnsignedByte.toString: String;
begin
  exit toString(fValue);
end;

class method UnsignedByte.toString(aValue: SByte): String;
begin
  exit Int16.toString(ToShort(aValue));
end;

method UnsignedByte.compareTo(Value: UnsignedByte): Integer;
begin
  if Value = nil then
    raise new NullPointerException;

  exit SByte.compare(fValue + SByte.MIN_VALUE, Value.fValue + SByte.MIN_VALUE);
end;

method UnsignedByte.intValue: RemObjects.Oxygene.System.Integer;
begin
  exit ToShort(fValue);
end;

method UnsignedByte.longValue: RemObjects.Oxygene.System.Int64;
begin
  exit ToShort(fValue);
end;

method UnsignedByte.floatValue: RemObjects.Oxygene.System.Single;
begin
  exit unsignedToFloat(fValue);
end;

method UnsignedByte.doubleValue: RemObjects.Oxygene.System.Double;
begin
  exit unsignedToDouble(fValue);
end;

class method UnsignedByte.unsignedDivide(aValue: SByte; aWith: SByte): SByte;
begin
  exit SByte(ToShort(aValue) div ToShort(aWith));
end;

class method UnsignedByte.unsignedRemainder(aValue: SByte; aWith: SByte): SByte;
begin
  exit SByte(ToShort(aValue) mod ToShort(aWith));
end;

class method UnsignedByte.ToShort(aValue: SByte): Int16;
begin
  exit aValue and MASK;
end;

method UnsignedByte.byteValue: RemObjects.Oxygene.System.SByte;
begin
  exit fValue;
end;

method UnsignedByte.shortValue: RemObjects.Oxygene.System.SmallInt;
begin
  exit ToShort(fValue);
end;

class method UnsignedByte.parseByte(aValue: String): SByte;
begin
  exit parseByte(aValue, 10);
end;

class method UnsignedByte.parseByte(aValue: String; Radix: Int32): SByte;
begin
  if aValue = nil then
    raise new NullPointerException;

  var Parsed := Int16.parseShort(aValue, Radix);
  if (Parsed and MASK) <> Parsed then
    raise new NumberFormatException("For input string: " + aValue);

  exit SByte(Parsed);
end;

class method UnsignedByte.valueOf(aValue: SByte): UnsignedByte;
begin
  exit new UnsignedByte(aValue);
end;

method UnsignedByte.equals(aOther: Object): Boolean;
begin
  var lb := UnsignedByte(aOther);
  exit (lb <> nil) and (lb.fValue = fValue);
end;

method UnsignedByte.hashCode: Integer;
begin
  exit fValue;
end;

{ UnsignedShort }

class method UnsignedShort.unsignedToDouble(aValue: Int16): Double;
begin
  exit Double(aValue) + if aValue < 0 then 65536.0 else 0.0;
end;

class method UnsignedShort.unsignedToFloat(aValue: Int16): Single;
begin
  exit Single(aValue) + if aValue < 0 then Single(65536.0) else Single(0.0);
end;

class method UnsignedShort.doubleToUnsigned(aValue: Double): Int16;
begin
  if aValue > 32767.0 then
    exit Int16(Double(aValue) - 65536.0)
  else
    exit Int16(aValue);
end;

class method UnsignedShort.floatToUnsigned(aValue: Single): Int16;
begin
  if aValue > Single(32767.0) then
    exit Int16(Single(aValue) - Single(65536.0))
  else
    exit Int16(aValue);
end;

constructor UnsignedShort(aValue: Int16);
begin
  fValue := aValue;
end;

constructor UnsignedShort(aValue: String);
begin
  fValue := parseShort(aValue, 10);
end;

method UnsignedShort.toString: String;
begin
  exit toString(fValue);
end;

class method UnsignedShort.toString(aValue: Int16): String;
begin
  exit Integer.toString(ToInt(aValue));
end;

method UnsignedShort.compareTo(Value: UnsignedShort): Integer;
begin
  if Value = nil then
    raise new NullPointerException;

  exit Int16.compare(fValue + Int16.MIN_VALUE, Value.fValue + Int16.MIN_VALUE);
end;

method UnsignedShort.intValue: RemObjects.Oxygene.System.Integer;
begin
  exit ToInt(fValue);
end;

method UnsignedShort.longValue: RemObjects.Oxygene.System.Int64;
begin
  exit ToInt(fValue);
end;

method UnsignedShort.floatValue: RemObjects.Oxygene.System.Single;
begin
  exit unsignedToFloat(fValue);
end;

method UnsignedShort.doubleValue: RemObjects.Oxygene.System.Double;
begin
  exit unsignedToDouble(fValue);
end;

class method UnsignedShort.unsignedDivide(aValue: Int16; aWith: Int16): Int16;
begin
  exit Int16(ToInt(aValue) div ToInt(aWith));
end;

class method UnsignedShort.unsignedRemainder(aValue: Int16; aWith: Int16): Int16;
begin
  exit Int16(ToInt(aValue) mod ToInt(aWith));
end;

class method UnsignedShort.ToInt(aValue: Int16): Integer;
begin
  exit aValue and MASK;
end;

method UnsignedShort.byteValue: RemObjects.Oxygene.System.SByte;
begin
  exit SByte(fValue);
end;

method UnsignedShort.shortValue: RemObjects.Oxygene.System.SmallInt;
begin
  exit fValue;
end;

class method UnsignedShort.parseShort(aValue: String): Int16;
begin
  exit parseShort(aValue, 10);
end;

class method UnsignedShort.parseShort(aValue: String; Radix: Int32): Int16;
begin
  if aValue = nil then
    raise new NullPointerException;

  var Parsed := Int32.parseInt(aValue, Radix);
  if (Parsed and MASK) <> Parsed then
    raise new NumberFormatException("For input string: " + aValue);

  exit Int16(Parsed);
end;


method UnsignedShort.equals(aOther: Object): Boolean;
begin
  var lb := UnsignedShort(aOther);
  exit (lb <> nil) and (lb.fValue = fValue);
end;

method UnsignedShort.hashCode: Integer;
begin
  exit fValue;
end;

class method UnsignedShort.valueOf(aValue: Int16): UnsignedShort;
begin
  exit new UnsignedShort(aValue);
end;

{ UnsignedInteger }


class method UnsignedInteger.unsignedToDouble(aValue: Int32): Double;
begin
  exit Double(aValue) + if aValue < 0 then 4294967296.0 else 0.0;
end;

class method UnsignedInteger.unsignedToFloat(aValue: Int32): Single;
begin
  exit Single(aValue) + if aValue < 0 then Single(4294967296.0) else Single(0.0);
end;

class method UnsignedInteger.doubleToUnsigned(aValue: Double): Int32;
begin
  if aValue > 2147483647.0 then
    exit Int32(Double(aValue) - 4294967296.0)
  else
    exit Int32(aValue);
end;

class method UnsignedInteger.floatToUnsigned(aValue: Single): Int32;
begin
  if aValue > Single(2147483647.0) then
    exit Int32(Single(aValue) - Single(4294967296.0))
  else
    exit Int32(aValue);
end;

constructor UnsignedInteger(aValue: Int32);
begin
  fValue := aValue;
end;

constructor UnsignedInteger(aValue: String);
begin
  fValue := parseInt(aValue, 10);
end;

method UnsignedInteger.toString: String;
begin
  exit toString(fValue);
end;

class method UnsignedInteger.toString(aValue: Int32): String;
begin
  exit toString(aValue, 10);
end;

class method UnsignedInteger.toString(aValue: Int32; Radix: Int32): String;
begin
  exit Long.toString(ToLong(aValue), Radix);
end;

class method UnsignedInteger.toBinaryString(aValue: Int32): String;
begin
  exit toString(aValue, 2);
end;

class method UnsignedInteger.toHexString(aValue: Int32): String;
begin
  exit toString(aValue, 16);
end;

class method UnsignedInteger.toOctalString(aValue: Int32): String;
begin
  exit toString(aValue, 8);
end;

method UnsignedInteger.compareTo(Value: UnsignedInteger): Integer;
begin
  if Value = nil then
    raise new NullPointerException;

  exit Integer.compare(fValue + Integer.MIN_VALUE, Value.fValue + Integer.MIN_VALUE);
end;

method UnsignedInteger.intValue: RemObjects.Oxygene.System.Integer;
begin
  exit fValue;
end;

method UnsignedInteger.longValue: RemObjects.Oxygene.System.Int64;
begin
  exit ToLong(fValue);
end;

method UnsignedInteger.floatValue: RemObjects.Oxygene.System.Single;
begin
  exit unsignedToFloat(fValue);
end;

method UnsignedInteger.doubleValue: RemObjects.Oxygene.System.Double;
begin
  exit unsignedToDouble(fValue);
end;

class method UnsignedInteger.unsignedDivide(aValue: Int32; aWith: Int32): Int32;
begin
  exit Int32(ToLong(aValue) div ToLong(aWith));
end;

class method UnsignedInteger.unsignedRemainder(aValue: Int32; aWith: Int32): Int32;
begin
  exit Int32(ToLong(aValue) mod ToLong(aWith));
end;

class method UnsignedInteger.ToLong(aValue: Int32): Int64;
begin
  exit aValue and MASK;
end;

method UnsignedInteger.byteValue: RemObjects.Oxygene.System.SByte;
begin
  exit SByte(fValue);
end;

method UnsignedInteger.shortValue: RemObjects.Oxygene.System.SmallInt;
begin
  exit Int16(fValue);
end;

class method UnsignedInteger.parseInt(aValue: String): Int32;
begin
  exit parseInt(aValue, 10);
end;

class method UnsignedInteger.parseInt(aValue: String; Radix: Int32): Int32;
begin
  if aValue = nil then
    raise new NullPointerException;

  var Parsed := Long.parseLong(aValue, Radix);
  if (Parsed and MASK) <> Parsed then
    raise new NumberFormatException("For input string: " + aValue);

  exit Int32(Parsed);
end;

method UnsignedInteger.equals(aOther: Object): Boolean;
begin
  var lb := UnsignedInteger(aOther);
  exit (lb <> nil) and (lb.fValue = fValue);
end;

method UnsignedInteger.hashCode: Integer;
begin
  exit fValue;
end;

class method UnsignedInteger.valueOf(aValue: Int32): UnsignedInteger;
begin
  exit new UnsignedInteger(aValue);
end;

{ UnsignedLong }

class method UnsignedLong.unsignedToDouble(aValue: Int64): Double;
begin
  exit Double(aValue) + if aValue < 0 then 18446744073709551616.0 else 0.0;
end;

class method UnsignedLong.unsignedToFloat(aValue: Int64): Single;
begin
  exit Single(aValue) + if aValue < 0 then Single(18446744073709551616.0) else Single(0.0);
end;

class method UnsignedLong.doubleToUnsigned(aValue: Double): Int64;
begin
  if aValue > 9223372036854775807.0 then
    exit Int64(Double(aValue) - 18446744073709551616.0)
  else
    exit Int64(aValue);
end;

class method UnsignedLong.floatToUnsigned(aValue: Single): Int64;
begin
  if aValue > Single(9223372036854775807.0) then
    exit Int64(Single(aValue) - Single(18446744073709551616.0))
  else
    exit Int64(aValue);
end;

constructor UnsignedLong(aValue: Int64);
begin
  fValue := aValue;
end;

constructor UnsignedLong(aValue: String);
begin
  fValue := parseLong(aValue, 10);
end;

method UnsignedLong.toString: String;
begin
  exit toString(fValue);
end;

class method UnsignedLong.toString(aValue: Int64): String;
begin
  exit toString(aValue, 10);
end;

class method UnsignedLong.toString(aValue: Int64; Radix: Int32): String;
begin
  if (Radix < Character.MIN_RADIX) or (Radix > Character.MAX_RADIX) then
    Radix := 10;

  if aValue >= 0 then
    exit Long.toString(aValue, Radix);

  var buf := new Char[Long.SIZE];
  var pos: Int32 := buf.length;
  while true do begin
    var reminder := unsignedRemainder(aValue, Radix);
    aValue := unsignedDivide(aValue, Radix);
    dec(pos);
    buf[pos] := Character.forDigit(reminder, Radix);
    if aValue = 0 then
      break;
  end;

  exit new String(buf, pos, buf.length - pos);
end;

class method UnsignedLong.toBinaryString(aValue: Int64): String;
begin
  exit toString(aValue, 2);
end;

class method UnsignedLong.toHexString(aValue: Int64): String;
begin
  exit toString(aValue, 16);
end;

class method UnsignedLong.toOctalString(aValue: Int64): String;
begin
  exit toString(aValue, 8);
end;

method UnsignedLong.compareTo(Value: UnsignedLong): Integer;
begin
  if Value = nil then
    raise new NullPointerException;

  exit UnsignedCompare(fValue, Value.fValue);
end;

method UnsignedLong.intValue: RemObjects.Oxygene.System.Integer;
begin
  exit fValue;
end;

method UnsignedLong.longValue: RemObjects.Oxygene.System.Int64;
begin
  exit fValue;
end;

method UnsignedLong.floatValue: RemObjects.Oxygene.System.Single;
begin
  exit unsignedToFloat(fValue);
end;

method UnsignedLong.doubleValue: RemObjects.Oxygene.System.Double;
begin
  exit unsignedToDouble(fValue);
end;

class method UnsignedLong.unsignedDivide(aValue: Int64; aWith: Int64): Int64;
begin
  if aWith < 0 then
    exit if UnsignedCompare(aValue, aWith) < 0 then 0 else 1;

  if aValue >= 0 then
    exit aValue div aWith;

  var Quotient: Int64 := (unsignedShr(aValue, 1) div aWith) shl 1;
  var Reminder: Int64 := aValue - Quotient * aWith;
  exit Quotient + if UnsignedCompare(Reminder, aWith) >= 0 then 1 else 0;
end;

class method UnsignedLong.unsignedRemainder(aValue: Int64; aWith: Int64): Int64;
begin
  if aWith < 0 then
    exit if UnsignedCompare(aValue, aWith) < 0 then aValue else aValue - aWith;

  if aValue >= 0 then
    exit aValue mod aWith;

  var Quotient: Int64 := (unsignedShr(aValue, 1) div aWith) shl 1;
  var Reminder: Int64 := aValue - Quotient * aWith;
  exit Reminder - if UnsignedCompare(Reminder, aWith) >= 0 then aWith else 0;
end;

class method UnsignedLong.UnsignedCompare(X: Int64; Y: Int64): Integer;
begin
  exit Int64.compare(X + Int64.MIN_VALUE, Y + Int64.MIN_VALUE);
end;

method UnsignedLong.byteValue: RemObjects.Oxygene.System.SByte;
begin
  exit SByte(fValue);
end;

method UnsignedLong.shortValue: RemObjects.Oxygene.System.SmallInt;
begin
  exit Int16(fValue);
end;

class method UnsignedLong.parseLong(aValue: String): Int64;
begin
  exit parseLong(aValue, 10);
end;

class method UnsignedLong.parseLong(aValue: String; Radix: Int32): Int64;
begin
  if aValue = nil then
    raise new NullPointerException;

  var Parsed := new java.math.BigInteger(aValue, Radix);
  var Mask := new java.math.BigInteger("FFFFFFFFFFFFFFFF", 16);
  if Parsed.and(Mask).compareTo(Parsed) <> 0 then
    raise new NumberFormatException("For input string: " + aValue);

  exit Parsed.longValue;
end;


method UnsignedLong.equals(aOther: Object): Boolean;
begin
  var lb := UnsignedLong(aOther);
  exit (lb <> nil) and (lb.fValue = fValue);
end;

method UnsignedLong.hashCode: Integer;
begin
  exit fValue;
end;

class method UnsignedLong.valueOf(aValue: Int64): UnsignedLong;
begin
  exit new UnsignedLong(aValue);
end;

end.