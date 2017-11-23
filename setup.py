from distutils.core import setup, Extension
from Cython.Build import cythonize

setup(ext_modules = cythonize(Extension(
         "rect",
         sources=["rect.pyx", "Rectangle.cpp"],
        language="c++"
    )))
