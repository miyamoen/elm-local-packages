module Views.Atoms.Breadcrumbs exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Font as Font
import Elm.Version as Version
import Types exposing (..)
import Types.Route as Route
import Views.Colors as Colors
import Views.Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : List (Element msg) -> Element msg
view crumbs =
    row [ spacing 10, Font.size fontSize.middle ] <|
        List.intersperse (text "/") crumbs


book : Book
book =
    intoBook "Breadcrumbs" identity (view >> withFrame)
        |> addStory
            (Story "crumbs"
                [ ( "0", [] )
                , ( "1", [ text "author" ] )
                , ( "2", [ text "author", text "package" ] )
                , ( "3", [ text "author", text "package", text "version" ] )
                , ( "4", [ text "author", text "package", text "version", text "module" ] )
                ]
            )
        |> buildBook
        |> withFrontCover (view [ text "home", text "item1", text "child3" ] |> withFrame)


main : Bibliopola.Program
main =
    fromBook book
