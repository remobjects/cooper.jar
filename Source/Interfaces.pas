﻿namespace RemObjects.Elements.System;

interface

type
  IEquatable<T> = public interface
    method Equals(rhs: T): Boolean;
  end;

  IComparable< {in} T> = public interface mapped to Comparable<T>
    method CompareTo(rhs: T): Integer; mapped to compareTo(rhs);
  end;

  IDisposable = public interface mapped to AutoCloseable
    method Dispose; mapped to close;
  end;

  INotifyPropertyChanged = public interface
    {$IF NOT JAVA17UP}
    method addPropertyChangeListener(listener: java.beans.PropertyChangeListener);
    method removePropertyChangeListener(listener: java.beans.PropertyChangeListener);
    {$ENDIF}
    method firePropertyChange(name: String; oldValue: Object; newValue: Object);
  end;

implementation

end.