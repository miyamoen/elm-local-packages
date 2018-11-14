module Main exposing (update)

{-| -}

import Browser exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Decoder
import Dict
import Elm.Version
import Json.Decode as Decode exposing (Value)
import Ports
import Route
import Types exposing (..)
import Url exposing (Url)
import Url.Parser
import View exposing (view)


init : Value -> Url -> Key -> ( WithKey Model, Cmd Msg )
init elmJsons url key =
    let
        ( allPackages, errors ) =
            case Decode.decodeValue Decoder.allPackages elmJsons of
                Ok value ->
                    ( value, [] )

                Err decodeError ->
                    ( [], [ DecodeError decodeError ] )
    in
    ( { key = key
      , allPackages = allPackages
      , allDocs = Dict.empty
      , errors = errors
      , route = Route.parse url
      }
    , Cmd.none
    )


update : Msg -> WithKey Model -> ( WithKey Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedLink (Internal url) ->
            ( { model | allDocs = insertNewDocs url model.allDocs }
            , Cmd.batch
                [ fetchDocsIf url
                , Nav.pushUrl model.key <| Url.toString url
                ]
            )

        ClickedLink (External url) ->
            ( model, Nav.load url )

        UrlChanged url ->
            ( { model | route = Route.parse url }, Cmd.none )

        AcceptPackageDocs (Ok docs) ->
            ( { model
                | allDocs =
                    Dict.insert
                        ( docs.authorName
                        , docs.packageName
                        , Elm.Version.toString docs.version
                        )
                        (Success docs)
                        model.allDocs
              }
            , Cmd.none
            )

        AcceptPackageDocs (Err err) ->
            ( { model | errors = DecodeError err :: model.errors }, Cmd.none )


fetchDocsIf : Url -> Cmd msg
fetchDocsIf url =
    Route.parse url
        |> Route.extractVersion
        |> Maybe.map Ports.fetchPackageDocs_
        |> Maybe.withDefault Cmd.none


insertNewDocs : Url -> AllDocs -> AllDocs
insertNewDocs url allDocs =
    case Route.parse url |> Route.extractVersion of
        Just { authorName, packageName, version } ->
            case Dict.get ( authorName, packageName, Elm.Version.toString version ) allDocs of
                Just _ ->
                    allDocs

                Nothing ->
                    Dict.insert ( authorName, packageName, Elm.Version.toString version ) Loading allDocs

        Nothing ->
            allDocs


subscriptions : WithKey Model -> Sub Msg
subscriptions _ =
    Ports.acceptPackageDocs_ AcceptPackageDocs


main : Program Value (WithKey Model) Msg
main =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChanged
        }
