module Views.Organisms.Navigation exposing (view)

import Element exposing (Element, none)
import SelectList
import Types exposing (..)
import Types.Packages as Packages
import Types.Route as Route
import Views.Organisms.ModuleLinks as ModuleLinks


view : Model -> Element msg
view { allDocs, allPackages, routes } =
    Route.docsKey (SelectList.selected routes)
        |> Maybe.andThen
            (\key ->
                Packages.find key allPackages
                    |> Maybe.map (Packages.latest >> .exposed >> ModuleLinks.view key)
            )
        |> Maybe.withDefault none
