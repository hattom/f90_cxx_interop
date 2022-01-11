extern "C" {
    void std_test_wrapper(float* &array, const int nelems);
    void std_test_wrapper_ri(float tmpval, const int nelems);
    void std_test_wrapper_fai(float *array, const int nelems);
    void std_test_wrapper_fai_2(float* &array, const int nelems);
    void std_sort_wrapper_fai(float *array, const int nelems);
    void std_sort_wrapper_fai_simple(float *array, const int nelems);
    void std_sort_wrapper(float* &array, const int nelems);
    void std_sort_wrapper_fai_2(float* &array, const int nelems);
}
