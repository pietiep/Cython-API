#include "class1.h"
#include "class2.h"
#include <iostream>

double val2;

class2::class2(){}
class2::~class2(){}

void class2::Initialize(class1 & class1_ob)
{val2 = class1_ob.GetVal();}

void class2::displayVal()
{cout << "val from class2 = " << val2 << endl;}
