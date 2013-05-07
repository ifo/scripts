import System.IO
import Data.String.Utils (replace) --from MissingH

main = do
	inputFile <- readFile "input.txt"
	--print
	writeFile "output.txt" 
		$ unlines
		$ addUnionAllInbetween
		$ map (formatLine)
		$ lines inputFile

formatLine :: [Char] -> [Char]
formatLine = ("SELECT " ++) . removePreceedingComma . (replace "(" "") . (replace ")" "")

removePreceedingComma :: [Char] -> [Char]
removePreceedingComma (x:xs)
	| x == ','	= xs
	| otherwise = (x:xs)

addUnionAllInbetween :: [[Char]] -> [[Char]]
addUnionAllInbetween (x:[]) = x:[]
addUnionAllInbetween (x:xs) = x : ["UNION ALL"] ++ addUnionAllInbetween xs
