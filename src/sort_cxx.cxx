#include <iostream>
extern "C" {
    void std_sort_wrapper(float* array, int nelems) {
        printf("C++ %4d %E", nelems, array[50]);
        std::cout << std::endl;
    }

}