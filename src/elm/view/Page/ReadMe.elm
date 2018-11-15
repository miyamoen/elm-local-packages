module Page.ReadMe exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Version
import Fake exposing (model)
import MarkdownBlock
import Route exposing (..)
import Types exposing (..)
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
                        MarkdownBlock.view readMe

                    Failure ->
                        text "Failure"

                    Loading ->
                        text "loading"
            )
        |> Maybe.withDefault (text "no readme")


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
