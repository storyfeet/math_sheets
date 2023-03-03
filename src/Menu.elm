module Menu exposing (..)
import Html as H
import Html.Attributes as A
import Html.Events as E
import Json.Decode as JD


type alias Menu = 
        { width:Int
        }

init : Menu 
init = {width = 200}

view : Menu -> H.Html a
view _ = H.div [A.class "noprint"] [
        H.input [A.type_ "range" , E.on "change" (JD.string  )]
        ] 





