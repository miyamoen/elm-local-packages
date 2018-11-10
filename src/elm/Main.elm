module Main exposing (update)

{-| -}

import Browser exposing (..)
import Decoder
import Element exposing (column, fill, layout, row, width)
import Html exposing (div, text)
import Json.Decode as Decode exposing (Value)
import PackageSummary
import Types exposing (..)


init : Value -> ( Model, Cmd Msg )
init elmJsons =
    let
        ( allPackages, errors ) =
            case Decode.decodeValue Decoder.allPackages elmJsons of
                Ok value ->
                    ( value, [] )

                Err decodeError ->
                    ( [], [ DecodeError decodeError ] )
    in
    ( { allPackages = allPackages, errors = errors }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "Elm Local Packages"
    , body =
        [ div [] [ text "Elmだよ" ]
        , div [] [ text <| Debug.toString model.errors ]
        , layout [] <|
            column [ width fill ] <|
                List.map PackageSummary.view model.allPackages
        ]
    }


main : Program Value Model Msg
main =
    document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
