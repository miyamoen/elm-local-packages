module Views.Organisms.Layout exposing (view)

import Element exposing (..)
import Types exposing (..)
import Views.Constants as Constants exposing (breakPoints)
import Views.Organisms.Header as Header
import Views.Organisms.Sidebar as Sidebar


view : Model -> Element msg -> Element msg
view model body =
    column
        [ width fill, spacing Constants.padding ]
        [ Header.view model
        , row
            [ width (maximum breakPoints.large fill)
            , padding Constants.padding
            , spacing Constants.padding
            , centerX
            ]
          <|
            case Sidebar.view model of
                Just sidebar ->
                    [ body, el [ alignTop ] sidebar ]

                Nothing ->
                    [ body ]
        ]
