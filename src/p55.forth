// PROJECT EULER PROBLEM 55                                     
// LYCHREL NUMBERS                                              
//                                                              
// TO RUN:                                                      
//                                                              
// 20 23 THRU                                                   
// SOLVE                                                        
//                                                              
// LYCHRELS WILL BE LOGGED; FULL                                
// EXECUTION TAKES AROUND 2 HOURS                               
                                                                
// DECIMAL DIGIT ARRAY                                          
// LEAST SIGNIFICANT FIRST                                      
: NCLR 30 0 DO DUP I + 0 SWAP C! LOOP DROP ;                    
: NCPY 30 CMOVE ;                                               
: NLD0 0 30 0 DO OVER 29 I - + C@                               
 IF LEAVE THEN 1+ LOOP SWAP DROP ;                              
: N. 30 OVER NLD0                                               
 DO DUP 29 I - + C@ ASCII 0 + EMIT                              
 LOOP DROP SPACE ;                                              
                                                                
CREATE ONE 30 ALLOT ONE NCLR 1 ONE !                            

// DECIMAL ADDITION                                             
VARIABLE CARRY                                                  
                                                                
: (N+) 30 0 DO                                                  
 OVER I + C@ OVER I + C@ CARRY @ + +                            
 10 /MOD CARRY ! OVER I + C!                                    
 LOOP 2DROP ;                                                   
: N+ 0 CARRY ! (N+) ;                                           
                                                                
// DECIMAL REVERSE                                              
VARIABLE DGTS                                                   
                                                                
: NDGTS 30 SWAP NLD0 - ;                                        
: CEXCH OVER C@ OVER C@ SWAP ROT C! SWAP C! ;                   
: NREV DUP NDGTS DGTS ! DGTS @ 2 /                              
 0 ?DO DUP I + OVER DGTS @ 1- I - +                             
 CEXCH LOOP DROP ;                                              

// PALINDROME/LYCHREL TESTS                                     
CREATE NTMP 30 ALLOT                                            
                                                                
: NIP SWAP DROP ;                                               
: N= TRUE 30 0 DO DROP OVER I + C@                              
 OVER I + C@ <> IF FALSE LEAVE THEN                             
 TRUE LOOP NIP NIP ;                                            
: NPAL DUP NTMP NCPY NTMP NREV NTMP N= ;                        

: NLYCH TRUE 49 0 DO                                            
 OVER NPAL I IF IF DROP FALSE LEAVE                             
 THEN ELSE DROP THEN OVER NTMP SWAP N+                          
 LOOP NIP ;                                                     

// ENTRY POINT                                                  
CREATE N0 30 ALLOT                                              
CREATE N1 30 ALLOT                                              

: COUNT-LYCHRELS                                                
 ( MAX -- COUNT )                                               
 N0 NCLR 9 0 DO ONE N0 N+ LOOP                                  
 0 SWAP 9 DO                                                    
 ONE N0 N+ N0 N1 NCPY                                           
 N1 NLYCH IF                                                    
  1+ N0 N.                                                      
 THEN LOOP ;                                                    
                                                                
: SOLVE 10000 COUNT-LYCHRELS CR . ;                             
