module Main exposing (init, main, subscriptions, update)

{-| -}

import Browser exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Decoder
import Json.Decode as Decode exposing (Value)
import Ports
import SelectList
import Types exposing (..)
import Types.AllDocs as AllDocs
import Types.Packages as Packages
import Types.Route as Route
import Url exposing (Url)
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
    ( { allPackages = Packages.sort allPackages
      , allDocs = AllDocs.init
      , errors = List.map ElmJsonDecodeError errors
      , routes = SelectList.singleton <| Route.parse url
      , query = ""
      }
        |> WithKey key
    , Cmd.none
    )


update : Msg -> WithKey Model -> ( WithKey Model, Cmd Msg )
update msg (WithKey key model) =
    case msg of
        NoOp ->
            ( WithKey key model, Cmd.none )

        ClickedLink (Internal url) ->
            case Route.parse url |> Route.docsKey of
                Just docsKey ->
                    ( WithKey key
                        { model | allDocs = AllDocs.initKey docsKey model.allDocs }
                    , Cmd.batch
                        [ Ports.fetchPackageDocs_ docsKey
                        , Nav.pushUrl key <| Url.toString url
                        ]
                    )

                Nothing ->
                    ( WithKey key model, Nav.pushUrl key <| Url.toString url )

        ClickedLink (External url) ->
            ( WithKey key model, Nav.load url )

        UrlChanged url ->
            ( { model
                | routes =
                    SelectList.replaceSelected (Route.parse url) model.routes
              }
                |> WithKey key
            , Cmd.none
            )

        AcceptPackageDocs (Ok docs) ->
            ( WithKey key
                { model | allDocs = AllDocs.insert docs docs model.allDocs }
            , Cmd.none
            )

        AcceptPackageDocs (Err err) ->
            ( { model | errors = DocsDecodeError err :: model.errors }
                |> WithKey key
            , Cmd.none
            )

        NewQuery new ->
            ( WithKey key { model | query = new }, Cmd.none )


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
