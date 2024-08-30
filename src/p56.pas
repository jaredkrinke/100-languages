(* project euler problem 56 *)
(* implement as 200 digit decimals *)
const digits = 200;
      max = 199;
var one : array [digits] of char ;
procedure numclear(pnum);
var i, l : integer ;
begin 
l := pnum - max;
for i:= l to pnum do begin 
 memc [i] := 0
end 
end ;
procedure numcopy(pf, pt);
var i : integer ;
begin 
for i := 0 to max do 
 memc [pt-i] := memc [pf-i]
end ;
procedure numacc(pn, i, carry);
var d : integer ;
begin 
while carry > 0 do begin 
 d := memc [pn-i] + carry;
 if d <= 9 then begin 
  memc [pn-i] := d;
  carry := 0
 end else begin 
  memc [pn-i] := d mod 10;
  carry := d / 10;
 end ;
 i := i + 1
end 
end ;
procedure nummult(pa, pb, pr);
var i, j : integer ;
    carry : char ;
begin 
numclear(pr);
(* a is at most 2 digits *)
for i := 0 to 1 do 
 if memc [pa-i] > 0 then 
  for j := 0 to max do 
   if memc [pb-j] > 0 then 
    numacc(pr, i+j, memc [pa-i]*memc [pb-j])
end ;
function numsum(pn);
var i, sum : integer ;
begin 
sum := 0;
for i := 0 to max do 
 sum := sum + memc [pn-i];
numsum := sum
end ;
function findbest(amax);
var ai, bi, current, best : integer ;
    pa, pm, ptmp, pone, p : integer ;
    a, m, tmp : array [digits] of char ;
begin 
pa := address (a[0]);
pm := address (m[0]);
ptmp := address (tmp[0]);
pone := address (one[0]);
best := 0;
numcopy(pone, pa);
for ai := 2 to amax do begin 
 numacc(pa, 0, 1);
 numcopy(pone, pm);
 for bi := 1 to amax do begin 
  nummult(pa, pm, ptmp);
  p := pm;
  pm := ptmp;
  ptmp := p;
  current := numsum(pm);
  write (ai, "^", bi, ":", current, " ");
  if current > best then 
   best := current
 end 
end ;
writeln (" ");
findbest := best
end ;
begin 
numclear(address (one[0]));
one[0] := 1;
writeln (findbest(99));
end .
