module Page.ReadMe exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Dict
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake exposing (model)
import Html.Attributes
import Markdown exposing (defaultOptions)
import Route exposing (..)
import SelectList
import Types exposing (..)
import Url.Builder exposing (absolute)


view : Model -> Element msg
view { allDocs, route } =
    el [ Font.size 16 ]
        (Route.extractVersion route
            |> Maybe.andThen
                (\{ authorName, packageName, version } ->
                    Dict.get
                        ( authorName
                        , packageName
                        , Elm.Version.toString version
                        )
                        allDocs
                )
            |> Maybe.map
                (\status ->
                    case status of
                        Success { readMe } ->
                            markdown readMe

                        Failure ->
                            text "Failure"

                        Loading ->
                            text "loading"
                )
            |> Maybe.withDefault (text "no readme")
        )


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
        )


main : Bibliopola.Program
main =
    fromBook book
