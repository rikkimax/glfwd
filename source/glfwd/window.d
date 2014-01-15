module glfwd.window;
import glfwd.util;
import glfwd.monitor;
public import glfwd.c.defs : GLFWwindowCallbacks;

abstract class IWindow {
	this(in int width, in int height, in string title = "A GLFWD window", in IMonitor monitor = null, in IWindow share = null);
	//~this();
	
	void defaultHints();
	static void defaultHint(in int target, in int hint);
	
	void iconify();
	void restore();
	
	void show();
	void hide();
	
	@property {
		int shouldClose();
		void shouldClose(in int value);
		
		void title(in string title);
		
		int x();
		void x(in int);
		int y();
		void y(in int);
		
		int[2] pos();
		void pos(in int x, in int y);
		
		int width();
		void width(int);
		int height();
		void height(int);
		
		int[2] size();
		void size(in int width, in int height);
		
		int framebufferSizeWidth();
		int framebufferSizeHeight();
		int[2] framebufferSize();
		
		IMonitor monitor();
		
		int IWindowAttrib(in int attrib);
		
		void userPointer(in void* pointer);
		void* userPointer();
		
		ref GLFWwindowCallbacks glfwCallbacks();
	}
}