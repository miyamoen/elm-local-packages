module Page.ReadMe exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Font as Font
import Elm.Version
import Fake exposing (model)
import Html.Attributes
import Markdown exposing (defaultOptions)
import Route exposing (..)
import Types exposing (..)
import Url.Builder exposing (absolute)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view { allDocs, route } =
    Route.extractDocsKey route
        |> Maybe.andThen (\key -> AllDocs.find key allDocs)
        |> Maybe.map
            (\status ->
                case status of
                    Success { readMe } ->
                        paragraph [ Font.size Constant.fontSize ] [ markdown readMe ]

                    Failure ->
                        text "Failure"

                    Loading ->
                        text "loading"
            )
        |> Maybe.withDefault (text "no readme")


markdown : String -> Element msg
markdown raw =
    Markdown.toHtmlWith { defaultOptions | defaultHighlighting = Just "elm" }
        [ Html.Attributes.class "markdown-block" ]
        raw
        |> html


book : Book
book =
    bookWithFrontCover "ReadMe"
        (view
            { model
                | route =
                    Package "arowM" "elm-reference" <|
                        ReadMe Elm.Version.one
            }
            |> withCss
        )


main : Bibliopola.Program
main =
    fromBook book
