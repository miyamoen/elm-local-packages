module Views.Organisms.Navigation exposing (view)

import Element exposing (Element, none)
import Types exposing (..)
import Types.Packages as Packages
import Types.Route as Route
import Views.Organisms.ModuleLinks as ModuleLinks


view : Route -> Model -> Element msg
view route { allDocs, allPackages } =
    Route.docsKey route
        |> Maybe.andThen
            (\key ->
                Packages.find key allPackages
                    |> Maybe.map (Packages.latest >> .exposed >> ModuleLinks.view key)
            )
        |> Maybe.withDefault none
