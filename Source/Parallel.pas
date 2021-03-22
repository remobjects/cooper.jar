namespace RemObjects.Elements.System;

uses
  java.util,
  java.util.concurrent.atomic;

type
  ParallelLoopState = public class
  private
  public
    property IsStopped: Boolean read private write;
    method &Break;
    begin
      if not IsStopped then IsStopped := True;
    end;
  end;


  &Parallel = static public class
  public
    class method &For(fromInclusive: Integer; toExclusive: Integer; body: Action2<Integer,ParallelLoopState>);
    begin
      var lthreadcnt := Runtime.getRuntime().availableProcessors();
      var lcurrTasks := new AtomicInteger();
      var levent := new Object;
      var ls:= new ParallelLoopState();
      for m: Integer := fromInclusive to toExclusive - 1 do begin
        while lcurrTasks.get >= lthreadcnt do begin
          if ls.IsStopped then Break;
          locking levent do
            levent.wait;
        end;
        if ls.IsStopped then Break;
        lcurrTasks.incrementAndGet;
        var temp := m;
        new Task(->
          begin
            body(temp, ls);
            lcurrTasks.decrementAndGet;
            locking levent do
              levent.notifyAll;
          end).Start;
      end;
      while lcurrTasks.get > 0 do begin
        locking levent do
          levent.wait;
      end;
    end;


    class method &For(fromInclusive: Int64; toExclusive: Int64; body: Action2<Int64,ParallelLoopState>);
    begin
      var lthreadcnt := Runtime.getRuntime().availableProcessors();
      var lcurrTasks := new AtomicInteger();
      var levent := new Object;
      var ls:= new ParallelLoopState();
      for m: Int64 := fromInclusive to toExclusive - 1 do begin
        while lcurrTasks.get >= lthreadcnt do begin
          if ls.IsStopped then Break;
          locking levent do
            levent.wait;
        end;
        if ls.IsStopped then Break;
        lcurrTasks.incrementAndGet;
        var temp := m;
        new Task(->
          begin
            body(temp, ls);
            lcurrTasks.decrementAndGet;
            locking levent do
              levent.notifyAll;
          end).Start;
      end;
      while lcurrTasks.get > 0 do begin
        locking levent do
          levent.wait;
      end;
    end;

    class method ForEach<T>(source: Iterable<T>; body: Action3<T,ParallelLoopState, Int64>);
    begin
      var lthreadcnt := Runtime.getRuntime().availableProcessors();
      var lcurrTasks := new AtomicInteger();
      var levent := new Object;
      var ls:= new ParallelLoopState();
      for m in source index n do begin
        while lcurrTasks.get >= lthreadcnt do begin
          if ls.IsStopped then Break;
          locking levent do
            levent.wait;
        end;
        if ls.IsStopped then Break;
        lcurrTasks.incrementAndGet;
        var temp := m;
        var tempi := n;
        new Task(->
          begin
            body(temp, ls, tempi);
            lcurrTasks.decrementAndGet;
            locking levent do
              levent.notifyAll;
          end).Start;
      end;
      while lcurrTasks.get > 0 do begin
        locking levent do
          levent.wait;
      end;
    end;
  end;

end.