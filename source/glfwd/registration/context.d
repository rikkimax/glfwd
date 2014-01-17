module glfwd.registration.context;
import glfwd.context;
import glfwd.window;

private shared {
	alias IContext delegate(IWindow) contextCreateDel;
	contextCreateDel[string] funcs;
	string defaultFunc;
}

void registerContext(string name, contextCreateDel func) {
	synchronized {
		funcs[name] = func;
	}
}

void defaultContext(string name) {
	synchronized {
		defaultFunc = name;
	}
}

IContext createContext(IWindow window, string name = defaultFunc) {
	synchronized {
		if (name in funcs) {
			return funcs[name](window);
		}
		
		return null;
	}
}