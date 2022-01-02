! Define FFTW to use FFTW for its c-style malloc wrapper
! Define REPROD to fix the random number seed for testing
! Define REPROD2 to fix the "random number" to incrementing whole numbers

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
#ifdef REPROD
      call random_seed(put=[1,1,1,1,1,1,1,1,1,1,1])
#endif
      c_data = c_loc(f_data)
      call random_number(f_data(:))
#ifdef REPROD2
      block
        integer :: ielem
        do ielem=1,nelems
          f_data(ielem) = 1.0 * ielem
        enddo
      end block
#endif

#ifdef FFTW
      call fftw_alloc()
      f_fftw_data(:) = f_data(:)
#endif
    end subroutine sorting_init

    subroutine run_tests
      call f90_test_check()
      call std_test_wrapper_ri(f_data(51), nelems)
      call std_test_wrapper(c_data, nelems)
#ifdef FFTW
      call std_test_wrapper_fai(c_fftw, nelems)
#endif
      call std_test_wrapper_fai_2(f_fftw_data, nelems)
    end subroutine run_tests

    subroutine f90_test_check()
      print *, 'F90 3', nelems, f_data(51)
    end subroutine f90_test_check

end module sorting