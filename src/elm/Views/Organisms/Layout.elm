module Views.Organisms.Layout exposing (view)

import Element exposing (..)
import Types exposing (..)
import Views.Constants as Constants exposing (breakPoints)
import Views.Organisms.Header as Header
import Views.Organisms.Navigation as Navigation


view : Route -> Model -> Element msg -> Element msg
view route model body =
    column
        [ width fill
        , spacing Constants.padding
        ]
        [ Header.view route
        , column
            [ width (maximum breakPoints.large fill)
            , paddingXY Constants.padding 0
            , spacing Constants.padding
            , centerX
            ]
            [ Navigation.view route model
            , body
            ]
        ]
