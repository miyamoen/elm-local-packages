module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font exposing (typeface)
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
view { errors, allPackages, allDocs, route, query } =
    let
        model =
            { errors = errors
            , allPackages = allPackages
            , allDocs = allDocs
            , route = route
            , query = query
            }
    in
    { title = "Elm Local Packages"
    , body =
        [ layoutWith
            { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] }
            rootAttributes
          <|
            routing model
        ]
    }


routing : Model -> Element Msg
routing model =
    Layout.view model <|
        case model.route of
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
