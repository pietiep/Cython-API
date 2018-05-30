import mctdh

config = mctdh.controlParameters()
config.initialize('mctdh.config')

basis = mctdh.MctdhBasis()
basis.initialize('CH3g1.txt', config)

#node = mctdh.MctdhNode()
#tdim = mctdh.Tdim()

for i in range(11):
    node = basis.MCTDHnode(i)
    node.Info()

    #phys = mctdh.PhysCoor()
    #phys = node.phys_coor()
    #print phys.mode()

    tdim = node.t_dim()
    print tdim.GetnTensor()
    if node.Bottomlayer() == True:
        print 'True'
        print tdim.active(0)
    else:
        print 'False'
#    print tdim.active()
