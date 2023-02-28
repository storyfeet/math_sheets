module Sums exposing (..)
import Html
import Html exposing (a)



simpleInt :Int -> Int -> String -> Html.Html a
simpleInt a b op =
        let 
            aa = String.fromInt a
            bb = String.fromInt b
        in 
                String.join " " [aa,op,bb,"= _____"]   |> Html.text
