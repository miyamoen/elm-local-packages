module Page.Packages exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant exposing (fontSize)
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (labelHidden, placeholder)
import Fake
import Json.Decode as Decode
import PackageSummary
import Types exposing (..)
import Util.Packages
import ViewUtil exposing (withCss)


view : Model -> Element Msg
view model =
    column [ width fill ]
        [ Input.text [ Border.rounded 8, padding 10, Font.size fontSize.middle ]
            { onChange = NewQuery
            , text = model.query
            , placeholder =
                if String.isEmpty model.query then
                    Just <| placeholder [] <| text "Search"

                else
                    Nothing
            , label = labelHidden "search"
            }
        , column [ width fill ] <|
            List.map PackageSummary.view <|
                Util.Packages.filter model.query model.allPackages
        , column [ width fill, spacing Constant.padding ] <|
            List.map viewError model.errors
        ]


viewError : Error -> Element msg
viewError error =
    case error of
        ElmJsonDecodeError decodeError ->
            column [ width fill, spacing 5 ]
                [ text "elm.json deecode failed"
                , text <| Decode.errorToString decodeError
                ]

        DocsDecodeError decodeError ->
            column [ width fill ]
                [ text "docs.json decode failed"
                , text <| Decode.errorToString decodeError
                ]


book : Book
book =
    bookWithFrontCover "Packages"
        (view Fake.model
            |> withCss
            |> Element.map msgToString
        )


main : Bibliopola.Program
main =
    fromBook book
