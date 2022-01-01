module sorting
  use iso_c_binding, only: C_INT, C_PTR, C_FLOAT, C_LOC
  implicit none

  interface
    subroutine std_sort_wrapper(array, n) bind(C)
      import :: C_INT, C_PTR !, C_FLOAT
      type(C_PTR), intent(inout) ::  array
      integer(kind=C_INT), intent(in), value ::  n
    end subroutine std_sort_wrapper
  end interface

  real, allocatable, target, dimension(:) :: data
  type(C_PTR) :: c_data
  integer :: nelems

  contains

    subroutine sorting_init(nelems_)
      integer, intent(in), optional :: nelems_
      if (present(nelems_)) then
        nelems = nelems_
      else
        nelems = 1000
      endif
      allocate(data(nelems))
      c_data = c_loc(data)
      call random_number(data(:))
    end subroutine sorting_init

    subroutine sorting_sort
      call sort_check()
      call std_sort_wrapper(c_data, nelems)
    end subroutine sorting_sort

    subroutine sort_check()
      print *, 'F90', nelems, data(51)
    end subroutine sort_check

end module sorting