module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Layout
import Page.Packages
import Types exposing (..)


view : WithKey Model -> Document Msg
view { errors, allPackages } =
    let
        model =
            { errors = errors, allPackages = allPackages }
    in
    { title = "Elm Local Packages"
    , body =
        [ layout [] <| Layout.view model <| Page.Packages.view model ]
    }
