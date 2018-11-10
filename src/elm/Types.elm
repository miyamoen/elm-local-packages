module Types exposing (Error(..), Model, Msg(..), Package, PackageInfo)

{-| -}

import Elm.Version exposing (Version)
import Json.Decode as Decode
import SelectList exposing (SelectList)


type alias Model =
    { allPackages : List Package, errors : List Error }


type alias Package =
    SelectList PackageInfo


type alias PackageInfo =
    { name : String
    , authorName : String
    , packageName : String
    , summary : String
    , license : String
    , version : Version
    , deps : List ( String, String )
    , testDeps : List ( String, String )
    , path : String
    }


type Error
    = DecodeError Decode.Error


type Msg
    = NoOp
