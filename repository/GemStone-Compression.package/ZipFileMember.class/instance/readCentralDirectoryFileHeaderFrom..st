private
readCentralDirectoryFileHeaderFrom: aStream
	"Assumes aStream positioned after signature"

	| fileNameLength extraFieldLength fileCommentLength |

	versionMadeBy := aStream nextLittleEndianNumber: 1.
	fileAttributeFormat := aStream nextLittleEndianNumber: 1.

	versionNeededToExtract := aStream nextLittleEndianNumber: 2.
	bitFlag := aStream nextLittleEndianNumber: 2.
	compressionMethod := aStream nextLittleEndianNumber: 2.

	lastModFileDateTime := aStream nextLittleEndianNumber: 4.
	crc32 := aStream nextLittleEndianNumber: 4.
	compressedSize := aStream nextLittleEndianNumber: 4.
	uncompressedSize := aStream nextLittleEndianNumber: 4.

	fileNameLength := aStream nextLittleEndianNumber: 2.
	extraFieldLength := aStream nextLittleEndianNumber: 2.
	fileCommentLength := aStream nextLittleEndianNumber: 2.
	aStream nextLittleEndianNumber: 2. 	"disk number start"
	internalFileAttributes := aStream nextLittleEndianNumber: 2.

	externalFileAttributes := aStream nextLittleEndianNumber: 4.
	localHeaderRelativeOffset := aStream nextLittleEndianNumber: 4.

	fileName := (aStream next: fileNameLength) asString.
	cdExtraField := (aStream next: extraFieldLength) asByteArray asString.
	fileComment := (aStream next: fileCommentLength) asString.

	self desiredCompressionMethod: compressionMethod