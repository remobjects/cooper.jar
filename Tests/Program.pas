namespace Cooper.DynamicHelpersFixture;

uses
  RemObjects.Elements.System;

type
  Program = public class
  public
    class method Main(aArgs: array of String): Int32;
    begin
      var lTarget := new DynamicInvokeTarget;
      var lObjectResult := DynamicHelpers.Invoke(lTarget, 'AcceptObject', 0, [new Object]);
      if String(lObjectResult) ≠ 'object' then
        raise new Exception('Object argument did not resolve through DynamicHelpers');

      var lNumberResult := DynamicHelpers.Invoke(lTarget, 'AcceptInteger', 0, [Int16(42)]);
      if String(lNumberResult) ≠ 'integer:42' then
        raise new Exception('Integral argument was not coerced through DynamicHelpers');

      result := 0;
    end;
  end;

  DynamicInvokeTarget = public class
  public
    method AcceptObject(aValue: Object): String;
    begin
      if aValue = nil then
        exit 'missing';
      result := 'object';
    end;

    method AcceptInteger(aValue: Int32): String;
    begin
      result := 'integer:' + aValue.toString;
    end;
  end;

end.
