module Views.Atoms.MarkdownBlock exposing (view, wrapped, book)

{-|

@docs view, wrapped, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Fake.ReadMe as Fake
import Html.Attributes exposing (class)
import Markdown exposing (defaultOptions)
import Views.Utils exposing (withFrame)


wrapped : String -> String -> Element msg
wrapped className raw =
    paragraph [ width fill ] [ view className raw ]


view : String -> String -> Element msg
view className raw =
    Markdown.toHtmlWith { defaultOptions | defaultHighlighting = Just "elm" }
        [ Html.Attributes.class "markdown-block", Html.Attributes.class className ]
        raw
        |> Element.html


book : Book
book =
    intoBook "MarkdownBlock"
        identity
        (\isWrapped ->
            if isWrapped then
                wrapped "" Fake.readMe |> withFrame

            else
                view "" Fake.readMe |> withFrame
        )
        |> addStory (Story "Wrapped" [ ( "wrapped", True ), ( "raw", False ) ])
        |> buildBook
        |> withFrontCover (wrapped "" Fake.readMe |> withFrame)


main : Bibliopola.Program
main =
    fromBook book
