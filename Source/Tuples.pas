namespace RemObjects.Elements.System;

interface

uses
  java.util;

type
  Tuple1<T1> = public class
  public
    constructor(aItem1: T1);
    property Item1: T1; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple2<T1, T2> = public class
  public
    constructor(aItem1: T1; aItem2: T2);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple3<T1, T2, T3> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple4<T1, T2, T3, T4> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    property Item4: T4; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple5<T1, T2, T3, T4, T5> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    property Item4: T4; readonly;
    property Item5: T5; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple6<T1, T2, T3, T4, T5, T6> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    property Item4: T4; readonly;
    property Item5: T5; readonly;
    property Item6: T6; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple7<T1, T2, T3, T4, T5, T6, T7> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    property Item4: T4; readonly;
    property Item5: T5; readonly;
    property Item6: T6; readonly;
    property Item7: T7; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple8<T1, T2, T3, T4, T5, T6, T7, T8> = public class
  public
    constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8);
    property Item1: T1; readonly;
    property Item2: T2; readonly;
    property Item3: T3; readonly;
    property Item4: T4; readonly;
    property Item5: T5; readonly;
    property Item6: T6; readonly;
    property Item7: T7; readonly;
    property Item8: T8; readonly;
    method hashCode: Integer; override;
    method &equals(arg1: Object): Boolean; override;
  end;

  Tuple = public static class
  assembly
    class method R3(i: Integer): Integer;
  public
     class method &New<T1>(aItem1: T1): Tuple1<T1>;
     class method &New<T1, T2>(aItem1: T1; aItem2: T2): Tuple2<T1, T2>;
     class method &New<T1, T2, T3>(aItem1: T1; aItem2: T2; aItem3: T3): Tuple3<T1, T2, T3>;
     class method &New<T1, T2, T3, T4>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4): Tuple4<T1, T2, T3, T4>;
     class method &New<T1, T2, T3, T4, T5>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5): Tuple5<T1, T2, T3, T4, T5>;
     class method &New<T1, T2, T3, T4, T5, T6>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6): Tuple6<T1, T2, T3, T4, T5, T6>;
     class method &New<T1, T2, T3, T4, T5, T6, T7>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7): Tuple7<T1, T2, T3, T4, T5, T6, T7>;
     class method &New<T1, T2, T3, T4, T5, T6, T7, T8>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8): Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>;
  end;


implementation


constructor Tuple1<T1>(aItem1: T1);
begin
  Item1 := aItem1;
end;

method Tuple1<T1>.hashCode: Integer;
begin
  if Item1 = nil then exit 0;
  exit Item1.hashCode;
end;

method Tuple1<T1>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple1(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1);
end;

constructor Tuple2<T1, T2>(aItem1: T1; aItem2: T2);
begin
  Item1 := aItem1;
  Item2 := aItem2;
end;

method Tuple2<T1, T2>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
end;

method Tuple2<T1, T2>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple2(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2);
end;

constructor Tuple3<T1, T2, T3>(aItem1: T1; aItem2: T2; aItem3: T3);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
end;


method Tuple3<T1, T2, T3>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
end;

method Tuple3<T1, T2, T3>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple3(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3);
end;


constructor Tuple4<T1, T2, T3, T4>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
  Item4 := aItem4;
end;


method Tuple4<T1, T2, T3, T4>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
  if Item4 <> nil then result := Tuple.R3(result) xor Item4.hashCode;
end;

method Tuple4<T1, T2, T3, T4>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple4(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3) and lTuple.Item4.equals(Item4);
end;

constructor Tuple5<T1, T2, T3, T4, T5>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
  Item4 := aItem4;
  Item5 := aItem5;
end;

method Tuple5<T1, T2, T3, T4, T5>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
  if Item4 <> nil then result := Tuple.R3(result) xor Item4.hashCode;
  if Item5 <> nil then result := Tuple.R3(result) xor Item5.hashCode;
end;

method Tuple5<T1, T2, T3, T4, T5>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple5(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3) and lTuple.Item4.equals(Item4) and lTuple.Item5.equals(Item5);
end;

constructor Tuple6<T1, T2, T3, T4, T5, T6>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
  Item4 := aItem4;
  Item5 := aItem5;
  Item6 := aItem6;
end;

method Tuple6<T1, T2, T3, T4, T5, T6>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
  if Item4 <> nil then result := Tuple.R3(result) xor Item4.hashCode;
  if Item5 <> nil then result := Tuple.R3(result) xor Item5.hashCode;
  if Item6 <> nil then result := Tuple.R3(result) xor Item6.hashCode;
end;

