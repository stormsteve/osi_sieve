  REM Prime finder using trial division
  REM Copyright (C) 2026 Steven M. Gale
  REM GPL-3.0-or-later. See the LICENSE file for details.

10 GOTO 200

  REM Compute the primes brute force except multiples of 2.
  REM  2 and 3 are assumed prime
20 FORI=5TONSTEP2
  30 SQ=INT(SQR(I))
  40 FORJ=3TOSQSTEP2
    50 IFI/J=INT(I/J)GOTO80
  60 NEXTJ
  70 R(P)=I:P=P+1
80 NEXTI
90 RETURN

  REM Main body
  REM Alternative implementation:
  REM 200 INPUT"Find primes up to what number";N
200 N=1000
230 IF N<2 GOTO 300
240 DIM R(N-1)
250 R(0)=2:P=1:IF N<3 GOTO 300
260 R(1)=3:P=2:IF N<5 GOTO 300
270 GOSUB 20
300 PRINT "Found "P" primes"
  REM Alternative implementation: FORI=0TOP-1:PRINTR(I);:NEXT:PRINT
330 IF N=10 AND P<>4 GOTO 410
340 IF N=100 AND P<>25 GOTO 410
350 IF N=1000 AND P<>168 GOTO 410
360 IF N=10000 AND P<>1229 GOTO 410
370 IF N=10 OR N=100 OR N=1000 OR N=10000 GOTO 390
380 PRINT "No built-in check":GOTO 400
390 PRINT "Test PASSED"
400 END
410 PRINT "Test FAILED"
420 END
