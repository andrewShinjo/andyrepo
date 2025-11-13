---------------------------- MODULE TreeOutliner ----------------------------
EXTENDS Sequences, Naturals
VARIABLES document

\* A line consists of a bullet point + text.
Line == [ text: STRING, bullet: BOOLEAN ]

\* Initial state:
\* A document with one empty line.
Init ==  /\ document = << [ text |-> "", bullet |-> FALSE ] >>


\* We can left click a line in the document
\* If we click an empty line, we add a bullet point to it.
\* Otherwise, nothing changes about the document.
LeftClick(lineIndex) ==
    /\ lineIndex =< Len(document)
    /\ document'[lineIndex].text = document[lineIndex].text
    /\ document' = [
            i \in 1..Len(document) |->
            IF i = lineIndex THEN [ text |-> "", bullet |-> TRUE ]
            ELSE document[i]
        ]
        
Next ==
  \E i \in 1..Len(document) :
    LeftClick(i)
      
          
BulletInvariant ==
  \A i \in 1..Len(document) :
    document[i].bullet = FALSE

=============================================================================
