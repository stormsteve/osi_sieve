REM OSI adaptation Copyright (C) 2026 Steven M. Gale
REM Based on a Dave Plummer prime sieve variant
REM GPL-3.0-or-later. See the LICENSE file for details.
REM Prime Calculator Sieve of Eratosthenes - Dave Plummer (ROM)
20 N = 1000
30 DIM A(N)
40 NS = INT(SQR(N))
50 FOR I=2 TO N:A(I)=1:NEXT
80 FOR I=2 TO NS
90   IF A(I)=0 GOTO 130
100  FOR J=I+I TO N STEP I
110    A(J)=0
120  NEXT J
130 NEXT I
140 C=0
150 FOR I=2 TO N:IF A(I)=1 THEN C=C+1
170 NEXT
180 PRINT "NUMBER OF PRIMES UP TO"; N; "IS:"; C
190 END
