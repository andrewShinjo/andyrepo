------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers
VARIABLES big, small

TypeOK ==   /\ small \in 0..3 
            /\ big \in 0..5

Init == /\  big = 0
        /\  small = 0
        
FillSmall == /\ small' = 3
             /\ big' = big
             
FillBig == /\ small' = 0
           /\ big' = 5
           
SmallToBig == IF big + small =< 5
              THEN  /\ big' = big + small /\ small' = 0
              ELSE  /\ big' = 5 /\ small' = small - 5 + big
              
EmptySmall == /\ small' = 0 /\ big' = big

EmptyBig == /\ small' = small /\ big' = 0

BigToSmall ==   IF big + small =< 3
                THEN /\ small' = big + small /\ big' = 0
                ELSE /\ small' = 3 /\ big' = big - 3 + small


Next == \/ FillSmall
        \/ FillBig
        \/ EmptySmall
        \/ EmptyBig
        \/ SmallToBig
        \/ BigToSmall

=============================================================================

