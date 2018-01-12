#pragma once
#include "class1.h"

using namespace std;
class class2
{
public:
    class2();
    ~class2();

    void Initialize(class1& class1_ob);
    void displayVal();

    double GetVal()const {return val;}
//    class3& GetVal3()
  protected:
    double val;
};
