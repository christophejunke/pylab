#include <pybind11/embed.h>
namespace py = pybind11;

#define PYMPORT(X) py::module::import(X).attr("__dict__")
