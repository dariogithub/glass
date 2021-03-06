sorting
sortHierarchicallyOptimized: nodes
	"Reimplements sortHierarchically in a crude and ugly way that is however much more efficient"
	
	| classNodes sortedResults supersChain superior result chain1 chain2 i max |

	classNodes := (nodes collect: [:classNode | classNode theClass]) asOrderedCollection.
	sortedResults := SortedCollection sortBlock: [:assoc1 :assoc2 |
		result := nil.
		chain1 := assoc1 key.
		chain2 := assoc2 key. 
		max := chain1 size min: chain2 size.
		i := 1.
		[result isNil and: [i <= max]] whileTrue: [
			(chain1 at: i) = (chain2 at: i)
				ifTrue: [i := i + 1]
				ifFalse: [result := (chain1 at: i) name < (chain2 at: i) name]].
		result isNil ifTrue: [
			chain1 size < chain2 size] ifFalse: [result]
	].
	nodes do: [:classNode |
		supersChain := classNode theClass withAllSuperclasses reversed.
		supersChain removeAllSuchThat: [:cl | (classNodes includes: cl) not].
		superior := supersChain size > 1
			ifTrue: [superior := supersChain atLast: 2. nodes detect: [:e | e theClass = superior]]
			ifFalse: [nil].
		sortedResults add: supersChain contents -> classNode.
	].
	^(sortedResults collect: [:assoc | assoc value]) asArray