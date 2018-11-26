module Main exposing (update)

{-| -}

import Browser exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Decoder
import Elm.Version
import Json.Decode as Decode exposing (Value)
import Ports
import Route
import Types exposing (..)
import Url exposing (Url)
import Url.Parser
import Util.AllDocs as AllDocs
import Util.Packages as Packages
import Util.Route as Route
import View exposing (view)


init : Value -> Url -> Key -> ( WithKey Model, Cmd Msg )
init elmJsons url key =
    let
        ( errors, allPackages ) =
            case Decode.decodeValue Decoder.allPackages elmJsons of
                Ok value ->
                    value

                Err decodeError ->
                    ( [ decodeError ], [] )
    in
    ( { key = key
      , allPackages = Packages.sort allPackages
      , allDocs = AllDocs.init
      , errors = List.map ElmJsonDecodeError errors
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
            case Route.parse url |> Route.docsKey of
                Just docsKey ->
                    ( { model | allDocs = AllDocs.initKey docsKey model.allDocs }
                    , Cmd.batch
                        [ Ports.fetchPackageDocs_ docsKey
                        , Nav.pushUrl model.key <| Url.toString url
                        ]
                    )

                Nothing ->
                    ( model, Nav.pushUrl model.key <| Url.toString url )

        ClickedLink (External url) ->
            ( model, Nav.load url )

        UrlChanged url ->
            ( { model | route = Route.parse url }, Cmd.none )

        AcceptPackageDocs (Ok docs) ->
            ( { model | allDocs = AllDocs.insert docs docs model.allDocs }
            , Cmd.none
            )

        AcceptPackageDocs (Err err) ->
            ( { model | errors = DocsDecodeError err :: model.errors }, Cmd.none )


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
