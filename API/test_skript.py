# coding: utf-8
get_ipython().magic(u'll ')
import mctdh
config = mctdh.PyControlParameters()
config.PyInitialize('mctdh.config')
basis = mctdh.PymctdhBasis()
basis.PyInitialize('CH3g1.txt', config)
config.PyEps_CMF()
basis.PyRegularizationDensity()
get_ipython().magic(u'save test_skript.py 1-9')