method Tuple6<T1, T2, T3, T4, T5, T6>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple6(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3) and lTuple.Item4.equals(Item4) and lTuple.Item5.equals(Item5)
    and lTuple.Item6.equals(Item6);
end;


constructor Tuple7<T1, T2, T3, T4, T5, T6, T7>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
  Item4 := aItem4;
  Item5 := aItem5;
  Item6 := aItem6;
  Item7 := aItem7;
end;

method Tuple7<T1, T2, T3, T4, T5, T6, T7>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
  if Item4 <> nil then result := Tuple.R3(result) xor Item4.hashCode;
  if Item5 <> nil then result := Tuple.R3(result) xor Item5.hashCode;
  if Item6 <> nil then result := Tuple.R3(result) xor Item6.hashCode;
  if Item7 <> nil then result := Tuple.R3(result) xor Item7.hashCode;
end;

method Tuple7<T1, T2, T3, T4, T5, T6, T7>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple7(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3) and lTuple.Item4.equals(Item4) and lTuple.Item5.equals(Item5)
    and lTuple.Item6.equals(Item6) and lTuple.Item7.equals(Item7);
end;

constructor Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8);
begin
  Item1 := aItem1;
  Item2 := aItem2;
  Item3 := aItem3;
  Item4 := aItem4;
  Item5 := aItem5;
  Item6 := aItem6;
  Item7 := aItem7;
  Item8 := aItem8;
end;

method Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.hashCode: Integer;
begin
  result := 0;
  if Item1 <> nil then result := Tuple.R3(result) xor Item1.hashCode;
  if Item2 <> nil then result := Tuple.R3(result) xor Item2.hashCode;
  if Item3 <> nil then result := Tuple.R3(result) xor Item3.hashCode;
  if Item4 <> nil then result := Tuple.R3(result) xor Item4.hashCode;
  if Item5 <> nil then result := Tuple.R3(result) xor Item5.hashCode;
  if Item6 <> nil then result := Tuple.R3(result) xor Item6.hashCode;
  if Item7 <> nil then result := Tuple.R3(result) xor Item7.hashCode;
  if Item8 <> nil then result := Tuple.R3(result) xor Item8.hashCode;
end;

method Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.&equals(arg1: Object): Boolean;
begin
  var lTuple := Tuple8(arg1);
  exit assigned(lTuple) and lTuple.Item1.equals(Item1) and lTuple.Item2.equals(Item2) and lTuple.Item3.equals(Item3) and lTuple.Item4.equals(Item4) and lTuple.Item5.equals(Item5)
    and lTuple.Item6.equals(Item6) and lTuple.Item7.equals(Item7) and lTuple.Item8.equals(Item8);
end;

class method Tuple.&New<T1>(aItem1: T1): Tuple1<T1>;
begin
  exit new Tuple1<T1>(aItem1);
end;

class method Tuple.&New<T1,T2>(aItem1: T1; aItem2: T2): Tuple2<T1, T2>;
begin
  exit new Tuple2<T1, T2>(aItem1, aItem2);
end;

class method Tuple.&New<T1,T2,T3>(aItem1: T1; aItem2: T2; aItem3: T3): Tuple3<T1, T2, T3>;
begin
  exit new Tuple3<T1, T2, T3>(aItem1, aItem2, aItem3);
end;

class method Tuple.&New<T1,T2,T3,T4>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4): Tuple4<T1, T2, T3, T4>;
begin
  exit new Tuple4<T1, T2, T3, T4>(aItem1, aItem2, aItem3, aItem4);
end;

class method Tuple.&New<T1,T2,T3,T4,T5>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5): Tuple5<T1, T2, T3, T4, T5>;
begin
  exit new Tuple5<T1, T2, T3, T4, T5>(aItem1, aItem2, aItem3, aItem4, aItem5);
end;

class method Tuple.&New<T1,T2,T3,T4,T5,T6>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6): Tuple6<T1, T2, T3, T4, T5, T6>;
begin
  exit new Tuple6<T1, T2, T3, T4, T5,T6>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6);
end;

class method Tuple.&New<T1,T2,T3,T4,T5,T6,T7>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7): Tuple7<T1, T2, T3, T4, T5, T6, T7>;
begin
  exit new Tuple7<T1, T2, T3, T4, T5,T6, T7>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6, aItem7);
end;

class method Tuple.&New<T1,T2,T3,T4,T5,T6,T7,T8>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8): Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>;
begin
  exit new Tuple8<T1, T2, T3, T4, T5,T6, T7, T8>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6, aItem7, aItem8);
end;

class method &Tuple.R3(i: Integer): Integer;
begin
  exit (i shl 29) or (unsignedShr(i, 3));
end;

end.