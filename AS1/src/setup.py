from distutils.core import setup
from Cython.Build import cythonize

setup(
	name = "Conversion Cython", 
	ext_modules = cythonize("rgb2gray_cython_KS.pyx"),  
)