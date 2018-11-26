module Page.Packages exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Fake
import Json.Decode as Decode
import PackageSummary
import Types exposing (..)
import ViewUtil exposing (withCss)


view : Model -> Element msg
view model =
    column [ width fill, spacing <| 2 * Constant.padding ]
        [ column [ width fill ] <|
            List.map PackageSummary.view model.allPackages
        , column [ spacing Constant.padding ] <|
            List.map viewError model.errors
        ]


viewError : Error -> Element msg
viewError error =
    case error of
        ElmJsonDecodeError decodeError ->
            column [ spacing 5 ]
                [ text "elm.json deecode failed"
                , text <| Decode.errorToString decodeError
                ]

        DocsDecodeError decodeError ->
            column []
                [ text "docs.json decode failed"
                , text <| Decode.errorToString decodeError
                ]


book : Book
book =
    bookWithFrontCover "Packages" (view Fake.model |> withCss)


main : Bibliopola.Program
main =
    fromBook book
