from libcpp.string cimport string
cdef extern from "<iostream>" namespace "std":
    cdef cppclass ostream:
        ostream& write(const char*, int) except +
    ostream cout

cdef extern from "../MCTDH/ControlParameters.h":
    cdef cppclass ControlParameters:
        ControlParameters() except +
        void Initialize(string, ostream&)

cdef ControlParameters config

cdef extern from "../MCTDH/mctdhBasis.h":
    cdef cppclass mctdhBasis:
        mctdhBasis() except +
        void Initialize(string, ControlParameters&)

cdef class PyControlParameters:
    cdef ControlParameters *thisptr
    def __cinit__(self):
        self.thisptr = new ControlParameters()
    def __dealloc__(self):
        del self.thisptr
    def PyInitialize(self, a):
            self.thisptr.Initialize(a, cout)

cdef class PymctdhBasis:
  cdef mctdhBasis *thisptr
  def __cinit__(self):
      self.thisptr = new mctdhBasis()
  def __dealloc__(self):
      del self.thisptr
  def PyInitialize(self, filename):
      self.thisptr.Initialize(filename, config)
