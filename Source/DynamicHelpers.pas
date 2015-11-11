namespace com.remobjects.elements.system;

interface
uses
  java.util,
  java.lang.reflect;

type
  DynamicGetFlags = public flags (None = 0, FollowedByCall = 1, CaseSensitive = 2, CallDefault = 4, NilSafe = 8, NilOnBindingFailure = 16) of Integer;
  DynamicInvokeException = public class(Exception) end;
  DynamicHelpers = public static class
  protected
    method TryApplyIndexer(aInstance: Object; aArgs: array of Object): Object;
    method FindBestMatch(aItems: DynamicMethodGroup; aArgs: array of Object): &Method;
  public
    method GetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method SetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method Invoke(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method Invoke(aInstance: Object;  aGetFlags: Integer; aArgs: array of Object): Object;
  end;

  DynamicMethodGroup = public class
  private
    fItems: ArrayList<&Method>;
    fInst: Object;
  public
    constructor(aInst: Object; aItems: ArrayList<&Method>);
    property Inst: Object read fInst;
    property Count: Integer read fItems.size;
    property Item[i: Integer]: &Method read fItems[i]; default;
  end;

implementation

method DynamicHelpers.GetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
begin
  if aInstance = nil then begin
    if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
    raise new NullPointerException;
  end;
  if aName = nil then
    exit TryApplyIndexer(result, aArgs);
  var lCL := &Class(aInstance);
  var lStatic := lCL <> nil;
  if not lStatic then lCL := aInstance.Class;

  if length(aArgs) = 0 then begin
    for each el in lCL.getFields() do begin
      if (not lStatic or java.lang.reflect.Modifier.isStatic(el.Modifiers))
       and if DynamicGetFlags.CaseSensitive in DynamicGetFlags(aGetFlags) then el.Name = aName else el.Name.equalsIgnoreCase(aName) then begin
         exit el.get(aInstance);
      end;
    end;
  end;
  var lMethods := lCL.Methods;
  var lRes: ArrayList<&Method>;
  for each el in lMethods do begin
    if (not lStatic or java.lang.reflect.Modifier.isStatic(el.Modifiers))
    and if DynamicGetFlags.CaseSensitive in DynamicGetFlags(aGetFlags) then el.Name = aName else el.Name.equalsIgnoreCase(aName) then begin
      if lRes = nil then
        lRes := new ArrayList<&Method>;
      lRes.add(el);
    end;
  end;
  var lHadGet := false;
  if lRes = nil then begin 
    var lSingleHit: &Method;
    for each el in lMethods do begin
      var pars := el.getParameterTypes;
      if (not lStatic or java.lang.reflect.Modifier.isStatic(el.Modifiers))
        and (el.Name.startsWith('get') and (el.Name.length > 3) and (Char.isUpperCase(el.Name[3]) and 
        (if DynamicGetFlags.CaseSensitive in DynamicGetFlags(aGetFlags) then el.Name = aName else el.Name.substring(3).equalsIgnoreCase(aName))))
        and ((length(pars) = 0) or (length(pars) = length(aArgs))) then begin
        lHadGet := true;
        if lRes = nil then
          lRes := new ArrayList<&Method>;
        lRes.add(el);
        if length(pars) = 0 then
          lSingleHit := el;
      end;
    end;
    if lRes = nil then begin
      if DynamicGetFlags.NilOnBindingFailure in DynamicGetFlags(aGetFlags) then exit nil;
      raise new DynamicInvokeException('No element with this name: '+aName);
     end;
    if lSingleHit <> nil then begin
      exit TryApplyIndexer(lSingleHit.invoke(aInstance), aArgs);
    end;
    exit Invoke(new DynamicMethodGroup(aInstance, lRes), aGetFlags, aArgs);
  end;
  if ((DynamicGetFlags.CallDefault in DynamicGetFlags(aGetFlags)) or lHadGet) and (DynamicGetFlags.FollowedByCall not in DynamicGetFlags(aGetFlags)) then begin
    for i: Integer := 0 to lRes.size -1 do
      if length(lRes[i].getParameterTypes) = 0 then begin
        result := lRes[i].invoke(aInstance);
        result := TryApplyIndexer(result, aArgs);
        exit;
      end;
  end;
  if length(aArgs) <> 0 then
    raise new DynamicInvokeException('Indexer parameters cannot be applied to method group');
  exit new DynamicMethodGroup(aInstance, lRes);
end;

method DynamicHelpers.SetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
begin
  if aInstance = nil then begin
    if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
    raise new NullPointerException;
  end;
  if aName = nil then
    exit TryApplyIndexer(result, aArgs);
  var lCL := &Class(aInstance);
  var lStatic := lCL <> nil;
  if not lStatic then lCL := aInstance.Class;

  if length(aArgs) = 0 then begin
    for each el in lCL.getFields() do begin
      if (not lStatic or java.lang.reflect.Modifier.isStatic(el.Modifiers))
       and if DynamicGetFlags.CaseSensitive in DynamicGetFlags(aGetFlags) then el.Name = aName else el.Name.equalsIgnoreCase(aName) then begin
         if length(aArgs) <> 1 then
           raise new DynamicInvokeException('Too many array parameters for this member');
         el.set(aInstance, aArgs[0]);
         exit 
      end;
    end;
  end;
  var lRes: ArrayList<&Method>;
  for each el in lCL.Methods do begin
    if (not lStatic or java.lang.reflect.Modifier.isStatic(el.Modifiers))
      and (el.Name.startsWith('set') and (el.Name.length > 3) and (Char.isUpperCase(el.Name[3]) and 
      (if DynamicGetFlags.CaseSensitive in DynamicGetFlags(aGetFlags) then el.Name = aName else el.Name.substring(3).equalsIgnoreCase(aName))))
      and ((length(el.getParameterTypes) = length(aArgs))) then begin
      if lRes = nil then
        lRes := new ArrayList<&Method>;
      lRes.add(el);
    end;
  end;
  if lRes = nil then begin
    if DynamicGetFlags.NilOnBindingFailure in DynamicGetFlags(aGetFlags) then exit nil;    
    raise new DynamicInvokeException('No element with this name: '+aName);
  end;
  exit Invoke(new DynamicMethodGroup(aInstance, lRes), aGetFlags, aArgs);
end;

method DynamicHelpers.Invoke(aInstance: Object; aGetFlags: Integer; aArgs: array of Object): Object;
begin
  if aInstance = nil then begin
    if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
    if DynamicGetFlags.NilOnBindingFailure in DynamicGetFlags(aGetFlags) then exit nil;
    raise new NullPointerException;
  end;
  if aInstance is &Class then
    raise new DynamicInvokeException('Cannot invoke class');
  var lGroup := DynamicMethodGroup(aInstance);
  if lGroup = nil then
    lGroup := GetMember(aInstance, 'Invoke', Integer(DynamicGetFlags.FollowedByCall), nil) as DynamicMethodGroup;
  if lGroup = nil then
    raise new DynamicInvokeException('No overload with these parameters');
  var lMethod: &Method := FindBestMatch(lGroup, aArgs);
  if lMethod = nil then
    raise new DynamicInvokeException('No overload with these parameters');
  lMethod.Accessible := true; 
  exit lMethod.invoke(if lGroup.Inst is &Class then nil else lGroup.Inst, aArgs);
end;

method DynamicHelpers.TryApplyIndexer(aInstance: Object; aArgs: array of Object): Object;
begin
  if length(aArgs) = 0 then exit aInstance;
  with matching lInst :=  array of Object(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of SByte(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Int16(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Int32(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Int64(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Boolean(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Char(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst :=  array of Single(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  with matching lInst := array of Double(aInstance) do begin
    if (length(aArgs) <> 1) then
      raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
    if aArgs[0] is nullable Integer then 
      exit lInst[nullable Integer(aArgs[0]).intValue];
    if aArgs[0] is nullable Int64 then 
      exit lInst[nullable Int64(aArgs[0]).intValue];
    if aArgs[0] is UnsignedInteger then 
      exit lInst[UnsignedInteger(aArgs[0]).intValue];
    if aArgs[0] is UnsignedLong then 
      exit lInst[UnsignedLong(aArgs[0]).intValue];
    raise new DynamicInvokeException('Integer indexer expected');
  end;
  exit GetMember(aInstance, 'Item', 0, aArgs);
end;

method DynamicHelpers.FindBestMatch(aItems: DynamicMethodGroup; aArgs: array of Object): &Method;
begin
  for i: Integer := 0 to aItems.Count -1 do begin
    var lMeth := aItems[i];
    var lPars := lMeth.getParameterTypes;
    if length(lPars) <> length(aArgs) then continue;
    for j: Integer := 0 to lPars.length -1 do begin
      if aArgs[j] = nil then 
        if lPars[j].isPrimitive then begin
          lPars := nil;
          break;
        end;
      if lPars[j].isPrimitive then begin
        if lPars[j] = typeOf(Boolean) then
          lPars[j] := typeOf(nullable Boolean) else 
        if lPars[j] = typeOf(SByte) then
          lPars[j] := typeOf(nullable SByte) else 
        if lPars[j] = typeOf(Char) then
          lPars[j] := typeOf(nullable Char) else 
        if lPars[j] = typeOf(Double) then
          lPars[j] := typeOf(nullable Double) else 
        if lPars[j] = typeOf(Single) then
          lPars[j] := typeOf(nullable Single) else 
        if lPars[j] = typeOf(Int32) then
          lPars[j] := typeOf(nullable Int32) else 
        if lPars[j] = typeOf(Int64) then
          lPars[j] := typeOf(nullable Int64) else 
        if lPars[j] = typeOf(Int16) then
          lPars[j] := typeOf(nullable Int16);
      end;
      if not lPars[j].isAssignableFrom(aArgs[j].Class)  then begin
        lPars := nil;
        break;
      end;
    end;
    if lPars <> nil then exit lMeth;
  end;
  exit nil;
end;

method DynamicHelpers.Invoke(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
begin
  exit Invoke(GetMember(aInstance, aName, aGetFlags or Integer(DynamicGetFlags.FollowedByCall), nil), aGetFlags, aArgs);
end;

constructor DynamicMethodGroup(aInst: Object; aItems: ArrayList<&Method>);
begin
  fItems := aItems;
  fInst := aInst;
end;

end.
