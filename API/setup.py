from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import os, shutil

try:
    shutil.rmtree('build')
    os.remove('mctdh.so')
    os.remove('mctdh.cpp')
    print 'build is removed'

except OSError:
    pass

ext_modules = [Extension("mctdh",
                     ["mctdh.pyx"],
                     language='c++',
                     extra_objects=["../build/bin/libMCTDHlib.a", "../build/bin/libQD.a"],
#                     extra_compile_args=["-std=c++11"]
                     extra_compile_args=["-std=c++11", "-I../MCTDH", "-I../MCTDH/oSQR", "-I../QDlib", "-I../Hamiltonians"]
                     )]

setup(
  name = 'mctdh',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)
