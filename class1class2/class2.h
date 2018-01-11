using namespace std;
class class2
{
public:
    double val2;
    class2();
    ~class2();

    void Initialize(class1 & class1_ob);
    void displayVal();
    double GetVal()const {return val2;}
};
