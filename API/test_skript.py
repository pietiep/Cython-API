# coding: utf-8
import mctdh
config = mctdh.controlParameters()
config.initialize('mctdh.config')
basis = mctdh.MctdhBasis()
basis.initialize('CH3g1.txt', config)
node = mctdh.MctdhNode()

bottom_list = []

for i in range(basis.NmctdhNodes()):
    node = basis.PyMCTDHNode(i)
    if node.Bottomlayer() == True:
        bottom_list.append(i)

print bottom_list

def nlayer(i):
    node = basis.PyMCTDHNode(i)
    if node.Toplayer() == False:
        return node.up().address()

nlayer(0)
#for b_ in bottom_list:
#    print nlayer(b_)
