module glfwd.monitor;
public import glfwd.c.defs : GLFWmonitorfun;
public import glfwd.c.monitor : GLFWvidmode;
public import glfwd.c.gamma : GLFWgammaramp;

abstract class IMonitor {
	@property {
		int x();
		int y();
		int[2] pos();
		
		int width();
		int height();
		int[2] size();
		
		string name();
		string adaptorName();
		
		GLFWvidmode[] videoModes();
		GLFWvidmode videoMode();
		
		void gamma(float);
		GLFWgammaramp gammaRamp();
		void gammaRamp(GLFWgammaramp);
		
		static {
			IMonitor[] all();
			IMonitor primary();
		}
	}
}