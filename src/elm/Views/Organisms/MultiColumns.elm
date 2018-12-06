module Views.Organisms.MultiColumns exposing (singleView, view)

import Element exposing (..)
import Element.Border as Border
import Element.Events exposing (onMouseEnter)
import SelectList exposing (Position(..), SelectList)
import Types exposing (..)
import Views.Organisms.Routing as Routing
import Views.Utils exposing (when)


view : Model -> Element Msg
view model =
    column [ width fill, spaceEvenly ] <|
        SelectList.selectedMap (singleView model) model.routes


singleView : Model -> Position -> SelectList Route -> Element Msg
singleView model position currentRoute =
    el
        [ width fill
        , when (Selected == position) <| Border.width 1
        , when (Selected /= position) <| onMouseEnter <| SelectRoute currentRoute
        ]
    <|
        Routing.view { model | routes = currentRoute }
