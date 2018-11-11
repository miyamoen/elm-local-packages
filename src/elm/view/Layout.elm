module Layout exposing (view)

import Constant
import Element exposing (..)
import Header
import Types exposing (..)


view : Model -> Element msg -> Element msg
view model body =
    column
        [ width fill ]
        [ Header.view
        , column
            [ width (maximum Constant.breakPoints.large fill)
            , paddingXY Constant.padding 0
            , centerX
            ]
            [ body ]
        ]
