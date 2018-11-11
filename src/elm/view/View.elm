module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Layout
import Page.Overview
import Page.Packages
import Route exposing (PackageRoute(..), Route(..))
import Types exposing (..)


view : WithKey Model -> Document Msg
view { errors, allPackages, route } =
    let
        model =
            { errors = errors, allPackages = allPackages, route = route }
    in
    { title = "Elm Local Packages"
    , body =
        [ layout [] <| help model ]
    }


help : Model -> Element Msg
help model =
    Layout.view model <|
        case model.route of
            NotFound url ->
                text <| "TODO: NotFound " ++ url

            Home ->
                Page.Packages.view model

            Packages ->
                Page.Packages.view model

            Package authorName packageName packageRoute ->
                case findPackage authorName packageName model.allPackages of
                    Just package ->
                        case packageRoute of
                            Overview ->
                                Page.Overview.view package model

                            ReadMe version ->
                                text "handle Package _ _ (ReadMe _)"

                            Module version moduleName ->
                                text "handle Package _ _ (Module _ _)"

                    Nothing ->
                        text "package not found"
