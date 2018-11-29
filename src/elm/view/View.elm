module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font exposing (typeface)
import Layout
import Page.Module
import Page.Overview
import Page.Packages
import Page.ReadMe
import Route exposing (Route(..))
import Types exposing (..)
import Util.Packages as Packages
import Util.Route as Route
import ViewUtil exposing (rootAttributes)


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
            NotFound url ->
                text <| "TODO: NotFound " ++ url

            Home ->
                Page.Packages.view model

            Packages ->
                Page.Packages.view model

            Package _ ->
                Page.Overview.view model

            ReadMe _ ->
                Page.ReadMe.view model

            Module _ ->
                Page.Module.view model
