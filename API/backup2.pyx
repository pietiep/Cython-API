from cython.operator cimport dereference as deref
from libcpp.memory cimport unique_ptr
from libcpp.string cimport string

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
        mctdhNode MCTDHNode(size_t i)

cdef extern from "../MCTDH/mctdhNode.h":
    cdef cppclass mctdhNode:
        mctdhNode() except +

cdef ControlParameters config
cdef mctdhBasis basis

cdef ControlParameters PyControlParameters(string para):
    cdef ControlParameters config
    config.Initialize(para, cout)
    return config

cdef mctdhBasis* PymctdhBasis_cfun(string filename, ControlParameters config):
    cdef mctdhBasis* basis
    basis.Initialize(filename, config)
    return basis

cdef void PymctdhNode(para, filename, size_t i, mctdhNode node):
      config.Initialize(para, cout)
      basis.Initialize(filename, config)
      node = basis.MCTDHNode(i)

cdef class PymctdhBasis:
  cdef mctdhBasis *thisptr
  def __cinit__(self):
      self.thisptr = new mctdhBasis()
  def __dealloc__(self):
      del self.thisptr
  cpdef PyInitialize(self, filename, para):
      config = PyControlParameters(para)
      self.thisptr.Initialize(filename, config)
  cpdef PyRegularizationDensity(self):
      return self.thisptr.RegularizationDensity()
  cpdef PynPhysNodes(self):
      return self.thisptr.nPhysNodes()
#  cdef const mctdhNode& PymctdhNode(self, size_t i):
#      pass
#      cdef const mctdhNode& node
#      node = self.thisptr.MCTDHNode(i)

#cdef class PymctdhNode:
#  cdef mctdhNode *thisptr
#  def __cinit__(self):
#      self.thisptr = new mctdhNode()
#  def __dealloc__(self):
#      del self.thisptr
#  cpdef PyInitialize(self, filename, para):
#      config = PyControlParameters(para)
#      basis = PymctdhBasis_cfun(filename, config)
#      cdef const mctdhNode* node
#      node = basis.MCTDHNode(1);
