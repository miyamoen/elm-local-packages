module Views.Organisms.Routing exposing (view)

import Element exposing (Element, text)
import SelectList
import Types exposing (Model, Msg, Route(..))
import Views.Organisms.Layout as Layout
import Views.Pages.Module
import Views.Pages.Overview
import Views.Pages.Packages
import Views.Pages.ReadMe


view : Model -> Element Msg
view model =
    Layout.view model <|
        case SelectList.selected model.routes of
            NotFoundPage url ->
                text <| "TODO: NotFound " ++ url

            HomePage ->
                Views.Pages.Packages.view model

            PackagesPage ->
                Views.Pages.Packages.view model

            PackagePage _ ->
                Views.Pages.Overview.view model

            ReadMePage _ ->
                Views.Pages.ReadMe.view model

            ModulePage _ ->
                Views.Pages.Module.view model
