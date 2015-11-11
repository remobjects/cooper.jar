namespace com.remobjects.elements.system;

interface
uses
  java.util.concurrent;

type
  FutureAnnnotation = public interface(java.lang.annotation.Annotation)
  end;

  // Action = java.lang.Runnable;
  // Func<T> = java.util.concurrent.Callable<T>
  FutureHelper = public static class
  private

  public 
    class method IsDone<T>(aFuture: Callable<T>): Boolean; 
    class method Execute<T>(aFuture: Callable<T>): Callable<T>; 
    class method ExecuteAsync<T>(aMethod: Callable<T>; aWantResult: Boolean): Callable<T>; 
    class method IsDone(aFuture: Runnable): Boolean; 
    class method Execute(aMethod: Runnable): Runnable; 
    class method ExecuteAsync(aMethod:  Runnable; aWantResult: Boolean): Runnable; 

    class property Threadpool: ExecutorService; readonly;
    class constructor;
  end;

  ThreadpoolFactory nested in FutureHelper = class(ThreadFactory)
  private
  public
    method newThread(arg: Runnable): Thread;
  end;


  CallableFutureTask<T> = public class(FutureTask<T>, Callable<T>)
  private
  public
    method call: T;
  end;

implementation

class method FutureHelper.IsDone<T>(aFuture: Callable<T>): Boolean;
begin
  exit FutureTask<T>(aFuture).isDone;
end;

class method FutureHelper.Execute<T>(aFuture: Callable<T>): Callable<T>;
begin
  exit new CallableFutureTask<T>(aFuture);
end;

class method FutureHelper.ExecuteAsync<T>(aMethod: Callable<T>; aWantResult: Boolean): Callable<T>;
begin
  var lTask := new CallableFutureTask<T>(aMethod);
  Threadpool.execute(lTask);
  exit lTask;
end;

class method FutureHelper.IsDone(aFuture: Runnable): Boolean;
begin
  exit FutureTask(aFuture).isDone;
end;

class method FutureHelper.Execute(aMethod: Runnable): Runnable;
begin
  exit new FutureTask(aMethod, nil);
end;

class method FutureHelper.ExecuteAsync(aMethod: Runnable; aWantResult: Boolean): Runnable;
begin
  var lTask := new FutureTask(aMethod, nil);
  Threadpool.execute(lTask);
  exit lTask; 
end;

class constructor FutureHelper;
begin
  Threadpool := Executors.newCachedThreadPool(new ThreadpoolFactory);
end;

method CallableFutureTask<T>.call: T;
begin
  self.run();
  exit self.get();
end;

method FutureHelper.ThreadpoolFactory.newThread(arg: Runnable): Thread;
begin
  result := new Thread(arg);
  result.Daemon := true;
end;


end.
