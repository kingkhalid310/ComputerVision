import numpy as np
import math
import time

def cython_conversion( int[:,:,:] image ):
    cdef int[:,:,:] img = image
    Zeros = np.zeros( (img.shape[0], img.shape[1]), dtype = np.intc) 

    cdef int[:,:] img_iter = Zeros
    cdef i, j

    startTime4 = time.time()
    g = np.array([[1, 2, 1],[2, 4, 2],[1, 2, 1]], dtype=float) / 16
    vmax = img_iter.shape[0]
    wmax = img_iter.shape[1]
    smax = g.shape[0]
    tmax = g.shape[1]
    smid = smax // 2
    tmid = tmax // 2
    xmax = vmax + 2*smid
    ymax = wmax + 2*tmid
    # Allocate result image.
    h = np.zeros((xmax, ymax), dtype=f.dtype)
    # Do convolution
    for x in range(xmax):
        for y in range(ymax):
            # Calculate pixel value for h at (x,y). Sum one component
            # for each pixel (s, t) of the filter g.
            s_from = max(smid - x, -smid)
            s_to = min((xmax - x) - smid, smid + 1)
            t_from = max(tmid - y, -tmid)
            t_to = min((ymax - y) - tmid, tmid + 1)
            value = 0
            for s in range(s_from, s_to):
                for t in range(t_from, t_to):
                    v = x - smid + s
                    w = y - tmid + t
                    value += g[smid - s, tmid - t] * f[v, w]
            h[x, y] = value
            
    endTime4 = time.time()

    # return (endTime4 - startTime4)
    return h