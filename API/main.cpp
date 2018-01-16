#include "stdafx.h"
#include "MCTDH.h"
#include "Eigenstates.h"
//#include "CH3Potential.h"
//#include "CH3Quasiexact.h"
#include"Hamiltonians.h"

#ifdef _MSC_VER
  #define M_PI 3.14159265359
#endif

int CH3QuasiExact();
int example();

constexpr double fs = 41.362;
int main()
{
//	NOCl_PhotodissociationSpectrum();
//	NOClCDVROverlaps();
//	ModelHamiltonian();
//	CH3Eigenstates();
//	CH3QuasiExact();
    example();
//	CH3IterativeDiag();
//	CDVRmodel();
//	optimizedCDVRmodel();
//	SpinBoson();
//	HarmonicBath();
//	Hubbard();
//	CHD3_Eigenstates();
//	TS_HCHD3_Eigenstates();
//	CH5PJ0();
	return 0;
}

int example()
{
    string input = "CH3g1.txt";
    string config_file = "mctdh.config";

    ControlParameters config;
    config.Initialize(config_file, cout);

    mctdhBasis basis;
    basis.Initialize(input, config);

    cout << "The number of physical nodes in the Basis ist: " << basis.nPhysNodes() << "\n";

    size_t sumChild = 0;
    size_t parentspf = 0;

    for (size_t i=0; i<basis.nmctdhNodes(); i++)
    {
        const mctdhNode& node=basis.MCTDHNode(i);
        if (!node.IsBottomlayer())
        {
//        node.info();
        cout<<i<<endl;
        const TensorDim& TDim = node.TDim();
        cout << "n States(Parent) = " << TDim.getntensor() << "\n";
        parentspf = TDim.getntensor();
        sumChild = 0;
        }



//        {
//              const  mctdhNode& child = node.Down(j);
////                child.info();
//                const TensorDim& ChildTDim = child.TDim();
//                bla = ChildTDim.getntensor();
//                cout << "n States(Child) = " << ChildTDim.getntensor() << "\n";
//                sumChild = sumChild + bla;
//        }
//                cout << "SumChild = " << sumChild + parentspf << "\n";
//        }
////        cout<<node.nNodes()<<endl;
////        cout<<node.nmctdhNodes()<<endl;
////        cout<<node.nPhysNodes()<<endl;
////        cout<<node.NodeType()<<endl;
////        cout<<node.ChildIdx()<<endl;
////        cout<<node.nChildren()<<endl;
        cout << "node " << i << " has " << node.nChildren() << " children.\n";
////        // Lasse dir Referenz auf die TensorDim geben
////        // Unterscheidung was man macht, falls "node" bottomlayer ist, oder nicht.
      if (node.IsBottomlayer())
        {
//        node.info();
        cout<<i<<endl;
        const TensorDim& TDim = node.TDim();
        cout << "n States(Parent) = " << TDim.getntensor() << "\n";
        cout << "n States(Active) = " << TDim.Active(0) << "\n";
        cout << "Sum of Parent/Active = "<<TDim.getntensor() + TDim.Active(0) << "\n";


        }
        else
        {
        }
      }
}
//        // Unterscheidung was man macht, falls "node" toplayer ist, oder nicht.
//        if (node.IsToplayer())
//        {
//        }else
//        {
//        }
//        // Lasse dir den Parent-node geben
//        if (!node.IsToplayer())
//        {
//            const mctdhNode& parent=node.Up();
//        }
//
//        // Swipe durch alle Children des aktuellen Knoten
//                TensorDim childTDim = child.TDim();



int CH3QuasiExact()
{
	CH3Quasiexact H;
	CH3Potential V;
	H.InitCDVR(V);

	// Input file for basis
	string file = "../data/CH3/CH3g3.txt";
	string config = "../data/CH3/mctdh.config";
	string log = "../data/CH3/mctdh.log";
	string folder = "../data/CH3/results";

	// MCTDH
	MCTDH mctdh;
	mctdh.Initialize(file, &H, cout, log, config);

	IntegratorWorkParameters job;
	job.Initialize(0, 20000., 1.5, 100., folder, false, false);

	mctdh.CalculateEigenstates(job, cout);

	return 0;
}
