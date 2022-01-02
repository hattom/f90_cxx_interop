program main
  use sorting, only: sorting_init, run_tests
  implicit none
  call sorting_init()
  call run_tests()
end program main
