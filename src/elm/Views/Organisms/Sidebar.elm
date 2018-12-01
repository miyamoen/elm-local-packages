module Views.Organisms.Sidebar exposing (view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Elm.Docs exposing (Module)
import Elm.Version as Version
import Fake
import Types exposing (..)
import Types.AllDocs as AllDocs
import Types.Route as Route
import Types.Status as Status
import Views.Colors as Colors
import Views.Constants as Constants exposing (fontSize)
import Views.Organisms.ModuleLinks as ModuleLinks
import Views.Utils exposing (withFrame)


view : Model -> Maybe (Element msg)
view { route, allDocs } =
    case Route.docsKey route of
        Just key ->
            AllDocs.find key allDocs
                |> Maybe.andThen Status.toMaybe
                |> Maybe.map (.moduleDocs >> ModuleLinks.view key)

        Nothing ->
            Nothing
