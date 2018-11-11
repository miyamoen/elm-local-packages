module Page.Packages exposing (view)

{-|

@docs view, book

-}

import Element exposing (..)
import PackageSummary
import Types exposing (..)


view : Model -> Element msg
view model =
    column [] <|
        List.map PackageSummary.view model.allPackages
