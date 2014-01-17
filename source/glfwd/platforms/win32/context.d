module glfwd.platforms.win32.context;

version(Windows) {
	import glfwd.context;
	import glfwd.window;
	
	import core.runtime;
	
	class Context_Win : IContext, IOpenGLContext {
		private {
			IWindow _window;
		}
		
		this(IWindow window) {
			_window = window;
		}
		
		override void activate();
		override void swapBuffers();
		
		int extensionSupported(string extension);
		
		void* procAddress(string procname);
		
		@property {
			override IWindow window() {
				return _window;
			}
			
			override void swapInterval(int interval);
			
			override ContextDimension dimension() {
				return ContextDimension.Three;
			}
		}
	}
	
	private shared {
		void* ogllib;
	}
	
	shared static this() {
		ogllib = cast(shared)Runtime.loadLibrary("opengl32.dll");
		assert(ogllib !is null, "Cannot find opengl library");
	}
	
	shared static ~this() {
		Runtime.unloadLibrary(cast(void*)ogllib);
	}
}