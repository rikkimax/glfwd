module glfwd.platforms.win32.monitor;

version(Windows) {
	
	enum DWORD ENUM_CURRENT_SETTINGS  = -1; // again missing
	enum EDS_ROTATEDMODE = 0x00000004; // missing from header woops
	
	import glfwd.util;
	import glfwd.monitor;
	import glfwd.c.monitor : _glfwSplitBPP, _glfwPlatformIsSameMonitor, _glfwCompareVideoModes;
	import glfwd.c.gamma : GLFWgammaramp, _glfwAllocGammaArrays;
	import windows : DWORD, DISPLAY_DEVICE, HDC, EnumDisplayDevicesA, DISPLAY_DEVICE_MIRRORING_DRIVER, DEVMODE,
		DISPLAY_DEVICE_ACTIVE, CreateDCW, DISPLAY_DEVICE_PRIMARY_DEVICE, GetDeviceCaps, HORZSIZE, VERTSIZE, DeleteDC, 
		EnumDisplaySettingsExA, EnumDisplaySettingsA, WORD, GetDeviceGammaRamp, SetDeviceGammaRamp;
	
	import std.string : toStringz;
	import std.math : pow;
	import core.stdc.string : memcpy;
	
	class Monitor_Win : IMonitor {
		private {
			int _width, _height;
			string _name, _adaptorName;
			
			this(string name, string adaptorName, int horsize, int versize) {
				_name = name.idup;
				_adaptorName = adaptorName.idup;
				
				_width = horsize;
				_height = versize;
			}
		}
		
		@property {
			override int x() {
				DEVMODE settings;
				settings.dmSize = DEVMODE.sizeof;
				
				EnumDisplaySettingsExA(cast(char*)_name.toStringz, ENUM_CURRENT_SETTINGS, &settings, EDS_ROTATEDMODE);
				
				return settings.dmPosition.x;
			}
			
			override int y() {
				DEVMODE settings;
				settings.dmSize = DEVMODE.sizeof;
				
				EnumDisplaySettingsExA(cast(char*)_name.toStringz, ENUM_CURRENT_SETTINGS, &settings, EDS_ROTATEDMODE);
				
				return settings.dmPosition.y;
			}
			
			override int[2] pos() {
				DEVMODE settings;
				settings.dmSize = DEVMODE.sizeof;
				
				EnumDisplaySettingsExA(cast(char*)_name.toStringz, ENUM_CURRENT_SETTINGS, &settings, EDS_ROTATEDMODE);
				
				return [settings.dmPosition.x, settings.dmPosition.y];
			}
			
			override int width() {
				return _width;
			}
			
			override int height() {
				return _height;
			}
			
			override int[2] size() {
				return [_width, _height];
			}
			
			override string name() {
				return _name;
			}
			
			override string adaptorName() {
				return _adaptorName;
			}
			
			override GLFWvidmode[] videoModes() {
				GLFWvidmode[] ret;
				size_t modeIndex;
				
				for(;;) {
					int i;
					GLFWvidmode mode;
					
					DEVMODE dm;
					dm.dmSize = DEVMODE.sizeof;
					
					if (!EnumDisplaySettingsA(cast(char*)_name.toStringz(), modeIndex, &dm))
						break;
					
					modeIndex++;
					
					if (dm.dmBitsPerPel < 15) {
						continue;
					}
					
					mode.width  = dm.dmPelsWidth;
					mode.height = dm.dmPelsHeight;
					mode.refreshRate = dm.dmDisplayFrequency;
					_glfwSplitBPP(dm.dmBitsPerPel,
					              &mode.redBits,
					              &mode.greenBits,
					              &mode.blueBits);
					
					for (i = 0;  i < ret.length;  i++) {
						if (_glfwCompareVideoModes(&ret[i], &mode) == 0)
							break;
					}
					
					if (i < ret.length) {
						continue;
					}
					
					ret ~= mode;
				}
				
				return ret;
			}
			
			override GLFWvidmode videoMode() {
				DEVMODE dm;
				dm.dmSize = DEVMODE.sizeof;
				
				EnumDisplaySettingsA(cast(char*)_name.toStringz(), ENUM_CURRENT_SETTINGS, &dm);
				
				GLFWvidmode mode;
				mode.width = dm.dmPelsWidth;
				mode.height = dm.dmPelsHeight;
				mode.refreshRate = dm.dmDisplayFrequency;
				_glfwSplitBPP(dm.dmBitsPerPel,
				              &mode.redBits,
				              &mode.greenBits,
				              &mode.blueBits);
				
				return mode;
			}
			
			override void gamma(float f) {
				int i;
				ushort values[256];
				GLFWgammaramp ramp;
				
				if (f <= 0f) {
					throw new Exception("Gamma value must be greater than zero");
				}
				
				for (i = 0;  i < 256;  i++) {
					double value;
					
					// Calculate intensity
					value = i / 255.0;
					// Apply gamma curve
					value = pow(value, 1f / f) * 65535f + 0.5f;
					
					// Clamp to value range
					if (value > 65535.0)
						value = 65535.0;
					
					values[i] = cast(ushort) value;
				}
				
				ramp.red = values.ptr;
				ramp.green = values.ptr;
				ramp.blue = values.ptr;
				ramp.size = 256;
				
				gammaRamp(ramp);
			}
			
			override GLFWgammaramp gammaRamp() {
				GLFWgammaramp ramp;
				
				HDC dc;
				WORD values[768];
				DISPLAY_DEVICE display;
				
				display.cb = DISPLAY_DEVICE.sizeof;
				EnumDisplayDevicesA(cast(char*)_name.toStringz(), 0, &display, 0);
				
				dc = CreateDCW(cast(ushort*)"DISPLAY\0".ptr, cast(ushort*)display.DeviceString.ptr, null, null);
				GetDeviceGammaRamp(dc, values.ptr);
				DeleteDC(dc);
				
				_glfwAllocGammaArrays(&ramp, 256);
				
				memcpy(&ramp.red,   &values[0], 256 * ushort.sizeof);
				memcpy(&ramp.green, &values[256], 256 * ushort.sizeof);
				memcpy(&ramp.blue,  &values[512], 256 * ushort.sizeof);
				
				return ramp;
			}
			
			override void gammaRamp(GLFWgammaramp ramp) {
				HDC dc;
				WORD values[768];
				DISPLAY_DEVICE display;
				
				if (ramp.size != 256) {
					throw new Exception("Win32: Gamma ramp size must be 256");
				}
				
				memcpy(&values[0],   ramp.red,   256 * ushort.sizeof);
				memcpy(&values[256], ramp.green, 256 * ushort.sizeof);
				memcpy(&values[512], ramp.blue,  256 * ushort.sizeof);
				
				display.cb = DISPLAY_DEVICE.sizeof;
				EnumDisplayDevicesA(cast(char*)name.toStringz(), 0, &display, 0);
				
				dc = CreateDCW(cast(ushort*)"DISPLAY\0".ptr, cast(ushort*)display.DeviceString, null, null);
				SetDeviceGammaRamp(dc, values.ptr);
				DeleteDC(dc);
			}
			
			static  {
				IMonitor[] all() {
					size_t found = 0;
					Monitor_Win[] monitors;
					size_t primaryIndex;
					DWORD adapterIndex;
					
					for(;;) {
						DISPLAY_DEVICE adapter, display;
						string name;
						HDC dc;
						
						adapter.cb = DISPLAY_DEVICE.sizeof;
						
						if (!EnumDisplayDevicesA(null, adapterIndex, &adapter, 0))
							break;
						
						adapterIndex++;
						
						if ((adapter.StateFlags & DISPLAY_DEVICE_MIRRORING_DRIVER) ||
						    !(adapter.StateFlags & DISPLAY_DEVICE_ACTIVE))
							continue;
						
						display.cb = DISPLAY_DEVICE.sizeof;
						
						EnumDisplayDevicesA(adapter.DeviceName.ptr, 0, &display, 0);
						dc = CreateDCW(cast(ushort*)"DISPLAY\0"w.ptr, cast(ushort*)display.DeviceString.ptr, null, null);
						
						if (adapter.StateFlags & DISPLAY_DEVICE_PRIMARY_DEVICE)
							primaryIndex = monitors.length;
						
						name = _glfwCreateUTF8FromWideString(display.DeviceString);
						
						if (!name) {
							throw new Exception("Failed to convert string to UTF-8");
						}
						
						monitors ~= new Monitor_Win(name, cast(string)adapter.DeviceName, GetDeviceCaps(dc, HORZSIZE), GetDeviceCaps(dc, VERTSIZE));
						
						DeleteDC(dc);
					}
					
					if (primaryIndex > 0) {
						Monitor_Win temp = monitors[0];
						monitors[0] = monitors[primaryIndex];
						monitors[primaryIndex] = temp;
					}
					
					return cast(IMonitor[])monitors;
				}
				
				IMonitor primary() {
					auto a = all();
					assert(a.length > 0);
					return a[0];
				}
			}
		}
	}
}