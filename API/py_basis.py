import mctdh

config = mctdh.controlParameters()
config.initialize('mctdh.config')

basis = mctdh.MctdhBasis()
basis.initialize('CH3g1.txt', config)

node = mctdh.MctdhNode()
node = basis.MCTDHnode(0)
node.Info()

phys = mctdh.PhysCoor()
phys = node.phys_coor()
print phys.mode()
