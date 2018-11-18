module Page.Module exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant exposing (fontSize)
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Docs exposing (Block(..), Module)
import Elm.Type exposing (Type(..))
import Elm.Version
import Fake exposing (model)
import MarkdownBlock
import Status
import TypeAnnotation
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view { allDocs, route } =
    Route.moduleKey route
        |> Maybe.andThen (\key -> AllDocs.findModule key allDocs)
        |> Maybe.map
            (Status.view help)
        |> Maybe.withDefault (text "no module doc")


help : Module -> Element msg
help moduleDoc =
    column [ paddingXY 0 fontSize.large ]
        [ el [ Font.size fontSize.huge ] <| text moduleDoc.name
        , Elm.Docs.toBlocks moduleDoc |> blocks
        ]


blocks : List Block -> Element msg
blocks blockList =
    column [ spacing fontSize.large ] <| List.map block blockList


block : Block -> Element msg
block block_ =
    case block_ of
        MarkdownBlock raw ->
            el
                [ paddingEach
                    { top = fontSize.large
                    , right = 0
                    , bottom = 0
                    , left = 0
                    }
                ]
            <|
                MarkdownBlock.view raw

        UnionBlock { name, comment, args, tags } ->
            column
                [ Border.widthEach { bottom = 0, left = 0, right = 0, top = 1 }
                , Border.color Constant.color.lightGrey
                ]
                []

        AliasBlock _ ->
            text "handle AliasBlock _"

        ValueBlock _ ->
            text "handle ValueBlock _"

        BinopBlock _ ->
            text "handle BinopBlock _"

        UnknownBlock _ ->
            text "handle UnknownBlock _"


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
