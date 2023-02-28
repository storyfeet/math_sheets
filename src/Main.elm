module Main exposing (..)

import Browser as Br
import Random as R
import Html 


type Msg =
        DoThing
        | Gen (List Question)

type alias Question = Html.Html Msg

type alias Model = 
        {
                sums : List Question
        }

type alias IntRange = (Int,Int)

addGen : IntRange -> IntRange -> R.Generator (Int , Int)
addGen (a1,a2) (b1,b2) =
        R.map2 (\a b -> (a,b)) (R.int a1 a2) (R.int b1 b2)  

addMake : (Int , Int) -> Question
addMake (a ,b) = Html.text (String.fromInt a ++ " + " ++ String.fromInt b ++ "=") 

init : {} -> (Model,Cmd Msg)
init _ = ({sums = []},R.generate (\l -> Gen (List.map addMake l))(addGen (2,20) (2,20)|> R.list 20))

view : Model -> Br.Document Msg
view pg = 
        { title = "Poo"
        , body = 
                [ Html.h1 [] [Html.text "Math Worksheet" ] 
                , Html.div [] pg.sums
                ]
        }



update : Msg -> Model -> (Model, Cmd Msg)
update ms md = 
        case ms of 
                Gen l -> ({md | sums = l},Cmd.none) 
                _ -> (md ,Cmd.none)

-- Sub and Cmd are in Core Platform, that's why I couldn't find them
subscriptions _ = Sub.none

main : Program {} Model Msg
main = Br.document {
        init = init
        , view = view
        , subscriptions = subscriptions
        , update = update 
        }
