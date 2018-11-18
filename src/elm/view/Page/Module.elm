module Page.Module exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Docs exposing (Block(..))
import Elm.Version
import Fake exposing (model)
import MarkdownBlock
import Status
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view { allDocs, route } =
    Route.moduleKey route
        |> Maybe.andThen (\key -> AllDocs.findModule key allDocs)
        |> Maybe.map (Status.view (Elm.Docs.toBlocks >> blocks))
        |> Maybe.withDefault (text "no module doc")


blocks : List Block -> Element msg
blocks blockList =
    column [] <| List.map block blockList


block : Block -> Element msg
block block_ =
    case block_ of
        MarkdownBlock raw ->
            MarkdownBlock.view raw

        UnionBlock _ ->
            Debug.todo "handle UnionBlock _"

        AliasBlock _ ->
            Debug.todo "handle AliasBlock _"

        ValueBlock _ ->
            Debug.todo "handle ValueBlock _"

        BinopBlock _ ->
            Debug.todo "handle BinopBlock _"

        UnknownBlock _ ->
            Debug.todo "handle UnknownBlock _"


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
