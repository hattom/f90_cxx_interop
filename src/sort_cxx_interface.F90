module sort_cxx_interface
  use iso_c_binding
    interface
    subroutine std_test_wrapper_ri(real1, int1) bind(C)
      ! pass single fortran c_float (value) to c "float"
      import :: C_INT, C_FLOAT
      real(kind=C_FLOAT), intent(in), value ::  real1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_test_wrapper_ri

    subroutine std_test_wrapper(array, n) bind(C)
      ! pass fortran array c_ptr (reference) to c "float* &array"
      import :: C_INT, C_PTR
      type(C_PTR), intent(inout) ::  array
      integer(kind=C_INT), intent(in), value ::  n
    end subroutine std_test_wrapper

    subroutine std_test_wrapper_fai(realarr1, int1) bind(C)
      ! pass fortran array c_ptr (value) to c "float* array"
      import :: C_INT, C_PTR
      type(C_PTR), intent(in), value ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_test_wrapper_fai

    subroutine std_test_wrapper_fai_2(realarr1, int1) bind(C)
      ! pass fortran array "real dimension(:)" (reference) to c "float* &array"
      import :: C_INT, C_FLOAT
      real(kind=C_FLOAT), dimension(:), intent(in) ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_test_wrapper_fai_2

    subroutine std_sort_wrapper_fai_simple(realarr1, int1) bind(C)
      ! pass fortran array c_ptr (value) to c "float* array"
      import :: C_INT, C_PTR
      type(C_PTR), intent(in), value ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_sort_wrapper_fai_simple

    subroutine std_sort_wrapper_fai(realarr1, int1) bind(C)
      ! pass fortran array c_ptr (value) to c "float* array"
      import :: C_INT, C_PTR
      type(C_PTR), intent(in), value ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_sort_wrapper_fai

    subroutine std_sort_wrapper(array, n) bind(C)
      ! pass fortran array c_ptr (reference) to c "float* &array"
      import :: C_INT, C_PTR
      type(C_PTR), intent(inout) ::  array
      integer(kind=C_INT), intent(in), value ::  n
    end subroutine std_sort_wrapper

    subroutine std_sort_wrapper_fai_2(realarr1, int1) bind(C)
      ! pass fortran array "real dimension(:)" (reference) to c "float* &array"
      import :: C_INT, C_FLOAT
      real(kind=C_FLOAT), dimension(:), intent(in) ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_sort_wrapper_fai_2

  end interface
end module sort_cxx_interface