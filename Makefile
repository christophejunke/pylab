MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

PATH += $(HOME)/.local/bin

NAME := run

PYTHON_SRC := test.py

PYTHON := /usr/bin/python3.7
PYTHON_CFG := /usr/bin/x86_64-linux-gnu-python3.7m-config

PYTHON_CFLAGS += $(shell $(PYTHON_CFG) --cflags)
PYTHON_LDFLAGS += $(shell $(PYTHON_CFG) --ldflags)

CXX := g++
CXX_FLAGS := -std=c++11 -fPIC $(PYTHON_CFLAGS)

PY11_FLAGS := $(shell $(PYTHON) -m pybind11 --includes)
PY11_SRC := py11.cpp
PY11_BINARY := $(NAME)-pybind

CYTH_FLAGS :=
CYTH_BRIDGE := bridge.py
CYTH_SRC := cyth.cpp
CYTH_BINARY := $(NAME)-cython

py11-test := PYTHONPATH=. ./$(PY11_BINARY)
cyth-test := PYTHONPATH=. ./$(CYTH_BINARY)
pyth-test := $(PYTHON) -c 'import test; test.run()'
cut := sed -n '/cumtime/,+1p'

test: $(PY11_BINARY) $(CYTH_BINARY)
	$(py11-test) | $(cut)
	$(cyth-test) | $(cut)
	$(pyth-test) | $(cut)

$(PY11_BINARY): $(PY11_SRC) Makefile
	$(CXX) \
	$(CXX_FLAGS) \
	$(PY11_FLAGS) \
	$(PY11_SRC) \
	$(PYTHON_LDFLAGS) \
	-o $(PY11_BINARY)

$(CYTH_BINARY): $(CYTH_SRC) Makefile cythtest.cpython-37m-x86_64-linux-gnu.so
	$(CXX) \
	$(CXX_FLAGS) \
	$(PY11_FLAGS) \
	$(CYTH_FLAGS) \
	$(CYTH_SRC) \
	$(PYTHON_LDFLAGS) \
	-o $(CYTH_BINARY)

cythtest.cpython-37m-x86_64-linux-gnu.so: setup.py $(PYTHON_SRC)
	$(PYTHON) setup.py build_ext --inplace
