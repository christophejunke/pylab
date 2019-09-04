#include "common.h"
using namespace pybind11::literals;

int main()
{
	py::scoped_interpreter guard{};
	auto tst = PYMPORT("cythtest");
	py::eval("run()", tst);
	return 0;
}

