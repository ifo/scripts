import System.IO

main = do
	inputFile <- readFile "input.txt"
	--print
	writeFile "output.txt" 
		$ drop 2 -- remove the beginning ", "
		$ putTogether
		$ map (',':) 
		$ map (' ':)
		$ lines inputFile

-- Totally didn't look up concat on Hoogle before writing this (or concatMap)
putTogether :: [[a]] -> [a]
putTogether [] = []
putTogether (x:xs) = x ++ putTogether xs
