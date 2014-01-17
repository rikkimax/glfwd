module glfwd.platforms.win32;
import glfwd.platforms.win32.context;
import glfwd.platforms.win32.time;
import glfwd.registration.window;
import glfwd.registration.context;
import glfwd.registration.time;

import std.algorithm : toDelegate;

shared static this() {
	registerContext("win32", toDelegate(&Context_Win.__ctor));
	registerTimer("win32", new Timer_Win);
}