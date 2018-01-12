from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import os, shutil

print "damn"
try:
    shutil.rmtree('build')
    os.remove('testclass.so')
    os.remove('testclass.cpp')
    print 'build is removed'

except OSError:
    pass

ext_modules = [Extension("testclass",
                     ["testclass.pyx", "class1.cpp", "class2.cpp"],
                     language='c++'
                     )]

setup(
  name = 'testclass',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)
