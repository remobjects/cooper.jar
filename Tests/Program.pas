// Positive dynamic invocation/indexing guards; null references bind and null primitive arguments are rejected.
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

      if String(DynamicHelpers.Invoke(lTarget, 'AcceptObject', 0, [nil])) <> 'missing' then
        raise new Exception('Null reference argument did not bind');
      var lRejected := false;
      try
        DynamicHelpers.Invoke(lTarget, 'AcceptInteger', 0, [nil]);
      except
        on e: DynamicInvokeException do lRejected := true;
      end;
      if not lRejected then
        raise new Exception('Null primitive argument was accepted');

      var lNumberResult := DynamicHelpers.Invoke(lTarget, 'AcceptInteger', 0, [Int16(42)]);
      if String(lNumberResult) ≠ 'integer:42' then
        raise new Exception('Integral argument was not coerced through DynamicHelpers');

      var lArray: array of Object := ['first', 'second'];
      if String(DynamicHelpers.GetMember(lArray, nil, 0, [1])) <> 'second' then
        raise new Exception('Dynamic array indexing lost the target instance');

      var lMap := new java.util.HashMap<String, Object>;
      lMap.put('sun', 'three');
      var lDynamic: dynamic := lMap;
      if String(lDynamic['sun']) <> 'three' then
        raise new Exception('Dynamic map indexing did not read the key');
      DynamicHelpers.SetMember(lMap, nil, 0, ['sun', 'direct']);
      if String(lMap.get('sun')) <> 'direct' then
        raise new Exception('Runtime map setter did not write the key');
      lDynamic['sun'] := 'four';
      if String(lMap.get('sun')) <> 'four' then
        raise new Exception('Dynamic map indexing did not write the key');

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
