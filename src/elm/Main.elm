module Main exposing (update)

{-| -}

import Browser exposing (..)
import Element exposing (column, fill, layout, row, width)
import Elm.Version
import Html exposing (div, text)
import Json.Decode as Decode exposing (Decoder, Value)
import List.Extra
import PackageSummary
import SelectList
import Types exposing (..)


init : Value -> ( Model, Cmd Msg )
init elmJsons =
    let
        ( allPackages, errors ) =
            case Decode.decodeValue allPackagesDecoder elmJsons of
                Ok value ->
                    ( value, [] )

                Err decodeError ->
                    ( [], [ DecodeError decodeError ] )
    in
    ( { allPackages = allPackages, errors = errors }, Cmd.none )


allPackagesDecoder : Decoder (List Package)
allPackagesDecoder =
    Decode.map
        (List.Extra.gatherEqualsBy .name
            >> List.map
                (\( first, versions ) ->
                    List.sortWith
                        (\p1 p2 -> Elm.Version.compare p2.version p1.version)
                        (first :: versions)
                        |> SelectList.fromList
                        |> Maybe.withDefault (SelectList.singleton first)
                )
        )
    <|
        Decode.list packageDecoder


packageDecoder : Decoder PackageInfo
packageDecoder =
    Decode.map7 PackageInfo
        (Decode.field "name" Decode.string)
        (Decode.field "summary" Decode.string)
        (Decode.field "license" Decode.string)
        (Decode.field "version" Elm.Version.decoder)
        (Decode.field "dependencies" depsDecoder)
        (Decode.field "test-dependencies" depsDecoder)
        (Decode.field "path" Decode.string)


depsDecoder : Decoder (List ( String, String ))
depsDecoder =
    Decode.keyValuePairs Decode.string


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
