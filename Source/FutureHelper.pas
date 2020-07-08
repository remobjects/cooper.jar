namespace remobjects.elements.system;

interface
uses
  java.util.concurrent;

type
  FutureAnnnotation = public interface(java.lang.annotation.Annotation)
  end;

  // Action = java.lang.Runnable;
  // Func<T> = java.util.concurrent.Callable<T>
  FutureHelper = public static class
  public
    class method IsDone<T>(aFuture: Task1<T>): Boolean;
    class method Execute<T>(aFuture: Callable<T>): Task1<T>;
    class method ExecuteAsync<T>(aMethod: Callable<T>; aWantResult: Boolean): Task1<T>;
    class method IsDone(aFuture: Task): Boolean;
    class method Execute(aMethod: Runnable): Task;
    class method ExecuteAsync(aMethod:  Runnable; aWantResult: Boolean): Task;
  end;

  NonThreadedTask = public class(Task)
  private
  public
    method Start(aScheduler: Executor); override;
    method Wait(aTimeoutMSec: Integer): Boolean; override;
    method Wait; override;
  end;

  NonThreadedTask1<T> = public class(Task1<T>)
  private
  public
  end;

implementation

class method FutureHelper.IsDone<T>(aFuture: Task1<T>): Boolean;
begin
  exit aFuture.IsCompleted;
end;

class method FutureHelper.Execute<T>(aFuture: Callable<T>): Task1<T>;
begin
  result := new NonThreadedTask1<T>(aFuture);
  result.Start;
end;

class method FutureHelper.ExecuteAsync<T>(aMethod: Callable<T>; aWantResult: Boolean): Task1<T>;
begin
  result := new Task1<T>(aMethod);
  result.Start;
end;

class method FutureHelper.IsDone(aFuture: Task): Boolean;
begin
  exit aFuture.IsCompleted;
end;

class method FutureHelper.Execute(aMethod: Runnable): Task;
begin
  result := new NonThreadedTask(aMethod);
  result.Start;
end;

class method FutureHelper.ExecuteAsync(aMethod: Runnable; aWantResult: Boolean): Task;
begin
  result := new Task(aMethod);
  result.Start;
end;

method NonThreadedTask.Wait(aTimeoutMSec: Integer): Boolean;
begin
  var lRun := false;
  locking self do begin
    if fState = TaskState.Queued then begin
      fState := TaskState.Started;
      lRun := true;
    end;
  end;
  if lRun then run;
  exit inherited;
end;

method NonThreadedTask.Wait;
begin
  var lRun := false;
  locking self do begin
    if fState = TaskState.Queued then begin
      fState := TaskState.Started;
      lRun := true;
    end;
  end;
  if lRun then run;
  inherited;
end;

method NonThreadedTask.Start(aScheduler: Executor);
begin
  locking fLock do begin
    if fState <> TaskState.Created then raise new IllegalStateException('Task already started/queued/done');
    fState := TaskState.Queued;
  end;
end;

end.