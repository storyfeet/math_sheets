module Main exposing (..)

import Browser as Br
import Random as R
import Html 
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
                [ Html.h1 [] [Html.text "Math Worksheet" ] 
                , Menu.view pg.menu
                , pg.sums |> List.map (borderDiv 1.5 200 70) |> Html.div []
                ]
        }

borderDiv :Float -> Float -> Float -> Question -> Question
borderDiv n w h s =
        Html.div 
                [ Attrs.style "font-size" (String.fromFloat n ++ "em")
                , Attrs.style "border" "1px solid black" 
                , Attrs.style "width" (String.fromFloat w ++ "px" )
                , Attrs.style "min-height" (String.fromFloat h ++ "px")
                , Attrs.style "padding" "10px" 
                , Attrs.style "float" "left"
                ] [s]


update : Msg -> Model -> (Model, Cmd Msg)
update ms md = 
        case ms of 
                M.Gen l -> ({md | sums = l},Cmd.none) 
                _ -> (md ,Cmd.none)

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
