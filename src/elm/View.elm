module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font exposing (typeface)
import SelectList exposing (Position(..), SelectList)
import Types exposing (..)
import Types.Packages as Packages
import Types.Route as Route
import Views.Organisms.Layout as Layout
import Views.Pages.Module
import Views.Pages.Overview
import Views.Pages.Packages
import Views.Pages.ReadMe
import Views.Utils exposing (rootAttributes)


view : WithKey Model -> Document Msg
view (WithKey _ model) =
    { title = "Elm Local Packages"
    , body =
        [ layoutWith
            { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] }
            rootAttributes
          <|
            multiView model
        ]
    }


multiView : Model -> Element Msg
multiView model =
    column [ width fill, spaceEvenly ] <|
        SelectList.selectedMap (singleView model) model.routes


singleView : Model -> Position -> SelectList Route -> Element Msg
singleView model position currentRoute =
    routing <| { model | routes = currentRoute }


routing : Model -> Element Msg
routing model =
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
