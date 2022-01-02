#include <iostream>
#include <stdio.h>
extern "C" {
    void std_test_wrapper(float* &array, int nelems) {
        printf("C++ %4d %E", nelems, array[50]);
        std::cout << std::endl;
    }
    void std_test_wrapper_ri(float tmpval, int nelems) {
        printf("C++ ri %4d %E", nelems, tmpval);
        std::cout << std::endl;
    }

    void std_test_wrapper_fai(float *array, int nelems) {
        printf("C++ fai %4d %E", nelems, array[50]);
        std::cout << std::endl;
    }

    void std_test_wrapper_fai_2(float* &array, int nelems) {
        printf("C++ fai 2 %4d %E", nelems, array[50]);
        std::cout << std::endl;
    }
}