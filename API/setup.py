from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [Extension("mctdh",
                     ["mctdh.pyx"],
                     language='c++',
#                     library_dirs=['../build/bin'],
 #                    libraries=['libMCTDHlib.a'],
                     extra_objects=["../build/bin/libMCTDHlib.a"],
                     extra_compile_args=["-std=c++11"]
                     )]

setup(
  name = 'mctdh',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)
