module Types exposing
    ( WithKey, Model, Msg(..), msgToString
    , Error(..)
    , Route(..)
    , AuthorKey, PackageKey, DocsKey, ModuleKey
    , Package, PackageInfo
    , Docs, AllDocs
    , Status(..)
    )

{-|

@docs WithKey, Model, Msg, msgToString
@docs Error
@docs Route
@docs AuthorKey, PackageKey, DocsKey, ModuleKey
@docs Package, PackageInfo
@docs Docs, AllDocs
@docs Status

-}

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Elm.Docs exposing (Module)
import Elm.Version exposing (Version)
import Json.Decode as Decode
import Ports exposing (DocsResponse)
import SelectList exposing (SelectList)
import Url exposing (Url)


type alias WithKey m =
    { m | key : Key }


type alias Model =
    { allPackages : List Package
    , allDocs : AllDocs
    , errors : List Error
    , route : Route
    , query : String
    }


type Route
    = HomePage
    | NotFoundPage String
    | PackagesPage
    | PackagePage (PackageKey {})
    | ReadMePage (DocsKey {})
    | ModulePage (ModuleKey {})


type alias AuthorKey a =
    { a | authorName : String }


type alias PackageKey a =
    { a | authorName : String, packageName : String }


type alias DocsKey a =
    { a
        | authorName : String
        , packageName : String
        , version : Version
    }


type alias ModuleKey a =
    { a
        | authorName : String
        , packageName : String
        , version : Version
        , moduleName : String
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
    = ElmJsonDecodeError Decode.Error
    | DocsDecodeError Decode.Error


type Msg
    = NoOp
    | ClickedLink UrlRequest
    | UrlChanged Url
    | AcceptPackageDocs (Result Decode.Error DocsResponse)
    | NewQuery String


msgToString : Msg -> String
msgToString msg =
    case msg of
        NoOp ->
            "NoOp"

        ClickedLink urlRequest ->
            "ClickedLink"

        UrlChanged url ->
            "UrlChanged"

        AcceptPackageDocs docsResponseErrorDecodeResult ->
            "AcceptPackageDocs"

        NewQuery query ->
            "NewQuery: " ++ query
