module Page.Overview exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Elm.Version
import Fake
import List.Extra
import SelectList
import Types exposing (..)


view : String -> String -> Model -> Element msg
view author packageName model =
    let
        package =
            List.Extra.find
                (\versions ->
                    let
                        pkg =
                            SelectList.selected versions
                    in
                    pkg.authorName == author && pkg.packageName == packageName
                )
                model.allPackages
    in
    column []
        [ text "Local Cached Versions"
        , case package of
            Just package_ ->
                row [] <|
                    SelectList.selectedMap
                        (\_ selected ->
                            SelectList.selected selected
                                |> .version
                                |> Elm.Version.toString
                                |> text
                        )
                        package_

            Nothing ->
                text "package not found"
        ]


book : Book
book =
    bookWithFrontCover "Overview" (view "elm" "virtual-dom" Fake.model)


main : Bibliopola.Program
main =
    fromBook book
