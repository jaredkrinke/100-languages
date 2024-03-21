function is_prime(n) result(prime)
  implicit none
  integer, parameter :: big = selected_int_kind(13)
  integer(big), intent(in) :: n
  logical :: prime
  
  integer(big) :: m

  prime = .true.
  m = 2
  do while (m**2 <= n .and. prime)
    if (mod(n,m) == 0) then
      prime = .false.
    end if
    m = m + 1
  end do
end function is_prime

function largest_prime_factor(n) result(factor)
  implicit none
  integer, parameter :: big = selected_int_kind(13)
  integer(big), intent(in) :: n
  integer(big) :: factor
  logical :: is_prime

  integer(big) :: m
  integer(big) :: d

  m = n
  d = 2

  do while (d <= m)
    if (mod(m,d) == 0) then
      m = m / d
      factor = d
    else
      d = d + 1
      do while (.not. is_prime(d))
        d = d + 1
      end do
    end if
  end do
end function largest_prime_factor

program project_euler_3
  implicit none
  integer, parameter :: big = selected_int_kind(13)
  integer(big) :: largest_prime_factor

  print *, 'Largest prime factor: ', largest_prime_factor(600851475143_big)
end program project_euler_3
