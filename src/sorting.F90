! Define FFTW to use FFTW for its c-style malloc wrapper
! Define REPROD to fix the random number seed for testing

module sorting
  use iso_c_binding, only: C_INT, C_PTR, C_FLOAT, C_LOC, C_SIZE_T
  implicit none

  interface
    subroutine std_sort_wrapper(array, n) bind(C)
      import :: C_INT, C_PTR
      type(C_PTR), intent(inout) ::  array
      integer(kind=C_INT), intent(in), value ::  n
    end subroutine std_sort_wrapper

    subroutine std_sort_wrapper_ri(real1, int1) bind(C)
      import :: C_INT, C_FLOAT
      real(kind=C_FLOAT), intent(in), value ::  real1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_sort_wrapper_ri

    subroutine std_sort_wrapper_fai(realarr1, int1) bind(C)
      import :: C_INT, C_PTR
      type(C_PTR), intent(in), value ::  realarr1
      integer(kind=C_INT), intent(in), value ::  int1
    end subroutine std_sort_wrapper_fai
  end interface

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

#ifdef FFTW
      call fftw_alloc()
      f_fftw_data(:) = f_data(:)
#endif
    end subroutine sorting_init

    subroutine sorting_sort
      call sort_check()
      call std_sort_wrapper_ri(f_data(51), nelems)
      call std_sort_wrapper(c_data, nelems)
#ifdef FFTW
      call std_sort_wrapper_fai(c_fftw, nelems)
#endif
    end subroutine sorting_sort

    subroutine sort_check()
      print *, 'F90 3', nelems, f_data(51)
    end subroutine sort_check

end module sorting