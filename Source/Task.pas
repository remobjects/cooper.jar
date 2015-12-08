namespace com.remobjects.elements.system;

interface

uses
  java.util.concurrent,
  java.util;

type
  TaskState = enum(Created, Queued, Started, Done) of Integer;
  Task = public class(Runnable)
  assembly
    fState: TaskState;
    fException: Throwable;
    fAsyncState: Object; 
    fDelegate: Object; // callable<T>; runnable
    fDoneHandlers: Object; // nil, arraylist or task
    fLock: Object := new Object;
    method Done(ex: Throwable); 
    method AddOrRunContinueWith(aTask: Task);
    constructor(aDelegate: Object; aState: Object);
  public
    method run; virtual;
    constructor(aIn: Runnable; aState: Object := nil);

    method ContinueWith(aAction: com.remobjects.elements.system.Action1<Task>; aState: Object := nil): Task;
    method ContinueWith<T>(aAction: com.remobjects.elements.system.Func2<Task, T>; aState: Object := nil): Task1<T>;

    class method Run(aIn: Runnable): Task;
    class method Run<T>(aIn: Callable<T>): Task1<T>;

    property Exception: Throwable read fException;
    property AsyncState: Object read fAsyncState;
    property IsFaulted: Boolean read fException <> nil;
    property IsCompleted: Boolean read fState = TaskState.Done; 
    method &Await(aCompletion: IAwaitCompletion): Boolean; // true = yield; false = long done

    {$HIDE W38}
    method Wait; reintroduce;virtual;
    {$SHOW W38}
    method Wait(aTimeoutMSec: Integer): Boolean; virtual;

    method Start(aScheduler: Executor := nil); virtual;

    class constructor;
    class property Threadpool: ExecutorService; readonly;
    class property ThreadSyncHelper: IThreadSyncHelper;
  end;

  Task1<T> = public class(Task)
  assembly
    fResult: T;
    method getResult: T;
    constructor(aDelegate: Object; aState: Object); empty;
  public
    constructor(aIn: Callable<T>; aState: Object := nil);
    method ContinueWith(aAction: com.remobjects.elements.system.Action1<Task1<T>>; aState: Object := nil): Task;
    method ContinueWith<TR>(aAction: com.remobjects.elements.system.Func2<Task1<T>, TR>; aState: Object := nil): Task1<TR>;
    method run; override;
    property &Result: T read getResult;
  end;
  
  TaskCompletionSource<T> = public class
  private 
    fTask: Task1<T>;
  public
    constructor(aState: Object := nil);

    method SetException(ex: Throwable);
    method SetResult(val: T);

    property Task: Task1<T> read fTask;
  end;

  IAwaitCompletion = public interface
    method moveNext(aState: Object);
  end;

  IThreadSyncHelper = public interface
    method GetThreadContext: Object;
    method SyncBack(aContext: Object; aAction: Runnable);
  end;

  AndroidThreadSyncHelper = public class(IThreadSyncHelper)
  private
    fHandlerPost, fMyLooper: java.lang.reflect.&Method;
    fHandlerCtor: java.lang.reflect.Constructor;
  public
    constructor;
    method SyncBack(aContext: Object; aAction: Runnable);
    method GetThreadContext: Object;
  end;

  AWTThreadSyncHelper = public class(IThreadSyncHelper)
  private
    fisDispatchThread, finvokeLater: java.lang.reflect.&Method;
    fType: &Class;
  public
    constructor;
    method SyncBack(aContext: Object; aAction: Runnable);
    method GetThreadContext: Object;
  end;

  TaskCompletionSourceTask<T> = class(Task1<T>)
  assembly
  public
    method run; override; empty;
  end;

  ThreadpoolFactory nested in Task = class(ThreadFactory)
  private
  public
    method newThread(arg: Runnable): Thread;
  end;


implementation

constructor Task(aDelegate: Object; aState: Object);
begin
  fDelegate := aDelegate;
  fAsyncState := aState;
