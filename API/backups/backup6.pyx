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
    cdef ControlParameters *control_ptr
    def __cinit__(self):
        self.control_ptr = new ControlParameters()
    def __dealloc__(self):
        del self.control_ptr
    def PyInitialize(self, a):
            self.control_ptr.Initialize(a, cout)
    def PyEps_CMF(self):
        return self.control_ptr.Eps_CMF()

cdef class PymctdhBasis:
  cdef mctdhBasis *basis_ptr
  cdef ControlParameters *config_ptr
  def __cinit__(self):
      self.basis_ptr = new mctdhBasis()
      self.config_ptr = new ControlParameters()
  def __dealloc__(self):
      del self.basis_ptr
      del self.config_ptr
  cpdef PyInitialize(self, filename, para):
      self.config_ptr.Initialize(para, cout)
      self.basis_ptr.Initialize(filename, self.config_ptr[0])
  cpdef PyRegularizationDensity(self):
      return self.basis_ptr.RegularizationDensity()
  cpdef PynPhysNodes(self):
      return self.basis_ptr.nPhysNodes()
