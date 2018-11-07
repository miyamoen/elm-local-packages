module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

{-| -}

import Browser exposing (..)
import Html exposing (div, text)
import Json.Decode exposing (Value)


type alias Model =
    { v : Value }


type Msg
    = NoOp


init : Value -> ( Model, Cmd Msg )
init elmJsons =
    ( { v = elmJsons }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "hi"
    , body =
        [ div [] [ text "Elmだよ" ]
        , div [] [ text <| Debug.toString model.v ]
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
