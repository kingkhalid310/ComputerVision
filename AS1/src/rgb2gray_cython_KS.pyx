import numpy as np
import math
import time

def cython_conversion( int[:,:,:] image ):
    cdef int[:,:,:] img = image
    Zeros = np.zeros( (img.shape[0], img.shape[1]), dtype = np.intc) 

    cdef int[:,:] img_gray_iter = Zeros
    cdef i, j

    startTime4 = time.time()
    for i in range(0, img.shape[0], 1):
        for j in range(0, img.shape[1], 1):
            img_gray_iter[i, j] = round(0.2989*img[i, j, 0])
            img_gray_iter[i, j] += round(0.5870*img[i, j, 1] )
            img_gray_iter[i, j] += round(0.1140*img[i, j, 2])
            
    endTime4 = time.time()

    return (endTime4 - startTime4)