cdef extern from "class1.h":
    cdef cppclass class1:
        class1() except +
        void displayVal()
        double GetVal()

cdef class PyClass1:
    cdef class1 * thisptr
    def __cinit__(self):
        self.thisptr = new class1()
    def __dealloc__(self):
        del self.thisptr
    def PyDisplayVal(self):
        self.thisptr.displayVal()
    def PyGetVal(self):
        return self.thisptr.GetVal()
