module Message exposing(..)
import Html as H

type alias Question = H.Html Msg

type Msg =
        Gen (List Question)
        | Menu MenuMsg

type MenuMsg =
        UpdateWidth Int
        | UpdateHeight Int
        | UpdateLines Int
        

