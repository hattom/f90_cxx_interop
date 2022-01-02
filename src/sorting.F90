! Define FFTW to use FFTW for its c-style malloc wrapper
! Define REPROD to fix the random number seed for testing
! Define REPROD2 to fix the "random number" to incrementing whole numbers

#define PRINT_ID 0

module sorting
  use iso_c_binding, only: C_INT, C_PTR, C_FLOAT, C_LOC, C_SIZE_T
  use sort_cxx_interface
  implicit none

  real, allocatable, target, dimension(:) :: f_data
  type(C_PTR) :: c_data
#ifdef FFTW
  type(C_PTR) :: c_fftw
  real(kind=C_FLOAT), dimension(:), pointer :: f_fftw_data
#endif
  integer :: nelems

  contains

#ifdef FFTW
    subroutine fftw_alloc
      use, intrinsic :: iso_c_binding
      include 'fftw3.f03'
      c_fftw = fftwf_alloc_real(int(nelems, C_SIZE_T))
      call c_f_pointer(c_fftw, f_fftw_data, [nelems])
    end subroutine fftw_alloc
#endif
    subroutine sorting_init(nelems_)
      integer, intent(in), optional :: nelems_
      if (present(nelems_)) then
        nelems = nelems_
      else
        nelems = 1000
      endif
      allocate(f_data(nelems))
      c_data = c_loc(f_data)

#ifdef FFTW
      call fftw_alloc()
#endif
      call sorting_reset()
    end subroutine sorting_init

    subroutine sorting_reset
      logical, save :: first=.False.
      integer, dimension(8), save :: seed
#ifdef REPROD
      if (first) then
        call random_seed(put=[1,1,1,1,1,1,1,1,1,1,1])
      endif
#endif
      if (first) then
        call random_seed(get=seed)
        first = .false.
      else
        call random_seed(put=seed)
      endif
      call random_number(f_data(:))
#ifdef REPROD2
      block
        integer :: ielem
        do ielem=1,nelems
          f_data(ielem) = 1000 - 1.0 * ielem
        enddo
      end block
#endif
#ifdef FFTW
      f_fftw_data(:) = f_data(:)
#endif
    end subroutine sorting_reset

    subroutine run_tests
      call f90_test_check()
      call std_test_wrapper_ri(f_data(PRINT_ID+1), nelems)
      call std_test_wrapper(c_data, nelems)
      print *, 'min', minval(f_data)
#ifdef FFTW
      print *, 'min', minval(f_fftw_data)
      call std_test_wrapper_fai(c_fftw, nelems)
      call std_test_wrapper_fai_2(f_fftw_data, nelems)
      call sorting_reset
      call std_sort_wrapper_fai(c_fftw, nelems)
      print *, 'a', f_fftw_data(PRINT_ID+1)
      call sorting_reset
      call std_sort_wrapper_fai_simple(c_fftw, nelems)
      print *, 'b', f_fftw_data(PRINT_ID+1)
#endif
      call std_sort_wrapper(c_data, nelems)
      print *, 'c', f_data(PRINT_ID+1)
      call std_sort_wrapper_fai_2(f_data, nelems)
      print *, 'd', f_data(PRINT_ID+1)
    end subroutine run_tests

    subroutine f90_test_check()
      print *, 'F90 3', nelems, f_data(PRINT_ID+1)
    end subroutine f90_test_check

end module sorting