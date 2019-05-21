namespace com.remobjects.elements.linq;

interface
uses
  java.util;

type
  Predicate<T> = public delegate (aItem: T): Boolean;
  &Selector<T, R> = public delegate (aItem: T): R;
  Comparer<T> = public delegate(aItem1, aItem2: T): Integer;
  ForSelector<T> = public delegate(aIndex: Integer): T;

extension method sequence of T.Where<T>(aBlock: Predicate<T>): sequence of T; iterator;
extension method sequence of T.Any<T>(aBlock: Predicate<T>): Boolean;
extension method sequence of T.Take<T>(aCount: Integer): sequence of T; iterator;
extension method sequence of T.Skip<T>(aCount: Integer): sequence of T; iterator;
extension method sequence of T.TakeWhile<T>(aBlock: Predicate<T>): sequence of T; iterator;
extension method sequence of T.SkipWhile<T>(aBlock: Predicate<T>): sequence of T; iterator;
extension method sequence of T.Select<T, R>(aBlock: &Selector<T, R>): sequence of R; iterator;

extension method sequence of T.Concat<T>(aSecond: sequence of T): sequence of T; iterator;
extension method sequence of T.Reverse<T>: sequence of T;
extension method sequence of T.Cast<T, U>: sequence of U; iterator;

extension method sequence of T.FirstOrDefault<T>: T;
extension method sequence of T.Count<T>: Integer;
extension method sequence of T.Any<T>: Boolean;

extension method sequence of T.ToArray<T>: array of T; inline; // must be inline
extension method sequence of T.ToList<T>: ArrayList<T>;
extension method sequence of T.ToDictionary<T, K, V>(aKeyBlock: &Selector<T, K>; aValueBlock: &Selector<K, V>): Hashtable<K, V>;

extension method sequence of T.OrderBy<T, C>(aBlock: &Selector<T, C>): sequence of T; where C is Comparable<T>;
extension method sequence of T.OrderByDescending<T, C>(aBlock: &Selector<T, C>): sequence of T;  where C is Comparable<T>;


extension method sequence of T.Distinct<T>(aComparator: Comparer<T> := nil): sequence of T;
extension method sequence of T.Intersect<T>(aSecond: sequence of T; aComparator: Comparer<T> := nil): sequence of T;  iterator;
extension method sequence of T.Except<T>(aSecond: sequence of T; aComparator: Comparer<T> := nil): sequence of T;  iterator;

extension method List<T>.Contains<T>(aElement: T; aComparator: Comparer<T>): Boolean;
extension method sequence of T.Contains<T>(aElement: T): Boolean;

type
  Helpers = public static class
  public
    class method ForHelper<T>(aStart, aEnd, aStep: Integer; aBackward: Boolean; aMethod: ForSelector<T>): sequence of T; iterator;
  end;


implementation

extension method sequence of T.Where<T>(aBlock: Predicate<T>): sequence of T;
begin
  for each el in self do
    if aBlock(el) then
      yield el;
end;

extension method sequence of T.Any<T>(aBlock: Predicate<T>): Boolean;
begin
  for each el in self do
    if aBlock(el) then
      exit true;
end;

extension method sequence of T.Take<T>(aCount: Integer): sequence of T;
begin
  if aCount > 0 then begin
    for each el in self do begin
      yield el;
      dec(aCount);
      if aCount <= 0 then break;
    end;
  end;
end;

extension method sequence of T.Skip<T>(aCount: Integer): sequence of T;
begin
  for each el in self do begin
    if aCount > 0 then
      dec(aCount)
    else
      yield el;
  end;
end;

extension method sequence of T.TakeWhile<T>(aBlock: Predicate<T>): sequence of T;
begin
  for each el in self do begin
    if not aBlock(el) then break;
    yield el;
  end;
end;

extension method sequence of T.SkipWhile<T>(aBlock: Predicate<T>): sequence of T;
begin
  var lFound := true;
  for each el in self do begin
    if not lFound and not aBlock(el) then
      lFound := true;
    if lFound then
      yield el;
  end;
end;


extension method sequence of T.Select<T, R>(aBlock: &Selector<T, R>): sequence of R;
begin
  for each el in self do
    yield aBlock(el);
end;

extension method sequence of T.Concat<T>(aSecond: sequence of T): sequence of T;
begin
  for each el in self do yield el;
  for each el in aSecond do yield el;
