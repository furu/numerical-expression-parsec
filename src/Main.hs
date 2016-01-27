module Main where

import Text.ParserCombinators.Parsec

-- 文字列にある数字を見つけてくる
number :: Parser Integer
number = do
  ds <- many1 digit
  return (read ds)

-- Parsec では、パースが成功し消費された入力データは忘れ去られる。
-- try で囲むと入力データを覚えていて、パースが失敗した場合は
-- 入力を巻き戻してくれる。
--
-- 以下のパーサで "256" をパースすると
-- z <- number で 256 が消費され、次に + を見つけようとするが
-- + はないのでパースに失敗する。この部分は try で囲まれているので
-- 256 が巻き戻されて、次の number でパースされ、これには成功する。
-- よって、以下のパーサは "256+256" も "256" もパースできる。
-- という理解でいいのかな。
calc :: Parser Integer
calc = do
  x <- try (do z <- number; char '+'; return z)
  y <- number
  return $ x + y
  <|> number

run :: String -> String
run input = case parse calc "Test" input of
                 Left err  -> show err
                 Right val -> show val

main :: IO ()
main = undefined
