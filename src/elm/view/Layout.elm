module Layout exposing (view)

import Constant
import Element exposing (..)
import Header
import Sidebar
import Types exposing (..)


view : Model -> Element msg -> Element msg
view model body =
    column
        [ width fill, spacing Constant.padding ]
        [ Header.view model
        , row
            [ width (maximum Constant.breakPoints.large fill)
            , paddingXY Constant.padding 0
            , spacing Constant.padding
            , centerX
            ]
          <|
            case Sidebar.view model of
                Just sidebar ->
                    [ body, el [ alignTop ] sidebar ]

                Nothing ->
                    [ body ]
        ]
