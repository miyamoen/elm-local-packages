module Breadcrumbs exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Constant
import Element exposing (..)
import Element.Font as Font
import Elm.Version as Version
import Route exposing (Route)
import Types exposing (..)
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Route -> Element msg
view route =
    List.filterMap identity
        [ Route.authorKey route |> Maybe.map authorLink
        , Route.packageKey route |> Maybe.map packageLink
        , Route.docsKey route |> Maybe.map docsLink
        , Route.moduleKey route |> Maybe.map moduleLink
        ]
        |> List.intersperse (text "/")
        |> row [ spacing 10, Font.size <| round <| Constant.fontSize * 1.5 ]


authorLink : Route.AuthorKey a -> Element msg
authorLink { authorName } =
    text authorName


packageLink : Route.PackageKey a -> Element msg
packageLink key =
    link [ Font.color Constant.linkColor ]
        { label = text key.packageName, url = Route.packageAsString key }


docsLink : Route.DocsKey a -> Element msg
docsLink key =
    link [ Font.color Constant.linkColor ]
        { label = text <| Version.toString key.version
        , url = Route.readMeAsString key
        }


moduleLink : Route.ModuleKey a -> Element msg
moduleLink key =
    link [ Font.color Constant.linkColor ]
        { label = text key.moduleName
        , url = Route.moduleAsString key
        }


book : Book
book =
    intoBook "Breadcrumbs" identity (view >> withCss)
        |> addStory
            (Story "route"
                [ ( "home", Route.home )
                , ( "packages", Route.packages )
                , ( "package", Route.package fakeKey )
                , ( "readMe", Route.readMe fakeKey )
                , ( "module", Route.moduleRoute fakeKey )
                ]
            )
        |> buildBook
        |> withFrontCover (view Route.home |> withCss)


fakeKey : Route.ModuleKey {}
fakeKey =
    { authorName = "miyamoen"
    , packageName = "bibliopola"
    , version = Version.fromString "2.0.1" |> Maybe.withDefault Version.one
    , moduleName = "Bibliopola.Story"
    }


main : Bibliopola.Program
main =
    fromBook book
