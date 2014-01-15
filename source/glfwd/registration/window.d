module glfwd.registration.window;
import glfwd.monitor;
import glfwd.window;

private shared {
	alias IWindow function(in int width, in int height, in string title = "A GLFWD IWindow", in IMonitor monitor = null, in IWindow share = null) windowCreateFunc;
	
	windowCreateFunc[string] funcs;
	string defaultFunc;
}

void registerWindow(string name, windowCreateFunc func) {
	synchronized {
		funcs[name] = func;
	}
}

void defaultWindow(string name) {
	synchronized {
		defaultFunc = name;
	}
}

IWindow createWindow(in int width, in int height, in string title = "A GLFWD IWindow", in IMonitor monitor = null, in IWindow share = null, string name = defaultFunc) {
	if (name in funcs)
		return funcs[name](width, height, title, monitor, share);
	return null;
}