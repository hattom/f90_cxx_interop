#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include "sort_cxx.hxx"

#define PRINT_ID 0
extern "C" {
    void std_test_wrapper(float* &array, const int nelems) {
        printf("C++ %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }
    void std_test_wrapper_ri(float tmpval, const int nelems) {
        printf("C++ ri %4d %E", nelems, tmpval);
        std::cout << std::endl;
    }

    void std_test_wrapper_fai(float *array, const int nelems) {
        printf("C++ fai %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }

    void std_test_wrapper_fai_2(float* &array, const int nelems) {
        printf("C++ fai 2 %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }

    void std_sort_wrapper_fai(float *array, const int nelems) {
        std::vector<float> vec1;
        vec1.assign(array, array+nelems);
        std::sort(vec1.begin(), vec1.end());
        printf("C++ sorta %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
        printf("C++ sorta %4d %E", nelems, vec1[PRINT_ID]);
        std::cout << std::endl;
    }

    void std_sort_wrapper_fai_simple(float *array, const int nelems) {
        std::sort(array, array+nelems);
        printf("C++ sortb %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }
    void std_sort_wrapper(float* &array, const int nelems) {
        std::sort(array, array+nelems);
        printf("C++ sortc %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }

    void std_sort_wrapper_fai_2(float* &array, const int nelems) {
        std::sort(array, array+nelems);
        printf("C++ sortd %4d %E", nelems, array[PRINT_ID]);
        std::cout << std::endl;
    }
}
