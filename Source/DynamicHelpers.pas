namespace com.remobjects.elements.system;

uses
  java.util,
  java.lang.reflect;

type
  DynamicGetFlags = public flags (None = 0, FollowedByCall = 1, CaseSensitive = 2, CallDefault = 4, NilSafe = 8, NilOnBindingFailure = 16) of Integer;
  DynamicInvokeException = public class(Exception) end;
  DynamicBinaryOperator = public enum (  
    None,
    &Add,
    Sub, 
    Mul, 
    IntDiv,
    &Div,
    &Mod,
    &Shl,
    &Shr,
    &UShr,
    &And, 
    &Or, 
    &Xor,
    GreaterEqual, 
    LessEqual, 
    Greater, 
    Less, 
    Equal, 
    NotEqual,
    &Implies = 25,
    extended = 28,
    Pow = 29,
    BoolOr =   10000, 
    BoolAnd =  10001);

  DynamicUnaryOperator = public enum (
    &Not = 0,
    Neg = 1, 
    Plus = 5, 
    Increment = 6, 
    Decrement = 7, 
    DecrementPost = 13,
    ExtendedPrefix = 14,
    ExtendedPostfix = 15
  );

  IDynamicObject = public interface 
    method GetMember(aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method SetMember(aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method Invoke(aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    method Unary(aOp: DynamicUnaryOperator; aResult: VarParameter<Object>): Boolean;
    method Binary(aOther: Object; aSelfIsLeftSide: Boolean; aOp: DynamicBinaryOperator; aResult: VarParameter<Object>): Boolean;
  end;

  DynamicHelpers = public static class
  protected
    method TryApplyIndexer(aInstance: Object; aArgs: array of Object): Object;
    begin
      if length(aArgs) = 0 then exit aInstance;
      with matching lInst :=  array of Object(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of SByte(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Int16(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Int32(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Int64(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Boolean(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Char(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst :=  array of Single(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      with matching lInst := array of Double(aInstance) do begin
        if (length(aArgs) <> 1) then
          raise new DynamicInvokeException('Cannot access indexer with more than 1 parameter');
        if aArgs[0] is nullable Integer then 
          exit lInst[nullable Integer(aArgs[0]).intValue];
        if aArgs[0] is nullable Int64 then 
          exit lInst[nullable Int64(aArgs[0]).longValue];
        if aArgs[0] is UnsignedInteger then 
          exit lInst[UnsignedInteger(aArgs[0]).intValue];
        if aArgs[0] is UnsignedLong then 
          exit lInst[UnsignedLong(aArgs[0]).longValue];
        raise new DynamicInvokeException('Integer indexer expected');
      end;
      exit GetMember(aInstance, 'Item', 0, aArgs);
    end;
    
    method FindBestMatch(aItems: DynamicMethodGroup; aArgs: array of Object): &Method;
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
              if lPars[j].IsFloat and aArgs[j].getClass.IsIntegerOrFloat then begin 
            end else if lPars[j].IsInteger and aArgs[j].getClass.IsInteger then begin 
            end else begin 
              lPars := nil;
              break;
            end;
          end;
        end;
        if lPars <> nil then begin 
          for j: Integer := 0 to lPars.length -1 do begin
            if not lPars[j].isAssignableFrom(aArgs[j] as &Class)  then begin
              if lPars[j] = typeOf(nullable SByte) then aArgs[j] := SByte.valueOf(Convert.ToSByte(aArgs[j])) else 
                if lPars[j] = typeOf(UnsignedByte) then aArgs[j] := SByte.valueOf(Convert.ToByte(aArgs[j])) else 
                if lPars[j] = typeOf(nullable Int16) then aArgs[j] := Int16.valueOf(Convert.ToInt16(aArgs[j])) else 
                if lPars[j] = typeOf(UnsignedShort) then aArgs[j] := Int16.valueOf(Convert.ToUInt16(aArgs[j])) else 
                if lPars[j] = typeOf(nullable Int32) then aArgs[j] := Int32.valueOf(Convert.ToInt32(aArgs[j]) )else 
                if lPars[j] = typeOf(UnsignedInteger) then aArgs[j] := Int32.valueOf(Convert.ToUInt32(aArgs[j])) else 
                if lPars[j] = typeOf(nullable Int64) then aArgs[j] := Int64.valueOf(Convert.ToInt64(aArgs[j])) else 
                if lPars[j] = typeOf(UnsignedLong) then aArgs[j] := Int64.valueOf(Convert.ToUInt64(aArgs[j])) else 
                if lPars[j] = typeOf(nullable Single) then aArgs[j] := Single.valueOf(Convert.ToSingle(aArgs[j])) else 
                if lPars[j] = typeOf(nullable Double) then aArgs[j] := Double.valueOf(Convert.ToDouble(aArgs[j]));
              end;
            end;
          exit lMeth;
        end;
      end;
      exit nil;
    end;
    
  public
    method GetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    begin
      if aInstance = nil then begin
        if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
        raise new NullPointerException;
      end;
      var lDyn := IDynamicObject(aInstance);
      if lDyn <> nil then begin 
        exit lDyn.GetMember(aName, aGetFlags, aArgs);
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
    
    method SetMember(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    begin
      if aInstance = nil then begin
        if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
        raise new NullPointerException;
      end;
      var lDyn := IDynamicObject(aInstance);
      if lDyn <> nil then begin 
        lDyn.SetMember(aName, aGetFlags, aArgs);
        exit;
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
    
    method Invoke(aInstance: Object; aName: String; aGetFlags: Integer; aArgs: array of Object): Object;
    begin
      var lDyn := IDynamicObject(aInstance);
      if lDyn <> nil then exit lDyn.Invoke(aName, aGetFlags, aArgs);
    
      exit Invoke(GetMember(aInstance, aName, aGetFlags or Integer(DynamicGetFlags.FollowedByCall), nil), aGetFlags, aArgs);
    end;
    
    method Invoke(aInstance: Object;  aGetFlags: Integer; aArgs: array of Object): Object;
    begin
      if aInstance = nil then begin
        if DynamicGetFlags.NilSafe in DynamicGetFlags(aGetFlags) then exit nil;
        if DynamicGetFlags.NilOnBindingFailure in DynamicGetFlags(aGetFlags) then exit nil;
        raise new NullPointerException;
      end;
    
      var lDyn := IDynamicObject(aInstance);
      if lDyn <> nil then exit lDyn.Invoke(nil, aGetFlags, aArgs);
    
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
    
    method Binary(aLeft, aRight: Object; aOp: Integer): Object;
    begin 
      var lVP := new VarParameter<Object>;
      var lVal := IDynamicObject(aLeft);
      if assigned(lVal) and lVal.Binary(aRight, true, DynamicBinaryOperator(aOp), lVP) then exit lVP.Value;
      lVal := IDynamicObject(aRight);
      if assigned(lVal) and lVal.Binary(aLeft, false, DynamicBinaryOperator(aOp), lVP) then exit lVP.Value;
      
      case DynamicBinaryOperator(aOp) of 
        DynamicBinaryOperator.Add: 
          begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) + Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) + Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) + Convert.ToDouble(aRight);
            if (lL = typeOf(String)) or (lR = typeOf(String)) then 
              exit aLeft.toString + aRight.toString;
          end;
        DynamicBinaryOperator.Sub: 
          begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) - Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) - Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) - Convert.ToDouble(aRight);
        end;

        DynamicBinaryOperator.Mul: 
          begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) * Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) * Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) * Convert.ToDouble(aRight);
          end;

        DynamicBinaryOperator.IntDiv,
        DynamicBinaryOperator.Div: 
          begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) / Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) / Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) / Convert.ToDouble(aRight);
          end;

        DynamicBinaryOperator.Mod:           
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) mod Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) mod Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) mod Convert.ToDouble(aRight);
          end;

        DynamicBinaryOperator.Shl: 
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.ToInt64(aLeft) shl Convert.ToInt64(aRight)
              else
                exit Convert.ToUInt64(aLeft) shl Convert.ToUInt64(aRight);
          end;
        DynamicBinaryOperator.Shr: 
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) shr Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) shr Convert.ToUInt64(aRight);
          end;
        DynamicBinaryOperator.And: 
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if (lL = typeOf(java.lang.Boolean)) and (lR = typeOf(java.lang.Boolean)) then 
              exit Boolean(aLeft) and Boolean(aRight);
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.ToInt64(aLeft) and Convert.ToInt64(aRight)
              else
                exit Convert.ToUInt64(aLeft) and Convert.ToUInt64(aRight);
          end;
        DynamicBinaryOperator.Or: 
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if (lL = typeOf(java.lang.Boolean)) and (lR = typeOf(java.lang.Boolean)) then 
              exit Boolean(aLeft) or Boolean(aRight);
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.ToInt64(aLeft) or Convert.ToInt64(aRight)
              else
                exit Convert.ToUInt64(aLeft) or Convert.ToUInt64(aRight);
          end;
        DynamicBinaryOperator.Xor: 
        begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if (lL = typeOf(java.lang.Boolean)) and (lR = typeOf(java.lang.Boolean)) then 
              exit Boolean(aLeft) xor Boolean(aRight);
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.ToInt64(aLeft) xor Convert.ToInt64(aRight)
              else
                exit Convert.ToUInt64(aLeft) xor Convert.ToUInt64(aRight);
          end;
        DynamicBinaryOperator.Less: begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) < Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) < Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) < Convert.ToDouble(aRight);
            if (lL = typeOf(String)) or (lR = typeOf(String)) then 
              exit aLeft.toString < aRight.toString;
        end;
        DynamicBinaryOperator.GreaterEqual: begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) >= Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) >= Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) >= Convert.ToDouble(aRight);
            if (lL = typeOf(String)) or (lR = typeOf(String)) then 
              exit aLeft.toString >= aRight.toString;
        end;
        DynamicBinaryOperator.LessEqual: begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) <= Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) <= Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) <= Convert.ToDouble(aRight);
            if (lL = typeOf(String)) or (lR = typeOf(String)) then 
              exit aLeft.toString <= aRight.toString;
        end;
        DynamicBinaryOperator.Greater: begin 
            if (aLeft = nil) or (aRight = nil) then exit nil;
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) < Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) > Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) > Convert.ToDouble(aRight);
            if (lL = typeOf(String)) or (lR = typeOf(String)) then 
              exit aLeft.toString > aRight.toString;
        end;
        DynamicBinaryOperator.Equal: begin 
            if (aLeft = nil) or (aRight = nil) then exit (aLeft = nil) and (aRight = nil);
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) = Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) = Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) = Convert.ToDouble(aRight);
            if (lL = typeOf(Character)) or (lL = typeOf(String)) or (lR = typeOf(Character)) or (lR = typeOf(String)) then 
              exit aLeft.toString = aRight.toString;
            if (lL = typeOf(java.lang.Boolean)) and (lR = typeOf(java.lang.Boolean)) then 
              exit Boolean(aLeft) = Boolean(aRight);
        end;
        DynamicBinaryOperator.NotEqual: begin 
            if (aLeft = nil) or (aRight = nil) then exit not ((aLeft = nil) and (aRight = nil));
            var lL := aLeft.getClass;
            var lR := aRight.getClass;
            if lL.IsInteger and lR.IsInteger then 
              if lL.IsSigned and lR.IsSigned then 
                exit Convert.Toint64(aLeft) <> Convert.ToInt64(aRight)
              else
                exit Convert.ToUint64(aLeft) <> Convert.ToUInt64(aRight);
            if lL.IsIntegerOrFloat and lR.IsIntegerOrFloat then 
              exit Convert.ToDouble(aLeft) <> Convert.ToDouble(aRight);
            if (lL = typeOf(Character)) or (lL = typeOf(String)) or (lR = typeOf(Character)) or (lR = typeOf(String)) then 
              exit aLeft.toString <> aRight.toString;
            if (lL = typeOf(java.lang.Boolean)) and (lR = typeOf(java.lang.Boolean)) then 
              exit Boolean(aLeft) <> Boolean(aRight);
        end;

      end;
      
      raise new Exception('Binary operator '+aOp+' not supported on these type');
    end;

    method Unary(aLeft: Object; aOp: Integer): Object;
    begin 
      var lVal := IDynamicObject(aLeft);
      var lVD := new VarParameter<Object>;
      if assigned(lVal) and lVal.Unary(DynamicUnaryOperator(aOp), lVD) then exit lVD.Value;
      case DynamicUnaryOperator(aOp) of 
        DynamicUnaryOperator.Not: begin 
          if aLeft = nil then exit nil;
          if aLeft is Boolean then exit not Boolean(aLeft);
          exit not Convert.ToInt64(aOp);
        end;
        DynamicUnaryOperator.Neg: begin 
          if aLeft = nil then exit nil;
          exit - Convert.ToInt64(aOp);
        end;
        DynamicUnaryOperator.Plus: 
          exit aLeft;
      end;
      raise new Exception('Unary operator '+aOp+' not supported on this type');
    end;  
  end;

  DynamicMethodGroup = public class
  private
    fItems: ArrayList<&Method>;
    fInst: Object;
  public
    constructor(aInst: Object; aItems: ArrayList<&Method>);
    begin
      fItems := aItems;
      fInst := aInst;
    end;
    
    property Inst: Object read fInst;
    property Count: Integer read fItems.size;
    property Item[i: Integer]: &Method read fItems[i]; default;
  end;

  Convert = public static class 
  private
  public
    class method ToByte(val: Object): SByte;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).byteValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).byteValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).byteValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).byteValue;

      raise new Exception('Cannot convert type!');
    end;

    class method ToSByte(val: Object): SByte;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).byteValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).byteValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).byteValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).byteValue;

      raise new Exception('Cannot convert type!');
    end;

    class method ToUInt16(val: Object): Int16;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).shortValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).shortValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).shortValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).shortValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToInt16(val: Object): Int16;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).shortValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).shortValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).shortValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).shortValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToUInt32(val: Object): Int32;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).intValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).intValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).intValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).intValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToInt32(val: Object): Int32;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).intValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).intValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).intValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).intValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToUInt64(val: Object): Int64;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).longValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).longValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).longValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).longValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToInt64(val: Object): Int64;
    begin 
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).longValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).longValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).longValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).longValue;

      raise new Exception('Cannot convert type!');      
    end;

    class method ToDouble(val: Object): Double;
    begin
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).longValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).longValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).longValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).longValue;

      if val is Single then exit Single(val);
      if val is Double then exit Double(val);

      raise new Exception('Cannot convert type!');      
    end;

    class method ToSingle(val: Object): Single;
    begin
      if val is nullable SByte then exit SByte(val);
      if val is UnsignedByte then exit UnsignedByte(val).longValue;
      
      if val is nullable Int16 then exit Int16(val);
      if val is UnsignedShort then exit UnsignedShort(val).longValue;

      if val is nullable Integer then exit SByte(val);
      if val is UnsignedInteger then exit UnsignedInteger(val).longValue;

      if val is nullable SByte then exit SByte(val);
      if val is UnsignedLong then exit UnsignedLong(val).longValue;

      if val is Single then exit Single(val);
      if val is Double then exit Double(val);

      raise new Exception('Cannot convert type!');      
    end;
  end;


end.
