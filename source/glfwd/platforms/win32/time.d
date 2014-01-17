module glfwd.platforms.win32.time;
import glfwd.time;

version(Windows) {
	import windows : QueryPerformanceCounter, timeGetTime, LARGE_INTEGER;
	
	class Timer_Win : ITimer {
		this() {
			ulong frequency;
			if (QueryPerformanceCounter(cast(LARGE_INTEGER*)&frequency)) {
				hasPC = true;
				resolution = 1f / frequency;
			} else {
				hasPC = false;
				resolution = 0.001;
			}
			
			base = rawTime();
		}
		
		@property {
			override ulong rawTime() {
				if (hasPC) {
					ulong time;
					QueryPerformanceCounter(cast(LARGE_INTEGER*)&time);
					return time;
				} else {
					return cast(ulong)timeGetTime();
				}
			}
			
			override double time() {
				return (rawTime() - base) * resolution;
			}
			
			override void time(double value) {
				base = cast(ulong)(rawTime() - (value / resolution));
			}
		}
	}
}