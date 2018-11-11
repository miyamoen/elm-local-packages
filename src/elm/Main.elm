module Main exposing (update)

{-| -}

import Browser exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Decoder
import Json.Decode as Decode exposing (Value)
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
      , errors = errors
      , route =
            Url.Parser.parse Route.route url
                |> Maybe.withDefault Route.NotFound
      }
    , Cmd.none
    )


update : Msg -> WithKey Model -> ( WithKey Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedLink (Internal url) ->
            ( model, Nav.pushUrl model.key <| Url.toString url )

        ClickedLink (External url) ->
            ( model, Nav.load url )

        UrlChanged url ->
            ( { model
                | route =
                    Url.Parser.parse Route.route url
                        |> Maybe.withDefault Route.NotFound
              }
            , Cmd.none
            )


subscriptions : WithKey Model -> Sub Msg
subscriptions _ =
    Sub.none


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
