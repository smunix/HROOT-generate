module Main where

import Control.Monad

import HROOT

main :: IO () 
main = do 
  tcanvas <- newTCanvas "Test" "Test" 640 480
  h2 <- newTH2F "test" "test" 100 (-5.0) 5.0 100 (-5.0) 5.0 

  tRandom <- newTRandom 65535

  let generator = gaus tRandom 0 2 

  let go n | n < 0 = return () 
           | otherwise = do 
               histfill generator generator h2
               go (n-1) 

  go 1000000
  draw h2 "lego"
  saveAs tcanvas "random2d.pdf" ""
  saveAs tcanvas "random2d.jpg" "" 
  saveAs tcanvas "random2d.png" ""
  delete h2
  delete tcanvas



histfill :: IO Double -> IO Double-> TH2F ->  IO () 
histfill dist1 dist2 hist = do 
  x <- dist1
  y <- dist2
  fill2 hist x y 
  return () 
