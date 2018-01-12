#pragma once

using namespace std;
class class1
{
public:
    class1();
    ~class1();

    void displayVal();
    double GetVal()const {return val;}
protected:
    double val;
};
