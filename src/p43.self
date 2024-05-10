 ''
 '
Copyright 1992-2016 AUTHORS.
See the legal/LICENSE file for license information and legal/AUTHORS for authors.
'
[ 
"prefileIn" self] value


 '-- Module body'

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         p43 = bootstrap define: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () ToBe: bootstrap addSlotsTo: (
             bootstrap remove: 'directory' From:
             bootstrap remove: 'fileInTimeString' From:
             bootstrap remove: 'myComment' From:
             bootstrap remove: 'postFileIn' From:
             bootstrap remove: 'revision' From:
             bootstrap remove: 'subpartNames' From:
             globals modules init copy ) From: bootstrap setObjectAnnotationOf: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( |
             {} = 'ModuleInfo: Creator: globals modules p43.

CopyDowns:
globals modules init. copy 
SlotsToOmit: directory fileInTimeString myComment postFileIn revision subpartNames.

\x7fIsComplete: '.
            | ) .
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot\x7fVisibility: public'
        
         directory <- 'applications'.
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: InitializeToExpression: (_CurrentTimeString)\x7fVisibility: public'
        
         fileInTimeString <- _CurrentTimeString.
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         myComment <- ''.
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         postFileIn = ( |
            | resend.postFileIn).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: InitializeToExpression: (\'30.21.0\')\x7fVisibility: public'
        
         revision <- '30.21.0'.
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'modules' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot\x7fVisibility: private'
        
         subpartNames <- ''.
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         divisible: n By: by = ( |
            | 
            (n % by) = 0).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         mask: n Start: start = ( |
            | 
            ((n / (pow: start)) % 1000) asInt32).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         match: n = ( |
            | 
            (divisible: (mask: n Start: 0) By: 17)
            && (divisible: (mask: n Start: 1) By: 13)
            && (divisible: (mask: n Start: 2) By: 11)
            && (divisible: (mask: n Start: 3) By: 7)
            && (divisible: (mask: n Start: 4) By: 5)
            && (divisible: (mask: n Start: 5) By: 3)
            && (divisible: (mask: n Start: 6) By: 2)).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         parent* = bootstrap stub -> 'traits' -> 'oddball' -> ().
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         permute: digits Acc: acc = ( |
             s.
            | 
                s: self.
                (digits size > 0) ifTrue: [
                  0 to: 9 Do: [| :i |
                    (digits includes: i) ifTrue: [| nextDigits |
                    nextDigits: digits copy.
                    nextDigits remove: i.
                    s permute: nextDigits Acc: ((acc * 10) + i).
                 ]
                ]
                ]
                False: [
            (match: acc) ifTrue: [sum: (sum + acc)].
            ]).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         pow: n = ( |
             m.
            | 
            m: 1.
            1 to: n Do: [
              m: (m * 10)
            ].
            m).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: FollowSlot'
        
         solve = ( |
             s.
            | 
                    sum: 0.
                    s: set copy.
                s add: 0.
                s add: 1.
                s add: 2.
                s add: 3.
                s add: 4.
                s add: 5.
                s add: 6.
                s add: 7.
                s add: 8.
                s add: 9.
                    permute: s Acc: 0.
                    sum print.
            sum).
        } | ) 

 bootstrap addSlotsTo: bootstrap stub -> 'globals' -> 'p43' -> () From: ( | {
         'ModuleInfo: Module: p43 InitialContents: InitializeToExpression: (0)'
        
         sum <- 0.
        } | ) 



 '-- Side effects'

 globals modules p43 postFileIn
