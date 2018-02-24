from libcpp.string cimport string
from libcpp cimport bool

cdef extern from "<iostream>" namespace "std":
    cdef cppclass ostream:
        ostream& write(const char*, int) except +
    ostream cout

cdef extern from "../MCTDH/ControlParameters.h":
    cdef cppclass ControlParameters:
        ControlParameters() except +
        void Initialize(string, ostream&)
        double Eps_CMF()
        double Regularization()

cdef extern from "../MCTDH/mctdhBasis.h":
    cdef cppclass mctdhBasis:
        mctdhBasis() except +
        void Initialize(string, ControlParameters&)
        double RegularizationDensity()
        size_t nPhysNodes()
        const mctdhNode & MCTDHNode(size_t i)

cdef extern from "../MCTDH/mctdhNode.h":
    cdef cppclass mctdhNode:
        mctdhNode() except +
        void info(ostream&)
        bool IsBottomlayer()

cdef class PyControlParameters:
    cdef ControlParameters *thisptr
    def __cinit__(self):
        self.thisptr = new ControlParameters()
    def __dealloc__(self):
        del self.thisptr
    def PyInitialize(self, a):
            self.thisptr.Initialize(a, cout)
    def PyEps_CMF(self):
        return self.thisptr.Eps_CMF()
    cdef ControlParameters GetC(self):
        return self.thisptr

cdef class PymctdhBasis:
  cdef mctdhBasis *thisptr
  def __cinit__(self):
      self.thisptr = new mctdhBasis()
  def __dealloc__(self):
      del self.thisptr
  cpdef PyInitialize(self, filename, para, config):
      cdef ControlParameters* confc
      confc = <ControlParameters*> config.GetC()
      self.thisptr.Initialize(filename, confc[0])
  cpdef PyRegularizationDensity(self):
      return self.thisptr.RegularizationDensity()
  cpdef PynPhysNodes(self):
      return self.thisptr.nPhysNodes()


#cdef ControlParameters_factory(PyControlParameters *ptr):
#    return ptr
