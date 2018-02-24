import mctdh

config = mctdh.controlParameters()
config.initialize('mctdh.config')
basis = mctdh.MctdhBasis()
basis.initialize('CH3g1.txt', config)
node = mctdh.MctdhNode()

bottom_list = []

def getBottomlayer():
    for i in range(basis.NmctdhNodes()):
        node = basis.MCTDHnode(i)
        if node.Bottomlayer() == True:
            bottom_list.append(i)
    return bottom_list

layer_list = []

def nlayer(i):
    """Recursion function that determines the layer depth of the tree"""
    node = basis.MCTDHnode(i)
    layer_list.append(i)
    if node.Toplayer() == False:
        return nlayer(node.up().address())
    new_list = list(layer_list) #copy instead of reference
    del layer_list[:]
    return new_list

layer_matr = [nlayer(b_) for b_ in bottom_list]
#print layer_matr
