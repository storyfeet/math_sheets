module Main exposing (..)

import Browser as Br
import Random as R
import Html as H
import Menu
import Html.Attributes as Attrs
import Sums
import Message as M exposing (Question,Msg)




type alias Model = 
        {
                sums : List Question
                , menu : Menu.Menu
        }

type alias IntRange = (Int,Int)

addGen : IntRange -> IntRange -> R.Generator Question
addGen (a1,a2) (b1,b2) =
        R.pair (R.int a1 a2) (R.int b1 b2)  
        |> R.map (\(a,b) -> Sums.simpleInt a b "+" )
        


init : {} -> (Model,Cmd Msg)
init _ = ({sums = [],menu = Menu.init},R.generate M.Gen (addGen (2,20) (2,20)|> R.list 20))

view : Model -> Br.Document Msg
view pg = 
        { title = "Math Worksheet Generator"
        , body = 
                [ H.h1 [] [H.text "Math Worksheet" ] 
                , Menu.view pg.menu
                , pg.sums |> List.map (withLines pg.menu.lines 10) |> List.map (borderDiv 1.5 pg.menu.width pg.menu.height) |> H.div []
                ]
        }
withLines: Int -> Int -> Question -> List Question
withLines n w q =
        let 
                line = String.repeat w "_"
                l = [H.br [] [], H.text line]
        in
                q :: (repeatList n l)

borderDiv :Float -> Int -> Int -> List Question -> Question
borderDiv font w h s =
        H.div 
                [ Attrs.style "font-size" (String.fromFloat font ++ "em")

                , Attrs.style "border" "1px solid black" 
                , Attrs.style "min-width" (String.fromInt w ++ "px" )
                , Attrs.style "min-height" (String.fromInt h ++ "px")
                , Attrs.style "padding" "10px" 
                , Attrs.style "float" "left"
                ] s


update : Msg -> Model -> (Model, Cmd Msg)
update ms md = 
        case ms of 
                M.Gen l -> ({md | sums = l},Cmd.none) 
                M.Menu mm -> ({md | menu = Menu.update mm md.menu },Cmd.none)
                --_ -> (md ,Cmd.none)

-- Sub and Cmd are in Core Platform, that's why I couldn't find them
subscriptions : a -> Sub Msg
subscriptions _ = Sub.none

main : Program {} Model Msg
main = Br.document {
        init = init
        , view = view
        , subscriptions = subscriptions
        , update = update 
        }

repeatList : Int -> List a -> List a
repeatList n l =
        case n of 
                0 -> []
                _ -> l ++ (repeatList (n - 1) l)

