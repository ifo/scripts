import System.Environment
import Data.List.Split (splitOn)

main = do
	args <- getArgs
	inputFile <- readFile "input.txt"
	--return
	writeFile "output.txt" 
		$ unlines
		$ map (returnValIfKeyExists (head args))
		$ map (makeVarsAndIDs)
		-- $ map (\x -> 'a' : x ++ "&" ++ x) -- just for testing to add a different key input
		$ map (getGets)
		$ lines inputFile

tuplefy :: [a] -> (a,a)
tuplefy [x,y] = (x,y)

getGets :: String -> String
getGets = trim . last . splitOn "?"

makeVarsAndIDs :: String -> [(String, String)]
makeVarsAndIDs = (map (tuplefy . splitOn "=") . splitOn "&")

returnValIfKeyExists :: String -> [(String, String)] -> String
returnValIfKeyExists _ [] = "" 
returnValIfKeyExists key (x:xs)
	| fst x == key = snd x
	| otherwise		 = returnValIfKeyExists key xs


-- for spaces and trimming
isSpace :: Char -> Bool
isSpace x = x == ' '

-- got this gem from an answer on Stack Overflow -> http://stackoverflow.com/a/6270337
-- originally from http://en.wikipedia.org/wiki/Trim_(programming)#Haskell
trim :: String -> String
trim = f . f
	where f = reverse . dropWhile isSpace
