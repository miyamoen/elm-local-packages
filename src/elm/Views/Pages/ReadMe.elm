module Views.Pages.ReadMe exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Version
import Fake exposing (model)
import SelectList
import Types exposing (..)
import Types.AllDocs as AllDocs
import Types.Route as Route
import Views.Atoms.MarkdownBlock as MarkdownBlock
import Views.Atoms.Status as Status
import Views.Utils exposing (withFrame)


view : Model -> Element msg
view { allDocs, routes } =
    Route.docsKey (SelectList.selected routes)
        |> Maybe.andThen (\key -> AllDocs.find key allDocs)
        |> Maybe.map (Status.view (.readMe >> MarkdownBlock.wrapped ""))
        |> Maybe.withDefault (text "no readme")


book : Book
book =
    bookWithFrontCover "ReadMe"
        (view
            { model
                | routes =
                    SelectList.singleton <|
                        Route.readMe
                            { authorName = "arowM"
                            , packageName = "elm-reference"
                            , version = Elm.Version.one
                            }
            }
            |> withFrame
        )


main : Bibliopola.Program
main =
    fromBook book
