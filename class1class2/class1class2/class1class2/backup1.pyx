cdef extern from "class1.h":
    cdef cppclass class1:
        class1() except +
        void displayVal()
        double GetVal()

cdef extern from "class2.h":
    cdef cppclass class2:
        class2() except +
        void Initialize(class1&)
        void displayVal()
        double GetVal()

cdef class PyClass1:
    cdef class1 * class1_ptr
    def __cinit__(self):
        self.class1_ptr = new class1()
    def __dealloc__(self):
        del self.class1_ptr
    def PyDisplayVal(self):
        self.class1_ptr.displayVal()
    def PyGetVal(self):
        return self.class1_ptr.GetVal()

cdef class PyClass2:
    cdef class2 * class2_ptr
    def __cinit__(self):
        self.class2_ptr = new class2()
    def __dealloc__(self):
        del self.class2_ptr
    def PyIntialize(self, PyClass1 PyClass1_ob):
        cdef class1 * class1_new_ptr #= new class1()
        class1_new_ptr = PyToCpp(PyClass1_ob)
        self.class2_ptr.Initialize(class1_new_ptr[0])
    def PyDisplayVal(self):
        self.class2_ptr.displayVal()
    def PyGetVal(self):
        return self.class2_ptr.GetVal()


cdef class1* PyToCpp(PyClass1 py_ob):
#    cdef class1 * class1_ob = new class1()
    class1_ob = py_ob.class1_ptr
    return py_ob.class1_ptr
#    return class1_ob