end;

constructor Task(aIn: Runnable; aState: Object);
begin
  if aIn = nil then raise new IllegalArgumentException('aIn');
  constructor(Object(aIn), aState);
end;

method Task.run;
begin
  locking fLock do
    fState := TaskState.Started;
  try
    Runnable(fDelegate)();
    Done(nil);
  except
    on ex: Throwable do
     Done(ex);
  end;
end;

method Task.Done(ex: Throwable);
begin
  fException := ex;
  var lCW: Object;
  locking fLock do begin
    fState := TaskState.Done;
    lCW := fDoneHandlers;
    fDoneHandlers := nil;
    fLock.notifyAll;
  end;
  if lCW <> nil then begin
    var lTask := Task(lCW);
    if lTask <> nil then begin
      lTask.run;
    end else begin
      var lList := ArrayList<Task>(lCW);
      for i: Integer := 0 to lList.size -1 do
        lList[i].run;
    end;
  end;
end;

method Task.ContinueWith(aAction: com.remobjects.elements.system.Action1<Task>; aState: Object): Task;
begin
  result := new Task(-> aAction(self), aState);
  result.fState := TaskState.Queued;

  AddOrRunContinueWith(result);
end;

method Task.ContinueWith<T>(aAction: com.remobjects.elements.system.Func2<Task,T>; aState: Object): Task1<T>;
begin
  var r: Callable<T> := -> aAction(self);
  result := new Task1(r, aState);
  result.fState := TaskState.Queued;

  AddOrRunContinueWith(result);
end;

method Task.AddOrRunContinueWith(aTask: Task);
begin
  var lDone := false;
  if fState = TaskState.Done then lDone := true
  else locking self do begin
    if fState = TaskState.Done then lDone := true
    else begin
      if fDoneHandlers = nil then fDoneHandlers := aTask
      else begin
        var lNew := new ArrayList();
        lNew.add(fDoneHandlers);
        lNew.add(aTask);
        fDoneHandlers := lNew;
      end;
    end;
  end;
  if lDone then begin
    aTask.run;
  end;
end;

method Task.Wait;
begin
  if fState = TaskState.Done then exit;
  locking fLock do begin
    if fState = TaskState.Done then exit;
    while fState <> TaskState.Done do begin
      fLock.wait()
    end;
  end;
end;

method Task.Wait(aTimeoutMSec: Integer): Boolean;
begin
  if fState = TaskState.Done then exit true;
  locking fLock do begin
    if fState = TaskState.Done then exit true;
    var lTO := System.currentTimeMillis + aTimeoutMSec;
    while fState <> TaskState.Done do begin
      var lMS := lTO - System.currentTimeMillis;
      if lMS <= 0 then exit false;
      fLock.wait(lMS);
    end;
    exit true;
  end;
end;

method Task.Start(aScheduler: Executor);
begin
  locking fLock do begin
    if fState <> TaskState.Created then raise new IllegalStateException('Task already started/queued/done');
    fState := TaskState.Queued;
  end;
  coalesce(aScheduler, Executor(Threadpool)).execute(self);
end;

class method Task.Run(aIn: Runnable): Task;
begin
  result := new Task(aIn);
  result.Start;
end;

class method Task.Run<T>(aIn: Callable<T>): Task1<T>;
begin
  result := new Task1<T>(aIn);
  result.Start;
end;

method Task1<T>.getResult: T;
begin
  Wait();
  if fException <> nil then 
    raise fException;
  exit fResult;
end;

method Task1<T>.run;
begin
  locking fLock do
    fState := TaskState.Started;
  try
    fResult := Callable<T>(fDelegate)();
    Done(nil);
  except
    on ex: Throwable do
     Done(ex);
  end;
end;

constructor Task1<T>(aIn: Callable<T>; aState: Object);
begin
  if aIn = nil then raise new IllegalArgumentException('aIn');
  inherited constructor(aIn, aState);
