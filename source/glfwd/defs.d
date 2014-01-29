module glfwd.defs;

enum KeyModifiers {
	Shift = 0x0001,
	Control = 0x0002,
	Alt = 0x0004,
	Super = 0x0008
}

enum Keys {
	// I added this because it was there but not really defined
	Invalid = -2,
	
	Unknown = -1,
	Space = 32,
	Apostrophe = 39,
	
	// sequential values
	Comma = 44,
	Minus,
	Period,
	Slash,
	
	// sequential values
	Number0 = 48,
	Number1,
	Number2,
	Number3,
	Number4,
	Number5,
	Number6,
	Number7,
	Number8,
	Number9,
	
	SemiColon = 59,
	Equal = 61,
	
	// sequential values
	A = 65,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,
	
	// sequential values
	LeftBracket = 91,
	BackSlash,
	RightBracket,
	
	GraveAccent = 96,
	
	// sequential values
	World1 = 161,
	World2,
	
	// sequential values
	Escape = 256,
	Enter,
	Tab,
	Backspace,
	Insert,
	Delete,
	ArrowKeyRight,
	ArrowKeyLeft,
	ArrowKeyDown,
	ArrowKeyUp,
	PageUp,
	PageDown,
	Home,
	End,
	
	// sequential values
	CapsLock = 280,
	ScrollLock,
	NumLock,
	PrintScreen,
	Pause,
	
	
	// sequential values
	F1 = 290,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,
	F13,
	F14,
	F15,
	F16,
	F17,
	F18,
	F19,
	F20,
	F21,
	F22,
	F23,
	F24,
	F25,
	
	// sequential values
	KeyPad0 = 320,
	KeyPad1,
	KeyPad2,
	KeyPad3,
	KeyPad4,
	KeyPad5,
	KeyPad6,
	KeyPad7,
	KeyPad8,
	KeyPad9,
	KeyPadDecimal,
	KeyPadDivide,
	KeyPadMultiply,
	KeyPadSubtract,
	KeyPadAdd,
	KeyPadEnter,
	KeypadEqual,
	
	
	// sequential values
	LeftShift,
	LeftControl,
	LeftAlt,
	LeftSuper,
	RightShift,
	RightControl,
	RightAlt,
	RightSuper,
	Menu,
	
	Last = Menu
}

enum JoystickKeys {
	Key1,
	Key2,
	Key3,
	Key4,
	Key5,
	Key6,
	Key7,
	Key8,
	Key9,
	Key10,
	Key11,
	Key12,
	Key13,
	Key14,
	Key15,
	Key16,
	Last = Key16
}

enum MouseButtons {
	Button1 = 0,
	Button2,
	Button3,
	Button4,
	Button5,
	Button6,
	Button7,
	Button8,
	
	Last = Button8,
	Left = Button1,
	Right = Button2,
	Middle = Button3
}

enum KeyButtonActions {
	Release = 0,
	Press,
	Repeat
}