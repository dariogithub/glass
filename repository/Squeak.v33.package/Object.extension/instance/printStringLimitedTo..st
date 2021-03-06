*squeak-printing
printStringLimitedTo: limit
	"Answer a String whose characters are a description of the receiver.
	If you want to print without a character limit, use fullPrintString."

| count stream res |
count := 0.
stream := WriteStream on: String new.
self printOn: stream.
res := stream contents.
res size <= limit ifTrue: [^res].
^res copyFrom: 1 to: limit