#include "class1.h"
#include <iostream>

double val;

class1::class1(): val(1.5){}
class1::~class1(){}

void class1::displayVal()
{cout << "val from class1 = " << val << endl;}
