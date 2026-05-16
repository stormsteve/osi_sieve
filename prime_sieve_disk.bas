   REM Prime Sieve using a Full-Size Array
   REM We use an integer array where each entry represents
   REM an odd number
   REM Copyright (C) 2026 Steve
   REM GPL-3.0-or-later. See the LICENSE file for details.

10 GOTO 200

   REM run the sieve over S%
20 MF = SQR(N)
30 FORF=3TOMFSTEP2
  40 IFS%(F)GOTO80
  50 J=F+F+F
  60 IFJ<=NTHENS%(J)=1:J=J+F+F:GOTO60
80 NEXTF
90 RETURN



   REM Count primes result in C
100 C=1:FORF=3TONSTEP2:IFS%(F)=0THENC=C+1
110 NEXT
120 RETURN

   REM Main body
200 N=1000: REM INPUT"Find primes up to what number";N
200 INPUT"Find primes up to what number";N
210 GOSUB 8000

   REM Make sure we don't overflow memory and N is valid
220 F=FRE(8):IF F<0 THEN F=65536+F
230 IF FNN(F)<N OR N<2 GOTO 600

   REM Remember starting time on C3 timeshare and 65D HC O/S
240 T1=FNT(55919): T2=FNT(9480)

   REM Allocate memory
250 DIM S%(N)

   REM Run the sieve
260 GOSUB 20

   REM Compute runtime
270 T1=FNT(55919)-T1: T2=FNT(9480)-T2

   REM Check results
280 GOSUB 100

300 PRINT "Found"; C; "primes"
310 IF (N=10 AND C<>4)OR(N=100 AND C<>25)OR(N=1000 AND C<>168) GOTO 400
320 IF (N=10000 AND C<>1229) OR (N=100000 AND C<>9592) GOTO 400
330 PRINT "Test PASSED"
340 IF T1 > 0 THEN PRINT "Run time";T1;"seconds"
350 IF T2 > 0 THEN PRINT "Run time";T2;"seconds"
360 END

400 PRINT "Test FAILED"
410 END

600 PRINT "Invalid input ";N
610 IF N>=2 THEN PRINT "Maximum ";FNN(F)
620 END

     REM Define functions
8000 DEF FNT(I)=PEEK(I)*3600+PEEK(I+1)*60+PEEK(I+2): REM time in secs
8080 DEF FNN(F)=INT(F/2)-21 : REM Max N for F bytes free
8090 RETURN
