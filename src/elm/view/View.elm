module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font exposing (typeface)
import Layout
import Page.Overview
import Page.Packages
import Page.ReadMe
import Route exposing (PackageRoute(..), Route(..))
import Types exposing (..)


view : WithKey Model -> Document Msg
view { errors, allPackages, allDocs, route } =
    let
        model =
            { errors = errors
            , allPackages = allPackages
            , allDocs = allDocs
            , route = route
            }
    in
    { title = "Elm Local Packages"
    , body =
        [ layout [ font, Font.color <| rgb255 41 60 75 ] <| help model ]
    }


font : Attribute msg
font =
    Font.family
        [ typeface "Source Sans Pro"
        , typeface "Trebuchet MS"
        , typeface "Lucida Grande"
        , typeface "Bitstream Vera Sans"
        , typeface "Helvetica Neue"
        , Font.sansSerif
        ]


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
                                Page.ReadMe.view model

                            Module version moduleName ->
                                text "handle Package _ _ (Module _ _)"

                    Nothing ->
                        text "package not found"
