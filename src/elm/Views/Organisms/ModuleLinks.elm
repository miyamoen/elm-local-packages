module Views.Organisms.ModuleLinks exposing (book, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Docs exposing (Module)
import Elm.Version as Version
import Fake
import Types exposing (..)
import Types.Route as Route
import Views.Atoms.Link as Link
import Views.Constants as Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : DocsKey a -> List Module -> Element msg
view key moduleDocs =
    column [ spacing Constants.padding ]
        [ Link.view [] <| readMeLink key
        , column [ spacing fontSize.tiny ] <|
            List.map (.name >> moduleLink key >> Link.view []) moduleDocs
        ]


moduleLink : DocsKey a -> String -> { url : String, label : Element msg }
moduleLink key moduleName =
    { label = text moduleName
    , url =
        Route.moduleUrl
            { authorName = key.authorName
            , packageName = key.packageName
            , version = key.version
            , moduleName = moduleName
            }
    }


readMeLink : DocsKey a -> { url : String, label : Element msg }
readMeLink key =
    { label = text "README", url = Route.readMeUrl key }


book : Book
book =
    bookWithFrontCover "ModuleLinks" (view fakeKey Fake.moduleDocs |> withFrame)


fakeKey : DocsKey {}
fakeKey =
    { authorName = "miyamoen"
    , packageName = "select-list"
    , version = Version.fromString "4.0.0" |> Maybe.withDefault Version.one
    }


main : Bibliopola.Program
main =
    fromBook book
