module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

{-| -}

import Browser exposing (..)
import Elm.Constraint exposing (Constraint)
import Elm.License exposing (License)
import Elm.Package exposing (Name)
import Elm.Project exposing (Deps, Exposed)
import Elm.Version exposing (Version)
import Html exposing (div, text)
import Json.Decode as Decode exposing (Decoder, Value)
import List.Extra
import SelectList exposing (SelectList)


type alias Model =
    { allPackages : List Package, errors : List Error }


type alias Package =
    SelectList PackageInfo


type alias PackageInfo =
    { name : String
    , summary : String
    , license : String
    , version : Version
    , deps : List ( String, Constraint )
    , testDeps : List ( String, Constraint )
    , path : String
    }


type Error
    = DecodeError Decode.Error


type Msg
    = NoOp


init : Value -> ( Model, Cmd Msg )
init elmJsons =
    let
        ( allPackages, errors ) =
            case Decode.decodeValue allPackagesDecoder (Debug.log "入力" elmJsons) of
                Ok value ->
                    ( value, [] )

                Err decodeError ->
                    ( [], [ DecodeError (Debug.log "decodeError" decodeError) ] )
    in
    ( { allPackages = allPackages, errors = errors }, Cmd.none )


allPackagesDecoder : Decoder (List Package)
allPackagesDecoder =
    Decode.list packageDecoder
        |> Decode.map
            (List.Extra.gatherWith (\p1 p2 -> Debug.log "p1.name" p1.name == p2.name)
                >> List.map
                    (\( first, versions ) ->
                        List.sortWith
                            (\p1 p2 -> Elm.Version.compare p1.version p2.version)
                            (first :: versions)
                            |> SelectList.fromList
                            |> Maybe.withDefault (SelectList.singleton first)
                    )
            )


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


depsDecoder : Decoder (List ( String, Constraint ))
depsDecoder =
    Decode.keyValuePairs Elm.Constraint.decoder


projectDecoder : Decoder Elm.Project.PackageInfo
projectDecoder =
    Elm.Project.decoder
        |> Decode.andThen
            (\project ->
                case project of
                    Elm.Project.Application _ ->
                        Decode.fail "Elm Project should be `package`. But actual is `application.`"

                    Elm.Project.Package info ->
                        Decode.succeed info
            )


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
        , div [] <| List.map (text << Debug.toString) model.allPackages
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
