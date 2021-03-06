﻿#if ECHOES
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
#endif

namespace Remobjects.Elements.MicroTasks
{
	/// <summary>
	/// Result of a (void) method, by default this implies "completed synchronously"
	/// </summary>
	public struct VoidResult
	{

		/// <summary>
		/// holds the task; if this is null it's already complete. If there's an exception it's stored as part of a completed task.
		/// </summary>
		private VoidMicroTask task;

		/// <summary>
		/// Creates a new result with a task as content.
		/// </summary>
		/// <param name="task"></param>
		public VoidResult(VoidMicroTask task)
		{
			this.task = task;
		}

		/// <summary>
		/// returns true if result is done.
		/// </summary>
		public bool IsCompleted
		{
			get
			{
				return task == null || task.IsCompleted;
			}
		}

		/// <summary>
		/// returns the task, this can be null.
		/// </summary>
		public VoidMicroTask Task { get { return task; } }

		/// <summary>
		/// empty "done" result.
		/// </summary>
		/// <returns></returns>
		public static VoidResult CompletedTask
		{
			get {
				return default(VoidResult);
			}
		}

		/// <summary>
		/// Used to re-throw any exception if there was one, for non void results this would return an actual value (Result&lt;T&gt;)
		/// </summary>
		public void GetResult()
		{
			if (task == null) return;
			task.GetResult();
		}

		public void OnComplete(IAsyncCompletion callback)
		{
			if (task == null)
				callback.Step();
			else
				task.OnComplete(callback);
		}

#if ECHOES
		public VoidResultAwaiter GetAwaiter()
		{
			return new VoidResultAwaiter(task);
		}

#endif
	}
#if ECHOES
	public class VoidResultAwaiter
	{
		readonly VoidMicroTask t;

		public VoidResultAwaiter(VoidMicroTask t)
		{
			this.t = t;
		}

		public void OnCompleted(Action continuation)
		{
			if (t.IsCompleted) continuation();
			else
			{
				t.OnComplete(new AwaitCompletion(continuation));
			}
		}


		public bool IsCompleted
		{
			get
			{
				if (t == null) return true;
				return t.IsCompleted;
			}
		}

		public void GetResult()
		{
			if (t == null) return;
			t.GetResult();
		}
	}

	class AwaitCompletion: IAsyncCompletion
	{
		readonly Action c;
		public AwaitCompletion(Action c)
		{
			this.c = c;
		}


		public void Step()
		{
			c();
		}
	}

	public class ResultAwaiter<T>
	{
		readonly MicroTask<T> t;
		readonly T value;

		public ResultAwaiter(MicroTask<T> t, T value)
		{
			this.t = t;
			this.value = value;
		}

		public void OnCompleted(Action continuation)
		{
			if (t.IsCompleted) continuation();
			else {
				t.OnComplete(new AwaitCompletion(continuation));
			}
		}

		public bool IsCompleted
		{
			get {
				if (t == null) return true;
				return t.IsCompleted;
			}
		}

		public T GetResult()
		{
			if (t == null) return value;
			return t.GetResult();
		}
	}
#endif
	/// <summary>
	/// Result of a non void method, by default
	/// </summary>
	public struct Result<T>
	{
		/// <summary>
		/// holds the value result
		/// </summary>
		private T value;

		/// <summary>
		/// holds the task; if this is null it's already complete. If there's an exception it's stored as part of a completed task.
		/// </summary>
		private MicroTask<T> task;

		/// <summary>
		/// Creates a new result with a task as content.
		/// </summary>
		/// <param name="task"></param>
		private Result(MicroTask<T> task, T value)
		{
			this.task = task;
			this.value = value;
		}

		/// <summary>
		/// Creates a new result with a task as content.
		/// </summary>
		/// <param name="task"></param>
		public Result(MicroTask<T> task)
		{
			this.value = default(T);
			this.task = task;
		}

		public static Result<T> FromResult(T value){
			return new Result<T>(null, value);
		}

		/// <summary>
		/// returns true if result is done.
		/// </summary>
		public bool IsCompleted
		{
			get
			{
				return task == null || task.IsCompleted;
			}
		}

