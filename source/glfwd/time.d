module glfwd.time;

abstract class ITimer {
	bool hasPC;
	double resolution;
	ulong base;
	
	this();
	
	@property {
		ulong rawTime();
		double time();
		void time(double);
	}
}