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
        size_t nNodes()
        size_t nmctdhNodes()
        size_t nPhysNodes()
        void info(ostream&)
        bool IsBottomlayer()
        bool IsToplayer()
        const mctdhNode & Up()
        const mctdhNode & down()
        int nChildren()
        int Address()

cdef extern from "../QDlib/TensorDim.h":
    cdef cppclass TensorDim:
        TensorDim() except +

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
    def PyRegularization(self):
        return self.control_ptr.Regularization()

cdef ControlParameters * PyToCpp(PyControlParameters py_obj):
    return py_obj.control_ptr

cdef class PymctdhBasis:
  cdef mctdhBasis *basis_ptr
  def __cinit__(self):
      self.basis_ptr = new mctdhBasis()
  def __dealloc__(self):
      del self.basis_ptr
  def PyInitialize(self, filename, py_config_obj):
      cdef ControlParameters * new_config_ptr = PyToCpp(py_config_obj)
      self.basis_ptr.Initialize(filename, new_config_ptr[0])
  def PyRegularizationDensity(self):
      return self.basis_ptr.RegularizationDensity()
  def PynPhysNodes(self):
      return self.basis_ptr.nPhysNodes()
  cpdef PyMctdhNode PyMCTDHNode(self, i):
      cdef const mctdhNode * node = &(self.basis_ptr.MCTDHNode(i))
      return PyMctdhNode_factory(node)

cdef object PyMctdhNode_factory(const mctdhNode *ptr):
      cdef PyMctdhNode py_obj = PyMctdhNode()
      py_obj.node_ptr = ptr
      return py_obj

cdef class PyMctdhNode:
  cdef const mctdhNode * node_ptr
  def PyInfo(self):
      self.node_ptr.info(cout)
  def PyIsBottomlayer(self):
      return self.node_ptr.IsBottomlayer()
