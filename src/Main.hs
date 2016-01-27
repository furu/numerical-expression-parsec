module Main where

import Text.ParserCombinators.Parsec

-- 文字列にある数字を見つけてくる
number :: Parser Integer
number = do
  ds <- many1 digit
  return (read ds)

calc :: Parser Integer
calc = do
  x <- number
  char '+'
  y <- number
  return $ x + y

run :: String -> String
run input = case parse calc "Test" input of
                 Left err  -> show err
                 Right val -> show val

main :: IO ()
main = undefined
