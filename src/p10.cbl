      * PROJECT EULER PROBLEM 10 IN COBOL
       IDENTIFICATION DIVISION.
       PROGRAM-ID. P10.
       AUTHOR. JARED KRINKE.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           77 N PIC S9(8) COMP.
           77 MULT PIC S9(8) COMP.
           77 CNT PIC S9(8) COMP.
           77 TOTAL PIC S9(15) COMP VALUE ZERO.

           01 ARRAY.
               05 CMPS PIC S9(8) COMP VALUE ZERO OCCURS 2000000 TIMES.

       PROCEDURE DIVISION.
      * MARK ALL MULTIPLES AS COMPOSITE NUMBERS
           DISPLAY 'COMPUTING PRIMES...'
           SET N TO 2
           PERFORM 1000000 TIMES
               SET MULT TO N
               ADD N TO MULT
               PERFORM UNTIL MULT >= 2000000
                   SET CMPS(MULT) TO 1
                   ADD N TO MULT
               END-PERFORM
               ADD 1 TO N
           END-PERFORM

      * SUM PRIMES
           DISPLAY 'ADDING UP PRIMES...'
           SET TOTAL TO ZERO
           SET N TO 2
           PERFORM UNTIL N >= 2000000
               IF CMPS(N) = 0 THEN
                   ADD N TO TOTAL
               END-IF
               ADD 1 TO N
           END-PERFORM

      * DISPLAY RESULT
           DISPLAY TOTAL
           STOP RUN.
