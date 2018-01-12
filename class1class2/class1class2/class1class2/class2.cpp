#include "class2.h"
#include <iostream>

class2::class2():val(0){}
class2::~class2(){}

void class2::Initialize(class1 & class1_ob)
{
  val = class1_ob.GetVal();
}

void class2::displayVal()
{
  cout << "val from class2 = " << val << endl;
}