end;

extension method sequence of T.Reverse<T>: sequence of T;
begin
  var lList := self.ToList();
  Collections.reverse(lList);
  exit lList;
end;

extension method sequence of T.Cast<T, U>: sequence of U;
begin
  for each el in self do yield el as U;
end;

extension method sequence of T.FirstOrDefault<T>: T;
begin
  var lItem := &iterator;
  if lItem.hasNext then
    exit lItem.next;
  exit nil;
end;

extension method sequence of T.Any<T>: Boolean;
begin
  var lItem := &iterator;
  result := lItem.hasNext;
end;

extension method sequence of T.Count<T>: Integer;
begin
  if self is List then
    exit List(self).size();
  result := 0;
  for each el in self do
    inc(result);
end;

extension method sequence of T.ToArray<T>: array of T;
begin
  var lList := self.ToList();
  result := new T[lList.Count];
  result := lList.toArray(result);
end;

extension method sequence of T.ToList<T>: ArrayList<T>;
begin
  result := new ArrayList<T>();
  for each el in self do
    result.add(el);
end;

extension method sequence of T.ToDictionary<T, K, V>(aKeyBlock: &Selector<T, K>; aValueBlock: &Selector<K, V>): Hashtable<K, V>;
begin
  result := new Hashtable<K, V>();
  for each el in self do
    result.put(aKeyBlock(el), aValueBlock(el));
end;

extension method sequence of T.OrderBy<T, C>(aBlock: &Selector<T, C>): sequence of T;
begin
  var lList := self.ToList();
  Collections.sort(lList, new interface Comparator<T>(
      compare := (a, b) -> aBlock(a).compareTo(aBlock(b))
    ));

  exit lList;
end;

extension method sequence of T.OrderByDescending<T, C>(aBlock: &Selector<T, C>): sequence of T;
begin
  var lList := self.ToList();
  Collections.sort(lList, new interface Comparator<T>(
      compare := (a, b) -> 0 - aBlock(a).compareTo(aBlock(b))
    ));

  exit lList;
end;

extension method sequence of T.Distinct<T>(aComparator: Comparer<T> := nil): sequence of T;
begin
  var lHS := new ArrayList<T>;

  if aComparator = nil then begin
    for each el in self do begin
      if not lHS.contains(el) then
        lHS.add(el);
    end;
  end else begin
    for each el in self do begin
      var lFound := false;
      if lHS.Contains(el, aComparator) then
        lFound := true;
      if not lFound then
        lHS.add(el);
    end;
  end;

  exit lHS;
end;

extension method sequence of T.Intersect<T>(aSecond: sequence of T; aComparator: Comparer<T> := nil): sequence of T;
begin
  var lSecond := aSecond.ToList();
  for each i in self do
    if lSecond.Contains(i, aComparator) then
      yield i;
end;

extension method sequence of T.Except<T>(aSecond: sequence of T; aComparator: Comparer<T> := nil): sequence of T;
begin
  var lFirst := self.ToList();
  var lSecond := aSecond.ToList();
  for each i in lFirst do
    if not lSecond.Contains(i, aComparator) then
      yield i;
  for each i in lSecond do
    if not lFirst.Contains(i, aComparator) then
      yield i;
end;

extension method List<T>.Contains<T>(aElement: T; aComparator: Comparer<T>): Boolean;
begin
  if aComparator = nil then
    exit self.contains(aElement);
  for j: Integer := 0 to Count -1 do begin
    if 0 = aComparator(self[j], aElement) then
      exit true;
  end;
  exit false;
end;

extension method sequence of T.Contains<T>(aElement: T): Boolean;
begin
  if self is java.util.ArrayList<T> then
    exit (self as java.util.ArrayList<T>).contains(aElement);
  for each i in self do begin
    if (i = nil) then begin
      if (aElement = nil) then exit true;
    end
    else begin
      if i.equals(aElement) then exit true;
    end;
  end;
end;

class method Helpers.ForHelper<T>(aStart: Integer; aEnd: Integer; aStep: Integer; aBackward: Boolean; aMethod: ForSelector<T>): sequence of T;
begin
  if aBackward then
    for i: Integer := aStart downto aEnd step aStep do
      yield aMethod(i)
  else
    for i: Integer := aStart to aEnd step aStep do
      yield aMethod(i)
end;

end.