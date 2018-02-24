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

cdef ControlParameters config
cdef mctdhBasis basis

cdef ControlParameters Pyconverter(string para):
    cdef ControlParameters config
    config.Initialize(para, cout)
#    print config.Eps_CMF()
#    print config.Regularization()
#    cdef mctdhBasis basis
#    basis.Initialize(tree, config)
#    print basis.RegularizationDensity()
    return config

#Pyconverter('mctdh.config', 'CH3g1.txt')

#cdef class PyControlParameters:
#    cdef ControlParameters *thisptr
#    def __cinit__(self):
#        self.thisptr = new ControlParameters()
#    def __dealloc__(self):
#        del self.thisptr
#    def PyInitialize(self, a):
#            self.thisptr.Initialize(a, cout)
#    def PyEps_CMF(self):
#        return self.thisptr.Eps_CMF()

cdef class PymctdhBasis:
  cdef mctdhBasis *thisptr
  def __cinit__(self):
      self.thisptr = new mctdhBasis()
  def __dealloc__(self):
      del self.thisptr
  cpdef PyInitialize(self, filename, para):
      config = Pyconverter(para)
      self.thisptr.Initialize(filename, config)
  cpdef PyRegularizationDensity(self):
      return self.thisptr.RegularizationDensity()
