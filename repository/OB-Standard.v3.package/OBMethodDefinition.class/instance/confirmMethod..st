confirming
confirmMethod: aText
	| sel |
	sel _ self getSelector: aText.
	sel == nil ifTrue: [ ^true ].
	^ (self theClass isMeta 
			and: [(self selectorAlreadyDefined: sel) not] 
			and: [Metaclass3 isScarySelector: sel])
				ifTrue: [self confirmScarySelector: sel]
				ifFalse: [^ true]