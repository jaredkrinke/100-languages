{ Project Euler problem 35 }

{ Note: Turbo Pascal can't address enough memory to precompute 1 million
  primes.

  Work around: only precompute the primes needed to test for primality up
  to 1 million, i.e. up to Sqrt(100000) (i.e. 1000). }

var
  count : Integer;
  number : LongInt;
  prime : Array[2..1000] of Boolean;
  primes : Array[1..1000] of Integer;

procedure sieve;
var
  i : Integer;
  n : Integer;
begin
  for i := 2 to 1000 do prime[i] := true;

  { Set prime[i] to false for composite numbers }
  for i := 2 to 1000 do begin
    n := i + i;
    while n <= 1000 do begin
      prime[n] := false;
      n := n + i;
    end;
  end;

  { Now create a zero-terminated list of primes }
  i := 1;
  for n := 2 to 1000 do begin
    if prime[n] then begin
      primes[i] := n;
      Inc(i);
    end;
  end;

  primes[i + 1] := 0;
end;

function isPrime(n : LongInt): Boolean;
var
  i : Integer;
  p : Integer;
  max : Integer;
begin
  { Only check against precomputed list of primes }
  isPrime := true;
  i := 1;
  p := primes[i];
  max := Trunc(Sqrt(n));
  while p > 0 do begin
    if p > max then break;

    if (n mod p) = 0 then begin
      isPrime := false;
      break;
    end;

    Inc(i);
    p := primes[i];
  end;
end;

function isCircularPrime(n : LongInt): Boolean;
var
  digits : Integer; { Number of decimal digits }
  power : LongInt;  { Power of ten of top digit }
  tmp : LongInt;
  i : Integer;
begin
  { Count digits and compute power of ten }
  digits := 0;
  power := 1;
  tmp := n;
  while tmp > 0 do begin
    Inc(digits);
    power := power * 10;
    tmp := tmp div 10;
  end;
  power := power div 10;

  { Check each cycling of the number }
  tmp := n;
  isCircularPrime := true;
  for i := 1 to digits do begin
    if not isPrime(tmp) then begin
      isCircularPrime := false;
      break;
    end;

    { Cycle digits }
    tmp := (10 * (tmp mod power)) + (tmp div power);
  end;
end;

begin
  sieve;

  count := 0;
  for number := 2 to 999999 do begin
    if isCircularPrime(number) then Inc(count);
  end;

  Writeln(count);
end.
