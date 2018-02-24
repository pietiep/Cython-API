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
        size_t nmctdhNodes()

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
        const mctdhNode & Down(size_t i)
        int nChildren()
        int Address()
        const PhysicalCoordinate& PhysCoord()
        TensorDim TDim()

cdef extern from "../MCTDH/PhysicalCoordinate.h":
    cdef cppclass PhysicalCoordinate:
        PhysicalCoordinate() except +
        size_t Mode()

cdef extern from "../QDlib/TensorDim.h":
    cdef cppclass TensorDim:
        TensorDim() except +
        size_t getntensor()
        size_t Active(size_t k)

cdef class controlParameters:
    cdef ControlParameters *control_ptr
    def __cinit__(self):
        self.control_ptr = new ControlParameters()
    def __dealloc__(self):
        del self.control_ptr
    def initialize(self, a):
            self.control_ptr.Initialize(a, cout)
    def eps_CMF(self):
        return self.control_ptr.Eps_CMF()
    def regularization(self):
        return self.control_ptr.Regularization()

cdef ControlParameters * PyToCpp(controlParameters py_obj):
    return py_obj.control_ptr

cdef class MctdhBasis:
  cdef mctdhBasis *basis_ptr
  def __cinit__(self):
      self.basis_ptr = new mctdhBasis()
  def __dealloc__(self):
      del self.basis_ptr
  def initialize(self, filename, py_config_obj):
      cdef ControlParameters * new_config_ptr = PyToCpp(py_config_obj)
      self.basis_ptr.Initialize(filename, new_config_ptr[0])
  def regularizationDensity(self):
      return self.basis_ptr.RegularizationDensity()
  def NPhysNodes(self):
      return self.basis_ptr.nPhysNodes()
  cpdef MctdhNode MCTDHnode(self, i):
      cdef const mctdhNode * node = &(self.basis_ptr.MCTDHNode(i))
      return PyMctdhNode_factory(node)
  def NmctdhNodes(self):
      return self.basis_ptr.nmctdhNodes()

cdef object PyMctdhNode_factory(const mctdhNode *ptr):
      cdef MctdhNode py_obj = MctdhNode()
      py_obj.node_ptr = ptr
      return py_obj

cdef class MctdhNode:
  cdef const mctdhNode * node_ptr
  def Info(self):
      self.node_ptr.info(cout)
  def Bottomlayer(self):
      return self.node_ptr.IsBottomlayer()
  def Nnodes(self):
      return self.node_ptr.nNodes()
  def NmctdhNodes(self):
      return self.node_ptr.nmctdhNodes()
  def NPhysNodes(self):
      return self.node_ptr.nPhysNodes()
  def Toplayer(self):
      return self.node_ptr.IsToplayer()
  def up(self):
      cdef const mctdhNode * node_up = &(self.node_ptr.Up())
      return PyMctdhNode_factory(node_up)
  def down(self, i):
      cdef const mctdhNode * node_down = &(self.node_ptr.Down(i))
      return PyMctdhNode_factory(node_down)
  def NChildren(self):
      return self.node_ptr.nChildren()
  def address(self):
      return self.node_ptr.Address()
  cpdef PhysCoor phys_coor(self):
      cdef const PhysicalCoordinate * phys = &(self.node_ptr.PhysCoord())
      return PyPhysCoor_factory(phys)
  #cpdef Tdim t_dim(self):
      #cdef TensorDim * dim = self.node_ptr.TDim()
      #return Tdim_factory(dim)
      #return self.node_ptr.TDim()


cdef object PyPhysCoor_factory(const PhysicalCoordinate * ptr):
    cdef PhysCoor py_obj = PhysCoor()
    py_obj.phys_ptr = ptr
    return py_obj

cdef object Tdim_factory(TensorDim * ptr):
    cdef Tdim py_obj = Tdim()
    py_obj.tdim_ptr = ptr
    return py_obj

cdef class PhysCoor:
  cdef const PhysicalCoordinate * phys_ptr
  def mode(self):
    return self.phys_ptr.Mode()

cdef class Tdim:
  cdef TensorDim * tdim_ptr
