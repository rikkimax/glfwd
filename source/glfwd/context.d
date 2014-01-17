module glfwd.context;
import glfwd.window;

enum ContextDimension {
	None,
	Three,
	Two
}

private {
	IContext currentlyActivated;
}

IContext getCurrentlyActivated() {
	return currentlyActivated;
}

abstract class IContext {
	void activate() {
		currentlyActivated = cast(IContext)this;
	}
	
	void swapBuffers();
	
	@property {
		IWindow window();
		void swapInterval(int interval);		
		ContextDimension dimension();
	}
}

interface IOpenGLContext {
	int extensionSupported(string extension);
	void* procAddress(string procname);
}