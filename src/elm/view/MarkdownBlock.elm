module MarkdownBlock exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Font as Font
import Fake
import Html.Attributes
import Markdown exposing (defaultOptions)
import ViewUtil exposing (withCss)


view : String -> Element msg
view raw =
    paragraph [ Font.size Constant.fontSize ] [ markdown raw ]


markdown : String -> Element msg
markdown raw =
    Markdown.toHtmlWith { defaultOptions | defaultHighlighting = Just "elm" }
        [ Html.Attributes.class "markdown-block" ]
        raw
        |> html


book : Book
book =
    bookWithFrontCover "MarkdownBlock" (view Fake.readMe |> withCss)


main : Bibliopola.Program
main =
    fromBook book
