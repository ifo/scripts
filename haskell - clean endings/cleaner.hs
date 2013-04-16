import System.IO
import Data.String.Utils --from MissingH

main = do
	inputFile <- readFile "input.txt"
	--print
	writeFile "output.txt" 
		$ unlines 
		-- $ map (replace "," "\t") -- make csv tab separated
		$ map (replace "\"\"" "") 
		-- $ map (drop 3) -- remove beginning "",
		$ lines inputFile
