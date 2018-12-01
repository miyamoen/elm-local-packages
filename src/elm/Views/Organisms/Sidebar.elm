module Views.Organisms.Sidebar exposing (view)

import Element exposing (Element)
import Types exposing (..)
import Types.AllDocs as AllDocs
import Types.Route as Route
import Types.Status as Status
import Views.Organisms.ModuleLinks as ModuleLinks


view : Model -> Maybe (Element msg)
view { route, allDocs } =
    case Route.docsKey route of
        Just key ->
            AllDocs.find key allDocs
                |> Maybe.andThen Status.toMaybe
                |> Maybe.map (.moduleDocs >> ModuleLinks.view key)

        Nothing ->
            Nothing
