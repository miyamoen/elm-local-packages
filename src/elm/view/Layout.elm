module Layout exposing (view)

import Element exposing (..)
import Header
import Types exposing (..)


view : Model -> Element msg -> Element msg
view model body =
    column
        [ width fill ]
        [ Header.view, body ]