		/// <summary>
		/// Returns the underlying task, could be null.
		/// </summary>
		public MicroTask<T> Task { get { return task; } }

		/// <summary>
		/// returns a done task with this value.
		/// </summary>
		/// <param name="value"></param>
		/// <returns></returns>
		public static Result<T> Done(T value)
		{
			return new Result<T>(null, value);
		}

		public void OnComplete(IAsyncCompletion callback)
		{
			if (task == null)
				callback.Step();
			else
				task.OnComplete(callback);
		}
		/// <summary>
		/// Used to re-throw any exception if there was one, for non void results this would return an actual value (Result&lt;T&gt;)
		/// </summary>
		public T GetResult()
		{
			if (task == null) return value;
			return task.GetResult();
		}
#if ECHOES
		public VoidResultAwaiter GetAwaiter()
		{
			return new VoidResultAwaiter(task);
		}

#endif
	}

	/// <summary>
	/// state for the tasks
	/// </summary>
	public enum TaskState: int
	{
		Running,
		NotStartedYet,
		Done,
		Exception
	}

	/// <summary>
	/// A task is a piece of code that completes asynchronously; Tasks do not deal with threading and synchronization contexts, they always run on calling thread that triggers the completion.
	/// </summary>
	public class VoidMicroTask
	{
		#if !COOPER
		private int @lock;
		#endif
		private volatile TaskState state;
		private Exception exception;
		private volatile Completion completion;


		class Completion
		{
			public Completion Next;
			public IAsyncCompletion Action;
		}


		#if !COOPER
		private static void SpinLockEnter(ref int v)
		{
			#if ISLAND
			Utilities.SpinLockEnter(ref v);
			#else
			do
			{
				if (global::System.Threading.Interlocked.Exchange(ref v, 1) == 0) return;
				if (!global::System.Threading.Thread.Yield())
					global::System.Threading.Thread.Sleep(1);
			} while (true);
			#endif
		}

		private static void SpinLockExit(ref int v)
		{
			#if ISLAND
			Utilities.SpinLockExit(ref v);
			#else
			global::System.Threading.Thread.VolatileWrite(ref v, 0);
			#endif
		}
		#endif

		/// <summary>
		/// contains the state for this task
		/// </summary>
		public TaskState State
		{
			get { return state; }
		}

		private static VoidMicroTask GetDone()
		{
			var t = new VoidMicroTask();
			t.SetComplete();
			return t;
		}
		private static VoidMicroTask done;

		/// <summary>
		/// returns an empty "done" task.
		/// </summary>
		public static VoidMicroTask Done { get { return done ?? (done = GetDone()); } }

		/// <summary>
		/// Returns if this task is done or not.
		/// </summary>
		public bool IsCompleted
		{
			get
			{
				return state >= TaskState.Done;
			}
		}

		/// <summary>
		/// Registers a completion callback,
		/// </summary>
		/// <param name="x"></param>
		public void OnComplete(IAsyncCompletion callback)
		{
			if (this.state >= TaskState.Done)
			{
				callback.Step();
				return;
			}
			var p = new Completion();
			p.Action = callback;
			#if COOPER
			lock(this) {
				if (this.state >= TaskState.Done)
				{
					callback.Step();
					return;
				}
				p.Next = completion;
				completion = p;
			}
			#else
			SpinLockEnter(ref @lock);
			if (this.state >= TaskState.Done)
			{
				SpinLockExit(ref @lock);
				callback.Step();
				return;
			}
			p.Next = completion;
			completion = p;
			SpinLockExit(ref @lock);
			#endif
		}

		#if ECHOES
		class Waiter: IAsyncCompletion, IDisposable
		{
			public global::System.Threading.AutoResetEvent ev = new global::System.Threading.AutoResetEvent(false);

			public void Dispose()
			{
				ev?.Dispose();
			}

			public void Step()
			{
				ev?.Set();
			}
		}
		#else
		#if COOPER
		class Waiter: IAsyncCompletion
		{
			public bool done;
			public Object o = new Object();

			public void Dispose()
			{
			}

