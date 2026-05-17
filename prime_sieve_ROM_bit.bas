   REM Prime Sieve using direct memory allocation and bit manipulation
   REM We move the high water mark back and directly access memory
   REM using 1 bit for each odd number. When done we reset the HWM
   REM Copyright (C) 2026 Steven M. Gale
   REM GPL-3.0-or-later. See the LICENSE file for details.

10 GOTO 200

   REM Run the sieve over S
20 MF=SQR(N)
30 FORF=3TOMFSTEP2
  40 IF(PEEK(S+FNV(F))ANDFNB(F))GOTO80
  50 J=F+F+F
   REM Alternative implementation:
   REM 60 IFJ<=NTHENA=S+FNV(J):POKEA,PEEK(A)ORFNB(J):J=J+F+F:GOTO60
  60 IFJ>NGOTO80
  70 A=S+INT(J/16):POKEA,PEEK(A)ORB(JAND15):J=J+F+F:GOTO60
80 NEXT:RETURN

   REM Count primes result in C
100 C=1:FORF=3TONSTEP2:IF(PEEK(S+FNV(F))ANDFNB(F))=0THENC=C+1
110 NEXT:RETURN

   REM Main body
   REM Alternative implementation: 200 N=1000
200 INPUT"Find primes up to what number";N
210 GOSUB 8000

   REM Make sure we don't overflow memory and N is valid
220 F=FRE(8):IF F<0 THEN F=65536+F
230 IF FNN(F)<N OR N<2 GOTO 600

   REM Allocate memory
250 GOSUB 8100

   REM Run the sieve
260 GOSUB 20

   REM Check results
280 GOSUB 100

   REM Release memory
290 GOSUB 8200

300 PRINT "Found"; C; "primes"
310 IF (N=10 AND C<>4)OR(N=100 AND C<>25)OR(N=1000 AND C<>168) GOTO400
320 IF (N=10000 AND C<>1229) OR (N=100000 AND C<>9592) GOTO 400
330 PRINT "Test PASSED"
350 END

400 PRINT "Test FAILED"
410 END

600 PRINT "Invalid input ";N:IF N>=2 THEN PRINT "Maximum ";FNN(F)
610 END

     REM Define functions
   REM Get the high byte
8000 DEF FNH(I)=INT(I/256)
   REM Get the low  byte
8010 DEF FNL(I)=I-256*FNH(I)
   REM Convert num bit to num bytes
8020 DEF FNV(I)=INT(I/16)
   REM FNM() does modulus 16 remainder, optimized
   REM 8030 IF N<65536 THEN  DEF FNM(I)=IAND15
   REM 8040 IF N>=65536 THEN DEF FNM(I)=I-16*INT(I/16)
   REM Alternative implementation: DEF FNB(I)=2^INT(FNM(I)/2)
   REM Mask bit, lookup (faster)
8050 IF N<65536 THEN  DEF FNB(I)=B(IAND15)
8060 IF N>=65536 THEN DEF FNB(I)=B(I-16*INT(I/16))
8070 DIM B(15):DATA 1,2,4,8,16,32,64,128
8080 FOR I=0 TO 15 STEP 2:READ J: B(I)=J: B(I+1)=J:NEXT
   REM Max N for F bytes free
8090 DEF FNN(F)=(F-24)*16
8100 RETURN

   REM Allocate (reserve) and init memory for the sieve array S
   REM high water mark (top of RAM)
8100 HW=PEEK(134)*256+PEEK(133)
   REM Starting address of the sieve
8110 S=HW-FNV(N)-1
8120 POKE 133,FNL(S): POKE 134,FNH(S)
8130 FORA=STOHW-1:POKEA,0:NEXT:RETURN

   REM free allocated memory
8200 POKE 134,FNH(HW):POKE 133,FNL(HW):RETURN
