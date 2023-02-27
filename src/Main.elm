module Main exposing (..)

import Browser as Br

type Msg =
        DoThing


init _ = ({},Cmd.none)

view _ = 
        { title = "Poo"
        , body = []
        }


update _ _ = ({}, Cmd.none)

-- Sub and Cmd are in Core Platform, that's why I couldn't find them
subscriptions _ = Sub.none

main : Program (List Int) {} Msg
main = Br.document {
        init = init
        , view = view
        , subscriptions = subscriptions
        , update = update 
        }
