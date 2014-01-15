module glfwd.util;

pure int Max(int a, int b) {
	return (a > b) ? a : b;
}

string _glfwCreateUTF8FromWideString(char[] a) {
	string ret;
	
	foreach(c; a) {
		if (c == 0)
			break;
		else
			ret ~= c;
	}
	
	return ret;
}