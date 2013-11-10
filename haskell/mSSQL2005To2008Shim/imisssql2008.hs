import System.IO
import Data.String.Utils (replace) --from MissingH
import Data.List (intersperse)

main = do
	inputFile <- readFile "input.txt"
	--print
	writeFile "output.txt" 
		$ unlines
    $ intersperse ["UNION ALL"]
		-- $ addUnionAllInbetween
		$ map (formatLine)
		$ lines inputFile

formatLine :: [Char] -> [Char]
formatLine = ("SELECT " ++) . removePreceedingComma . (replace "(" "") . (replace ")" "")

removePreceedingComma :: [Char] -> [Char]
removePreceedingComma (x:xs)
	| x == ','	= xs
	| otherwise = (x:xs)

-- This is Data.List's intersperse
addUnionAllInbetween :: [[Char]] -> [[Char]]
addUnionAllInbetween (x:[]) = x:[]
addUnionAllInbetween (x:xs) = x : ["UNION ALL"] ++ addUnionAllInbetween xs
