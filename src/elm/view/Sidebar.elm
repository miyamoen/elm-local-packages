module Sidebar exposing (view)

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Font as Font
import Elm.Docs exposing (Module)
import Elm.Version as Version
import Fake
import Route exposing (DocsKey)
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import Util.Status as Status
import ViewUtil exposing (withCss)


view : Model -> Maybe (Element msg)
view { route, allDocs } =
    case Route.docsKey route of
        Just key ->
            AllDocs.find key allDocs
                |> Maybe.andThen Status.toMaybe
                |> Maybe.map (.moduleDocs >> moduleList key)

        Nothing ->
            Nothing


moduleList : DocsKey a -> List Module -> Element msg
moduleList key moduleDocs =
    column [ spacing <| Constant.padding // 2 ]
        [ readMeLink key
        , el [ Font.size Constant.fontSize.middle ] <| text "Module Docs"
        , column [] <| List.map (moduleLink key) moduleDocs
        ]


moduleLink : DocsKey a -> Module -> Element msg
moduleLink key { name } =
    link
        [ height <| px Constant.fontSize.middle
        , Font.color Constant.color.link
        , mouseOver [ Font.color Constant.color.accent ]
        ]
        { label = el [ centerY ] <| text name
        , url =
            Route.moduleAsString
                { authorName = key.authorName
                , packageName = key.packageName
                , version = key.version
                , moduleName = name
                }
        }


readMeLink : DocsKey a -> Element msg
readMeLink key =
    link
        [ height <| px Constant.fontSize.middle
        , Font.color Constant.color.link
        , mouseOver [ Font.color Constant.color.accent ]
        ]
        { label = el [ centerY ] <| text "README"
        , url = Route.readMeAsString key
        }


book : Book
book =
    bookWithFrontCover "Sidebar" (moduleList fakeKey Fake.moduleDocs |> withCss)


fakeKey : DocsKey {}
fakeKey =
    { authorName = "miyamoen"
    , packageName = "select-list"
    , version = Version.fromString "4.0.0" |> Maybe.withDefault Version.one
    }


main : Bibliopola.Program
main =
    fromBook book