end;

method Task1<T>.ContinueWith(aAction: Action1<Task1<T>>; aState: Object): Task;
begin
  result := new Task(-> aAction(self), aState);
  result.fState := TaskState.Queued;

  AddOrRunContinueWith(result);
end;

method Task1<T>.ContinueWith<TR>(aAction: Func2<Task1<T>,TR>; aState: Object): Task1<TR>;
begin
  var r: Callable<T> := -> aAction(self);
  result := new Task1(r, aState);
  result.fState := TaskState.Queued;

  AddOrRunContinueWith(result);
end;



constructor TaskCompletionSource<T>(aState: Object);
begin
  fTask := new TaskCompletionSourceTask<T>(Object(nil), aState);
  fTask.fState := TaskState.Started; 
end;

method TaskCompletionSource<T>.SetException(ex: Throwable);
begin
  locking fTask.fLock do begin
    if fTask.fState = TaskState.Done then raise new IllegalStateException('Task already done');
    fTask.fException := ex;
    fTask.fState := TaskState.Done;
  end;
  fTask.Done(ex);
end;

method TaskCompletionSource<T>.SetResult(val: T);
begin
  locking fTask.fLock do begin
    if fTask.fState = TaskState.Done then raise new IllegalStateException('Task already done');
    fTask.fResult := val;
    fTask.fState := TaskState.Done;
  end;
  fTask.Done(nil);
end;

method Task.Await(aCompletion: IAwaitCompletion): Boolean;
begin
  if IsCompleted then exit false;
  var tc := ThreadSyncHelper.GetThreadContext();
  if tc = nil then begin
    ContinueWith(a -> aCompletion.moveNext(a), nil);
  end else begin
    ContinueWith(a -> begin 
      ThreadSyncHelper.SyncBack(tc, -> aCompletion(a));
    end);
  end;

  exit true;
end;

class constructor Task;
begin
  Threadpool := Executors.newCachedThreadPool(new ThreadpoolFactory);
  try
    &Class.forName("android.app.Activity");
    ThreadSyncHelper := new AndroidThreadSyncHelper;
  except
    ThreadSyncHelper := new AWTThreadSyncHelper;
  end;
end;

method AWTThreadSyncHelper.SyncBack(aContext: Object; aAction: Runnable);
begin
  finvokeLater.invoke(aAction);
end;

method AWTThreadSyncHelper.GetThreadContext: Object;
begin
  if Boolean(fisDispatchThread.invoke(nil)) then exit self;
  exit nil; // AWT has no looper concept
end;

constructor AWTThreadSyncHelper;
begin
  fType := typeOf(AWTThreadSyncHelper).ClassLoader.loadClass('java.awt.EventQueue');
  fisDispatchThread := fType.getMethod('isDispatchThread');
  finvokeLater := fType.getMethod('invokeLater', typeOf(Runnable));
end;

constructor AndroidThreadSyncHelper;
begin
  var lType := typeOf(AndroidThreadSyncHelper).ClassLoader.loadClass('android.os.Looper');
  fMyLooper := lType.getMethod('myLooper');
  var lType2 := typeOf(AndroidThreadSyncHelper).ClassLoader.loadClass('android.os.Handler');
  fHandlerCtor := lType2.getConstructor(lType);
  fHandlerPost := lType2.getMethod('post', typeOf(Runnable));
end;

method AndroidThreadSyncHelper.SyncBack(aContext: Object; aAction: Runnable);
begin
  fHandlerPost.invoke(fHandlerCtor.newInstance(aContext), aAction);
end;

method AndroidThreadSyncHelper.GetThreadContext: Object;
begin
  exit fMyLooper.invoke(nil);
end;


method Task.ThreadpoolFactory.newThread(arg: Runnable): Thread;
begin
  result := new Thread(arg);
  result.Daemon := true;
end;
end.
