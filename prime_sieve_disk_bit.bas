   REM Prime Sieve using an Array of 15 bit values with timing
   REM We cannot use all 16 bits because the OR operator misbehaves
   REM with the 16th bit, even when using 2s compliment

10 GOTO 200

   REM Run the sieve over S%
20 MF = SQR(N)
30 FORF=3TOMFSTEP2
  40 IF(S%(FNV(F))ANDFNB(F))GOTO80
  50 J=F+F+F
  60 IFJ<=NTHENS%(FNV(J))=S%(FNV(J))ORFNB(J):J=J+F+F:GOTO60
80 NEXTF
90 RETURN



   REM Count primes result in C
100 C=1:FORF=3TONSTEP2:IF(S%(FNV(F))ANDFNB(F))=0THENC=C+1
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
250 DIM S%(FNV(N))

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
605 IF N>=2 THEN PRINT "Maximum ";FNN(F)
610 END

     REM Define functions
	 REM We can only use 15 bits because of a BASIC bug with OR
8000 DEF FNV(I)=INT(I/30):      REM Convert num bit to num bytes
   REM FNM() does modulus 30 remainder, optimized
8010 DEF FNM(I)=I-30*INT(I/30)
8020 DEF FNB(I)=2^INT(FNM(I)/2):REM Mask bit, calculated
8020 DEF FNB(I)=B(FNM(I)):      REM Mask bit, lookup (faster)
8040 DIM B(29)
8050 DATA 1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384
8060 FOR I=0 TO 29 STEP 2:READ J: B(I)=J: B(I+1)=J:NEXT
8070 DEF FNT(I)=PEEK(I)*3600+PEEK(I+1)*60+PEEK(I+2): REM time in secs
8080 DEF FNN(F)=(F-34)*15 : REM Max N for F bytes free
8090 RETURN
