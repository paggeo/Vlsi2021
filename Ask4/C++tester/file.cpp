#include <iostream>
#include <fstream>

using std::cout; using std::cerr;
using std::endl; using std::string;
using std::ifstream;
using std::ofstream;

int main()
{
    string filename("input.txt");
    string filename1("input_new.txt");
    int number;

    ifstream input_file(filename);
    if (!input_file.is_open()) {
        cerr << "Could not open the file - '"
             << filename << "'" << endl;
        return EXIT_FAILURE;
    }

ofstream output_file(filename1);
    if (!output_file.is_open()) {
        cerr << "Could not open the file - '"
             << filename1 << "'" << endl;
        return EXIT_FAILURE;
    }
int counter =0;
int N=8;
    output_file<<N<<endl;
    while (input_file >> number) {
        if (counter % N == 0 and counter!=0 )  {output_file << endl;}
        output_file << number << " ";
        counter++;
    }
    output_file << endl;
    input_file.close();
    output_file.close();


    return EXIT_SUCCESS;
}