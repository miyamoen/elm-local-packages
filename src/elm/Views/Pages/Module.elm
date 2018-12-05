module Views.Pages.Module exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Elm.Docs exposing (Block(..), Module)
import Elm.Version
import Fake exposing (model)
import SelectList
import Types exposing (..)
import Types.AllDocs as AllDocs
import Types.Route as Route
import Views.Atoms.Status as Status
import Views.Constants as Constants exposing (fontSize)
import Views.Organisms.DocBlock as DocBlock exposing (makeInfo)
import Views.Utils exposing (withFrame)


view : Model -> Element msg
view { allDocs, routes } =
    Route.moduleKey (SelectList.selected routes)
        |> Maybe.andThen (\key -> AllDocs.findModule key allDocs)
        |> Maybe.map (Status.view help)
        |> Maybe.withDefault (text "no module doc")


help : ( Docs, Module ) -> Element msg
help ( { authorName, packageName, version, moduleDocs }, moduleDoc ) =
    column [ width fill, spacing fontSize.large ]
        [ el [ Font.size fontSize.huge ] <| text moduleDoc.name
        , column [ width fill, spacing <| fontSize.normal ] <|
            (List.map
                (DocBlock.view <|
                    makeInfo authorName
                        packageName
                        version
                        moduleDoc.name
                        moduleDocs
                )
             <|
                Elm.Docs.toBlocks moduleDoc
            )
        ]


book : Book
book =
    bookWithFrontCover "Module"
        (view
            { model
                | routes =
                    SelectList.singleton <|
                        Route.moduleRoute
                            { authorName = "arowM"
                            , packageName = "elm-reference"
                            , version = Elm.Version.one
                            , moduleName = "Reference"
                            }
            }
            |> withFrame
        )


main : Bibliopola.Program
main =
    fromBook book
