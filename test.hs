import System.IO
import System.Random
import System.Environment
import Control.Monad
import Data.List

main :: IO ()
main = do
  args <- getArgs
  let num = read(head args)
  xs <- replicateM num (getRandomWord "/usr/share/dict/words")
  let passwd = intercalate "_" xs
  putStrLn passwd

getRandomWord :: String -> IO String
getRandomWord fileName = do
  handle <- openFile fileName ReadMode
  fileSize <- hFileSize handle
  -- -1 is so that when it skips there's no EOF error
  randomNum <- randomRIO(0, fileSize - 1)
  hSeek handle AbsoluteSeek randomNum
  --Skip to next line
  hGetLine handle
  thing <- hGetLine handle
  return thing
