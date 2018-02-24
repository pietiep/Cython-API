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

cdef ControlParameters config
cdef mctdhBasis basis
cdef const mctdhNode * node

cdef ControlParameters PyControlParameters(string para):
    cdef ControlParameters config
    config.Initialize(para, cout)
    return config

cdef  void PymctdhNode(para, filename):
      config.Initialize(para, cout)
      basis.Initialize(filename, config)
      node = &(basis.MCTDHNode(1))
      node.info(cout)
      print node.IsBottomlayer()


cdef class PymctdhBasis:
  cdef mctdhBasis *thisptr
  def __cinit__(self):
      self.thisptr = new mctdhBasis()
  def __dealloc__(self):
      del self.thisptr
  cpdef PyInitialize(self, filename, para, config):
#      config = PyControlParameters(para)

      self.thisptr.Initialize(filename, (config.thisptr)[0])
  cpdef PyRegularizationDensity(self):
      return self.thisptr.RegularizationDensity()
  cpdef PynPhysNodes(self):
      return self.thisptr.nPhysNodes()
#
#cdef class PyMctdhNode:
#  cdef mctdhNode * thisptr
#  def __cinit__(self):
#      self.thisptr = new mctdhNode()
#  def __dealloc__(self):
#      del self.thisptr
#  cpdef PyInitialize(filename, para):
#      basis = PymctdhNode(para, filename)

cpdef PyPymctdhNode(filename, para):
    PymctdhNode(para, filename)
