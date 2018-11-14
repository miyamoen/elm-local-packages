module Types exposing
    ( WithKey, Model, Msg(..)
    , Error(..)
    , Package, PackageInfo, Docs, AllDocs
    , Status(..)
    , findPackage
    )

{-|

@docs WithKey, Model, Msg
@docs Error
@docs Package, PackageInfo, Docs, AllDocs
@docs Status
@docs findPackage

-}

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Elm.Docs exposing (Module)
import Elm.Version exposing (Version)
import Json.Decode as Decode
import List.Extra
import Ports exposing (DocsResponse)
import Route exposing (Route)
import SelectList exposing (SelectList)
import Url exposing (Url)


type alias WithKey m =
    { m | key : Key }


type alias Model =
    { allPackages : List Package
    , allDocs : AllDocs
    , errors : List Error
    , route : Route
    }


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


type alias AllDocs =
    Dict ( String, String, String ) (Status Docs)


type alias Docs =
    { readMe : String
    , moduleDocs : List Module
    , authorName : String
    , packageName : String
    , version : Version
    }


type Status a
    = Loading
    | Failure
    | Success a


type Error
    = DecodeError Decode.Error


type Msg
    = NoOp
    | ClickedLink UrlRequest
    | UrlChanged Url
    | AcceptPackageDocs (Result Decode.Error DocsResponse)



-- functions


findPackage : String -> String -> List Package -> Maybe Package
findPackage authorName packageName packages =
    List.Extra.find
        (\versions ->
            let
                pkg =
                    SelectList.selected versions
            in
            pkg.authorName == authorName && pkg.packageName == packageName
        )
        packages
