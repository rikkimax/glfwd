module glfwd.c.init;

extern(C) {
	int glfwInit();
	void glfwTerminate();
	void glfwGetVersion(int* major, int* minor, int* rev);
	const char* glfwGetVersionString();
}