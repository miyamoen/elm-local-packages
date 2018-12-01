module Views.Atoms.SearchInput exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (labelHidden, placeholder)
import Types exposing (..)
import Views.Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : (String -> msg) -> String -> Element msg
view onChange query =
    Input.text
        [ Border.rounded 8, padding 10, Font.size fontSize.middle ]
        { onChange = onChange
        , text = query
        , placeholder =
            if String.isEmpty query then
                Just <| placeholder [] <| text "Search"

            else
                Nothing
        , label = labelHidden "search"
        }


book : Book
book =
    intoBook "SearchInput" identity (view identity >> withFrame)
        |> addStory
            (Story "Query"
                [ ( "text", "text" )
                , ( "long", "ElmElmElmElmElmElmElmElmElmElmElmElmElmElmElmElm" )
                , ( "empty", "" )
                ]
            )
        |> buildBook
        |> withFrontCover
            (view identity "test" |> withFrame)


main : Bibliopola.Program
main =
    fromBook book
