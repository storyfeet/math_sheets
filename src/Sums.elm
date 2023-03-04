module Sums exposing (..)
import Html as H
import Html exposing (a)
import Array exposing (Array)


type LVar =
        A
        | B
        | C
        | X
        | Y
        | L String

varStr : LVar -> String
varStr v =
        case v of
                A -> "a"
                B -> "b"
                C -> "c"
                X -> "x"
                Y -> "y"
                L s -> s
                

       

type Sum = 
        N Int
        | F Float
        | Var LVar
        | Power Sum Sum
        | Add Sum Sum
        | Eq
        | Blank
        | RF Float Float
        | RI Int Int


iMn : Int -> H.Html a
iMn n =
        Html.node "mn" [] [String.fromInt n |> H.text]

fMn : Float -> H.Html a
fMn n =
        Html.node "mn" [] [String.fromFloat n |> H.text]

mo : String -> H.Html a
mo s = Html.node "mo" [] [H.text s]

toHtml : Sum -> H.Html a
toHtml s = 
        case s of
                N n -> iMn n
                F f -> fMn f 
                Var v -> varStr v |> mo 


                 
                





simpleInt :Int -> Int -> String -> H.Html a
simpleInt a b op =
        let 
            aa = String.fromInt a
            bb = String.fromInt b
        in 
                String.join " " [aa,op,bb,"= _____"]   |> Html.text
