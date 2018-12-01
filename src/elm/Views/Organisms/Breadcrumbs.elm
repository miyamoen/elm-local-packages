module Views.Organisms.Breadcrumbs exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (Element, text)
import Elm.Version as Version
import Types exposing (..)
import Types.Route as Route
import Views.Atoms.Breadcrumbs
import Views.Atoms.Link as Link
import Views.Utils exposing (withFrame)


view : Route -> Element msg
view route =
    Views.Atoms.Breadcrumbs.view <|
        List.filterMap identity
            [ Route.authorKey route |> Maybe.map authorLink
            , Route.packageKey route |> Maybe.map packageLink
            , Route.docsKey route |> Maybe.map docsLink
            , Route.moduleKey route |> Maybe.map moduleLink
            ]


authorLink : AuthorKey a -> Element msg
authorLink { authorName } =
    text authorName


packageLink : PackageKey a -> Element msg
packageLink key =
    Link.view []
        { label = text key.packageName
        , url = Route.packageUrl key
        }


docsLink : DocsKey a -> Element msg
docsLink key =
    Link.view []
        { label = text <| Version.toString key.version
        , url = Route.readMeUrl key
        }


moduleLink : ModuleKey a -> Element msg
moduleLink key =
    Link.view []
        { label = text key.moduleName
        , url = Route.moduleUrl key
        }


book : Book
book =
    intoBook "Breadcrumbs" identity (view >> withFrame)
        |> addStory
            (Story "route"
                [ ( "module", Route.moduleRoute fakeKey )
                , ( "readMe", Route.readMe fakeKey )
                , ( "package", Route.package fakeKey )
                , ( "packages", Route.packages )
                , ( "home", Route.home )
                ]
            )
        |> buildBook
        |> withFrontCover
            (view (Route.moduleRoute fakeKey)
                |> withFrame
            )


fakeKey : ModuleKey {}
fakeKey =
    { authorName = "miyamoen"
    , packageName = "bibliopola"
    , version = Version.fromString "2.0.1" |> Maybe.withDefault Version.one
    , moduleName = "Bibliopola.Story"
    }


main : Bibliopola.Program
main =
    fromBook book
