namespace com.remobjects.elements.system;

interface

type
  IEquatable<T> = public interface
    method Equals(rhs: T): Boolean;
  end;

  IComparable< {in} T> = public interface mapped to Comparable<T>
    method CompareTo(rhs: T): Integer; mapped to compareTo(rhs);
  end;

implementation

end.
