#include "class2.h"
#include <iostream>
using namespace std;
int main()
{
  class1 class1_ob;
  class1_ob.displayVal();
  cout << class1_ob.GetVal() << '\n';

  class2 class2_ob;
  class2_ob.displayVal();
  class2_ob.Initialize(class1_ob);
  class2_ob.displayVal();
  cout << class2_ob.GetVal() << '\n';
}
