namespace com.remobjects.elements.system;

interface

type
  Action = public interface
    method run;
  end;
  Action1<T1> = public interface 
    method run(par1: T1);
  end;
  Action2<T1, T2> = public interface 
    method run(par1: T1; par2: T2);
  end;
  Action3<T1, T2, T3> = public interface 
    method run(par1: T1; par2: T2; par3: T3);
  end;
  Action4<T1, T2, T3, T4> = public interface 
    method run(par1: T1; par2: T2; par3: T3; par4: T4);
  end;
  Action5<T1, T2, T3, T4, T5> = public interface 
    method run(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5);
  end;
  Action6<T1, T2, T3, T4, T5, T6> = public interface 
    method run(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6);
  end;
  Action7<T1, T2, T3, T4, T5, T6, T7> = public interface 
    method run(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6; par7: T7);
  end;
  Action8<T1, T2, T3, T4, T5, T6, T7, T8> = public interface 
    method run(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6; par7: T7; par8: T8);
  end;
  Func1<R> = public interface
    method call: R;
  end;
  Func2<T1, R> = public interface 
    method call(par1: T1): R;
  end;
  Func3<T1, T2, R> = public interface 
    method call(par1: T1; par2: T2): R;
  end;
  Func4<T1, T2, T3, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3): R;
  end;
  Func5<T1, T2, T3, T4, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3; par4: T4): R;
  end;
  Func6<T1, T2, T3, T4, T5, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5): R;
  end;
  Func7<T1, T2, T3, T4, T5, T6, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6): R;
  end;
  Func8<T1, T2, T3, T4, T5, T6, T7, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6; par7: T7): R;
  end;
  Func9<T1, T2, T3, T4, T5, T6, T7, T8, R> = public interface 
    method call(par1: T1; par2: T2; par3: T3; par4: T4; par5: T5; par6: T6; par7: T7; par8: T8): R;
  end;

implementation

end.
