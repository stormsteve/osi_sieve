   REM Prime Sieve using optimized naive algorithm
   REM Copyright (C) 2026 Steve
   REM GPL-3.0-or-later. See the LICENSE file for details.

10GOTO200

  REM Compute the primes brute force except multiples of 2.
  REM  2 and 3 are assumed prime
20FORI=5TONSTEP2
  30SQ=INT(SQR(I))
  40FORJ=3TOSQSTEP2
    50IFI/J=INT(I/J)GOTO80
  60NEXTJ
  70R(P)=I:P=P+1
80NEXTI
90RETURN

    REM Main body
   REM Alternative implementation: 200INPUT"Find primes up to what number";N
200N=1000
230IFN<2GOTO300
240DIMR(N-1)
250R(0)=2:P=1:IFN<3GOTO300
260R(1)=3:P=2:IFN<5GOTO300
270GOSUB20
300PRINT"Found "P" primes"
   REM Alternative implementation: FORI=0TOP-1:PRINTR(I);:NEXT:PRINT
330IFN=10ANDP=4THENPRINT"Test PASSED"
340IFN=100ANDP=25THENPRINT"Test PASSED"
350IFN=1000ANDP=168THENPRINT"Test PASSED"
360IFN=10000ANDP=1229THENPRINT"Test PASSED"
400END
