from distutils.core import setup
from Cython.Build import cythonize

setup(
	name = "Conversion Cython", 
	ext_modules = cythonize("cython_smoothing_ks.pyx"),  
)