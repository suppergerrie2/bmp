{-# OPTIONS_HADDOCK hide #-}
module Codec.BMP.FileHeader
	( FileHeader	(..)
	, sizeOfFileHeader)
where
import Data.Binary
import Data.Binary.Get	
import Data.Binary.Put
	
	
-- File Headers -----------------------------------------------------------------------------------
-- | BMP file header.
data FileHeader
	= FileHeader			
	{ -- | Magic numbers 0x42 0x4d
	  fileHeaderType	:: Word16
	
	  -- | Size of the file, in bytes.
	, fileHeaderSize	:: Word32

	  -- | Reserved, must be zero.
	, fileHeaderReserved1	:: Word16

	  -- | Reserved, must be zero.
	, fileHeaderReserved2	:: Word16

	  -- | Offset in bytes to the start of the pixel data.
	, fileHeaderOffset	:: Word32
	}
	deriving (Show)

-- | Size of a file header (in bytes).
sizeOfFileHeader :: Int
sizeOfFileHeader = 14


instance Binary FileHeader where
 get 
  = do	t	<- getWord16le
	size	<- getWord32le
	res1	<- getWord16le
	res2	<- getWord16le
	offset	<- getWord32le
	
	return	$ FileHeader
		{ fileHeaderType	= t
		, fileHeaderSize	= size
		, fileHeaderReserved1	= res1
		, fileHeaderReserved2   = res2
		, fileHeaderOffset	= offset }

 put header
  = do	putWord16le	$ fileHeaderType header
	putWord32le	$ fileHeaderSize header
	putWord16le	$ fileHeaderReserved1 header
	putWord16le	$ fileHeaderReserved2 header
	putWord32le	$ fileHeaderOffset header