module glfwd.c.defs;
import glfwd.c.window : GLFWwindow;
import glfwd.c.monitor : GLFWmonitor;

extern(C) {
	// added so IWindow can still do good stuff
	struct GLFWwindowCallbacks {
		GLFWwindowposfun pos;
		GLFWwindowsizefun size;
		GLFWwindowclosefun close;
		GLFWwindowrefreshfun refresh;
		GLFWwindowfocusfun focus;
		GLFWwindowiconifyfun iconify;
		GLFWframebuffersizefun framebuffersize;
	}
	
	alias void function(GLFWwindow*, int, int) GLFWwindowposfun;
	alias void function(GLFWwindow*, int, int) GLFWwindowsizefun;
	alias void function(GLFWwindow*) GLFWwindowclosefun;
	alias void function(GLFWwindow*) GLFWwindowrefreshfun;
	alias void function(GLFWwindow*, int) GLFWwindowfocusfun;
	alias void function(GLFWwindow*, int) GLFWwindowiconifyfun;
	alias void function(GLFWwindow*, int, int) GLFWframebuffersizefun;
	
	alias void function(GLFWmonitor*, int) GLFWmonitorfun;
	
	
	//public import glfwd.c.defs : GLFWwindowposfun, GLFWwindowsizefun, GLFWwindowclosefun, GLFWwindowrefreshfun, GLFWwindowfocusfun, GLFWwindowiconifyfun, GLFWframebuffersizefun;
	/**
	 * Moved from glfwd.c.IWindow
	 * As dmd thought GLFWwindow was being forward referenced...
	 */
	GLFWwindowposfun glfwSetIWindowPosCallback(GLFWwindow* IWindow, GLFWwindowposfun cbfun);
	GLFWwindowsizefun glfwSetIWindowSizeCallback(GLFWwindow* IWindow, GLFWwindowsizefun cbfun);
	GLFWwindowclosefun glfwSetIWindowCloseCallback(GLFWwindow* IWindow, GLFWwindowclosefun cbfun);
	GLFWwindowrefreshfun glfwSetIWindowRefreshCallback(GLFWwindow* IWindow, GLFWwindowrefreshfun cbfun);
	GLFWwindowfocusfun glfwSetIWindowFocusCallback(GLFWwindow* IWindow, GLFWwindowfocusfun cbfun);
	GLFWwindowiconifyfun glfwSetIWindowIconifyCallback(GLFWwindow* IWindow, GLFWwindowiconifyfun cbfun);
	GLFWframebuffersizefun glfwSetFramebufferSizeCallback(GLFWwindow* IWindow, GLFWframebuffersizefun cbfun);
}