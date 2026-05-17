   REM Segmented Prime Sieve using Arrays of 15 bit values with timing
   REM We cannot use all 16 bits because the OR operator misbehaves
   REM with the 16th bit, even when using 2s compliment
   REM Copyright (C) 2026 Steven M. Gale
   REM GPL-3.0-or-later. See the LICENSE file for details.

10 GOTO 500

   REM Run the base sieve over P%
20 MF=SQR(R)
30 FORF=3TOMFSTEP2
  40 IF(P%(FNV(F))ANDFNB(F))GOTO80
  50 J=F+F+F
  60 IFJ<=RTHENP%(FNV(J))=P%(FNV(J))ORFNB(J):J=J+F+F:GOTO60
80 NEXTF:RETURN

   REM Count primes in the current segment
100 FORJ=LTOHSTEP2:IF(S%(FNV(J-L))ANDFNB(J-L))=0THENC=C+1
110 NEXT:RETURN

   REM Clear the current segment
130 FORI=0TOSV:S%(I)=0
140 NEXT:RETURN

   REM Mark composites in the current segment
160 FORF=3TORSTEP2
170 IF(P%(FNV(F))ANDFNB(F))GOTO250
180 J=F*F
190 IFJ<LTHENJ=F*INT((L+F-1)/F)
200 IFJ/2=INT(J/2)THENJ=J+F
210 IFJ>HGOTO250
220 D=J-L:S%(FNV(D))=S%(FNV(D))ORFNB(D)
230 J=J+F+F
240 GOTO210
250 NEXTF:RETURN

   REM Main body
   REM Alternative implementation: 500 N=1000000
500 INPUT"Find primes up to what number";N
510 GOSUB 8000

   REM Make sure N is in range
520 IF N<2 OR N>1000000 GOTO 900

   REM Allocate the small base sieve first
530 R=SQR(N)
540 DIM P%(FNV(R))
550 GOSUB 20

   REM Use the remaining free memory for the working segment
560 F=FRE(8):IF F<0 THEN F=65536+F
570 M=FNN(F)
580 IF M<3 GOTO 920
590 IF M>N THEN M=N
600 DIM S%(FNV(M))
   REM 610 PRINT "Base sieve";FNV(R)+1;"ints Segment";FNV(M)+1;"ints Span";M

   REM Remember starting time on C3 timeshare and 65D HC O/S
620 T1=FNT(55919):T2=FNT(9480)

   REM Process odd-number segments
630 C=1:L=3
640 IF L>N GOTO 770
650 H=L+M-1:IF H>N THEN H=N
660 IF H/2=INT(H/2) THEN H=H-1
670 SV=FNV(H-L)
680 GOSUB 130
690 GOSUB 160
700 GOSUB 100
710 L=H+2
720 GOTO640

   REM Compute runtime
770 T1=FNT(55919)-T1:IFT1<0THENT1=T1+86400
780 T2=FNT(9480)-T2:IFT2<0THENT2=T2+86400

   REM Check results
790 PRINT "Found";C;"primes"
800 IF (N=10 AND C<>4)OR(N=100 AND C<>25)OR(N=1000 AND C<>168) GOTO 870
810 IF (N=10000 AND C<>1229)OR(N=100000 AND C<>9592) GOTO 870
820 IF N=1000000 AND C<>78498 GOTO 870
830 PRINT "Test PASSED"
840 IF T1>0 THEN PRINT "Run time";T1;"seconds"
850 IF T2>0 THEN PRINT "Run time";T2;"seconds"
860 END

870 PRINT "Test FAILED":END

900 PRINT "Invalid input ";N
910 PRINT "Maximum 1000000":END

920 PRINT "Not enough free memory for a segment":END

     REM Define functions
     REM We can only use 15 bits because of a BASIC bug with OR
   REM Convert num bit to num bytes
8000 DEF FNV(I)=INT(I/30)
   REM FNM() does modulus 30 remainder, optimized
8010 DEF FNM(I)=I-30*INT(I/30)
   REM Alternative implementation: DEF FNB(I)=2^INT(FNM(I)/2)
   REM Mask bit, lookup (faster)
8020 DEF FNB(I)=B(FNM(I))
8040 DIM B(29)
8050 DATA 1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384
8060 FOR I=0 TO 29 STEP 2:READ J:B(I)=J:B(I+1)=J:NEXT
   REM time in secs
8070 DEF FNT(I)=PEEK(I)*3600+PEEK(I+1)*60+PEEK(I+2)
   REM Max N for F bytes free
8080 DEF FNN(F)=(F-34)*15
8090 RETURN
