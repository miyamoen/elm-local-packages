module Views.Organisms.MultiColumns exposing (shelf, singleView, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Border as Border
import Element.Events exposing (onMouseEnter)
import Fake
import SelectList exposing (Position(..), SelectList)
import Types exposing (..)
import Views.Colors as Colors
import Views.Organisms.Routing as Routing
import Views.Utils exposing (when, withFrame)


view : Model -> Element Msg
view model =
    row [ width fill, spaceEvenly, height fill ] <|
        SelectList.selectedMap (singleView model) model.routes


singleView : Model -> Position -> SelectList Route -> Element Msg
singleView model position currentRoute =
    el
        [ width fill
        , alignTop
        , scrollbarY
        , height fill
        , when (Selected == position) <| Border.innerGlow Colors.secondary 2
        , when (Selected /= position) <| onMouseEnter <| SelectColumn currentRoute
        ]
    <|
        Routing.view { model | routes = currentRoute }


singleBook : Book
singleBook =
    intoBook "SingleColumn"
        msgToString
        (\pos -> singleView Fake.model pos Fake.model.routes |> withFrame)
        |> addStory
            (Story "selected"
                [ ( "Selected", Selected )
                , ( "notSelected", AfterSelected )
                ]
            )
        |> buildBook


book : Book
book =
    bookWithFrontCover "MultiColumns"
        (view Fake.model |> Element.map msgToString |> withFrame)


shelf : Shelf
shelf =
    shelfWith book
        |> addBook singleBook


main : Bibliopola.Program
main =
    fromShelf shelf
