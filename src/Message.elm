module Message exposing(..)
import Html as H

type alias Question = H.Html Msg

type Msg =
        UpdateWidth 
        | Gen (List Question)

