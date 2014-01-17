module glfwd.registration.time;
import glfwd.time;

private shared {
	ITimer[string] timers;
	string defaultTimerInstance;
}

void registerTimer(string name, ITimer timer) {
	synchronized {
		timers[name] = cast(shared)timer;
	}
}

void defaultTimer(string name) {
	synchronized {
		defaultTimerInstance = name;
	}
}

ITimer getTimer(string name = defaultTimerInstance) {
	synchronized {
		if (name in timers) {
			return cast(ITimer)timers[name];
		}
		
		return null;
	}
}