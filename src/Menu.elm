module Menu exposing (..)
import Html as H
import Html.Attributes as A
import Html.Events as E
import Json.Decode as JD
import Json.Encode as JE
import Message as M


type alias Menu = 
        { width:Int
        , height : Int
        , lines : Int
        , notice : List String
        }

init : Menu 
init = {width = 200 , height = 90,lines = 1, notice = []}

view : Menu -> H.Html M.Msg
view m = 
        let 
            nmess = m.notice |> List.map H.text |> H.div [] 
        in 
                H.div [A.class "noprint"] [
                nmess
                , H.input [A.type_ "range" ,A.value (String.fromInt m.width), A.max "300",A.min "0",A.style "width" "300px", E.onInput (\s -> (M.Menu (M.UpdateWidth (safeInt 200 s))) )] []
                , H.input [A.type_ "range" ,A.value (String.fromInt m.height), A.max "300",A.min "0",A.style "width" "300px", E.onInput (\s -> (M.Menu (M.UpdateHeight (safeInt 200 s))) )] []
                , H.input [A.type_ "number" ,A.value (String.fromInt m.lines), A.max "10",A.min "0", E.onInput (\s -> (M.Menu (M.UpdateLines (safeInt 200 s))) )] []
                ] 

safeInt : Int -> String -> Int
safeInt def s =
        case String.toInt s of
            Just n -> n
            Nothing -> def

derecode : JD.Decoder String
derecode = 
        JD.value 
        |> JD.map (\dt -> 
                JE.encode 4 dt
                )

update :  M.MenuMsg ->Menu -> Menu
update ms m = 
        case ms of
            M.UpdateWidth n-> {m | width = n }
            M.UpdateHeight n-> {m | height = n }
            M.UpdateLines n -> {m| lines = n}
        