			public void Step()
			{
				lock(o){
					done = true;
					o.notifyAll();
				}
			}
		}
		#elseif !NOTHREADS
		class Waiter: IAsyncCompletion, IDisposable
		{
			public EventWaitHandle ev = new EventWaitHandle(true, false);

			public void Dispose()
			{
				ev?.Dispose();
			}

			public void Step()
			{
				ev?.Set();
			}
		}
		#endif
		#endif

#if !NOTHREADS
		/// <summary>
		/// wait for this task to finish
		/// </summary>
		public void Wait()
		{
			if (IsCompleted) return;
			var w = new Waiter();
			OnComplete(w);
			#if ECHOES
			w.ev.WaitOne();
			#elseif COOPER
			lock(w.o) {
				while (!w.done) {
					w.o.wait();
				}
			}
			#else
			w.ev.Wait();
			#endif
			w.Dispose();
		}
#else
		public void Wait(){
			throw new Exception("Cannot wait on this platform");
		}
#endif
		/// <summary>
		/// returns the exception
		/// </summary>
		public Exception Exception
		{
			get
			{
				if (!IsCompleted)
					Wait();
				return exception;
			}
		}

		/// <summary>
		/// waits for the task and throws an exception if there was one.
		/// </summary>
		public void GetResult()
		{
			Wait();
			if (state == TaskState.Exception)
				throw exception;
		}

		/// <summary>
		/// completes the task with NO result.
		/// </summary>
		public void SetComplete()
		{
			#if COOPER
			Completion w;
			lock(this) {
				if (this.state != TaskState.Running)
				{
					throw new Exception("Invalid state for task: "+this.state);
				}
				 w = this.completion;
				this.completion = null;
				this.state = TaskState.Done;
			}
			while (w != null)
			{
				w.Action.Step();
				w = w.Next;
			}
			#else
			SpinLockEnter(ref @lock);
			if (this.state != TaskState.Running)
			{
				SpinLockExit(ref @lock);
				throw new Exception("Invalid state for task: "+this.state);
			}
			var w = this.completion;
			this.completion = null;
			this.state = TaskState.Done;
			SpinLockExit(ref @lock);
			while (w != null)
			{
				w.Action.Step();
				w = w.Next;
			}
			#endif
		}

		/// <summary>
		/// Completes the task with an exception
		/// </summary>
		/// <param name="e">the exception</param>
		public void SetException(Exception e)
		{
			#if COOPER
			Completion w;
			lock(this) {
				if (this.state != TaskState.Running)
				{
					throw new Exception("Invalid state for task: "+this.state);
				}
				w = this.completion;
				this.exception = e;
				this.completion = null;
				this.state = TaskState.Exception;
			}
			while (w != null)
			{
				w.Action.Step();
				w = w.Next;
			}

			#else
			SpinLockEnter(ref @lock);
			if (this.state != TaskState.Running)
			{
				SpinLockExit(ref @lock);
				throw new Exception("Invalid state for task: " + this.state);
			}
			var w = this.completion;
			this.completion = null;
			this.exception = e;
			this.state = TaskState.Exception;
			SpinLockExit(ref @lock);
			while (w != null)
			{
				w.Action.Step();
				w = w.Next;
			}
			#endif
		}
	}

	public class MicroTask<T>: VoidMicroTask
	{
		T value;

		/// <summary>
		/// Waits for the task to complete and returns the result. This can trigger an exception if the task triggered one.
		/// </summary>
		/// <returns>result</returns>
		public new T GetResult()
		{

			Wait();
			if (State == TaskState.Exception)
				throw base.Exception;
			return value;
		}


		/// <summary>
		/// triggers a completion of this task with the given value.
		/// </summary>
		/// <param name="value">value to complete with</param>
		public void SetComplete(T value)
		{
			this.value = value;
			SetComplete();
		}

	}

	/// <summary>
	/// Interface used by the state machine to set itself's self.
	/// </summary>
	public interface ISetSelfAsyncCompletion: IAsyncCompletion
	{
		void SetSelf(ISetSelfAsyncCompletion cc);
	}
	/// <summary>
	/// Used to callback when the subtask is done.
	/// </summary>
	public interface IAsyncCompletion
	{
		void Step();
	}
}