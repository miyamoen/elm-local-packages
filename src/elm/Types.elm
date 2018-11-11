module Types exposing
    ( WithKey, Model, Msg(..)
    , Error(..)
    , Package, PackageInfo
    )

{-|

@docs WithKey, Model, Msg
@docs Error
@docs Package, PackageInfo

-}

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Elm.Version exposing (Version)
import Json.Decode as Decode
import Route exposing (Route)
import SelectList exposing (SelectList)
import Url exposing (Url)


type alias WithKey m =
    { m | key : Key }


type alias Model =
    { allPackages : List Package, errors : List Error, route : Route }


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
    | ClickedLink UrlRequest
    | UrlChanged Url
