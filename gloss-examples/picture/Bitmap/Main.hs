
module Main where

import Graphics.Gloss
import System.Environment

-- | Displays uncompressed 24/32 bit BMP images.
main :: IO ()
main
 = do   args    <- getArgs
        case args of
         [fileName] -> run fileName
         _ -> putStr
           $  unlines [ "usage: bitmap <file.bmp>"
                      , "  file.bmp should be a 24 or 32-bit uncompressed BMP file" ]

run :: FilePath -> IO ()
run fileName
 = do   picture@(Bitmap _ bmpData)
                <- loadBMP fileName

        let (width,height) = bitmapSize bmpData
        animate (InWindow fileName (width, height) (10,  10))
                black (frame width height picture)
{-
 = do   picture@(Bitmap width height _ _)
                <- loadBMP fileName

        animate (InWindow fileName (width, height) (10,  10))
                black (frame width height picture)
-}

frame :: Int -> Int -> Picture -> Float -> Picture
frame width height picture t
        = Color (greyN (abs $ sin (t * 2)))
        $ Pictures
                [rectangleSolid (fromIntegral width) (fromIntegral height)
                , picture]
