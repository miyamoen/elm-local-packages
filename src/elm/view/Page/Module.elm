module Page.Module exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant exposing (fontSize)
import DocBlock exposing (makeInfo)
import Element exposing (..)
import Element.Font as Font
import Elm.Docs exposing (Block(..), Module)
import Elm.Version
import Fake exposing (model)
import Status
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view { allDocs, route } =
    Route.moduleKey route
        |> Maybe.andThen (\key -> AllDocs.findModule key allDocs)
        |> Maybe.map (Status.view help)
        |> Maybe.withDefault (text "no module doc")


help : ( Docs, Module ) -> Element msg
help ( { authorName, packageName, version, moduleDocs }, moduleDoc ) =
    column [ width fill, paddingXY 0 fontSize.large ]
        [ el [ Font.size fontSize.huge ] <| text moduleDoc.name
        , column [ width fill, spacing fontSize.large ] <|
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
                | route =
                    Route.moduleRoute
                        { authorName = "arowM"
                        , packageName = "elm-reference"
                        , version = Elm.Version.one
                        , moduleName = "Reference"
                        }
            }
            |> withCss
        )


main : Bibliopola.Program
main =
    fromBook book
