#include "common.h"
using namespace pybind11::literals;

int main()
{
    py::scoped_interpreter guard{};
    auto cmp = PYMPORT("py_compile");
    auto res = py::eval("compile", cmp)("test.py", "optimize"_a=1);
    auto tst = PYMPORT("test");
    py::eval("run()", tst);
    return 0;
}

