port module Ports exposing
    ( DocsRequest, DocsResponse
    , fetchPackageDocs_, acceptPackageDocs_
    , docsResponseDecoder
    )

{-|

@docs DocsRequest, DocsResponse
@docs fetchPackageDocs_, acceptPackageDocs_
@docs docsResponseDecoder

-}

import Elm.Docs exposing (Module)
import Elm.Version exposing (Version)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias DocsRequest =
    { authorName : String, packageName : String, version : Version }


type alias DocsResponse =
    { readMe : String
    , moduleDocs : List Module
    , authorName : String
    , packageName : String
    , version : Version
    }


fetchPackageDocs_ : DocsRequest -> Cmd msg
fetchPackageDocs_ { authorName, packageName, version } =
    fetchPackageDocs
        { authorName = authorName
        , packageName = packageName
        , version = Elm.Version.encode version
        }


port fetchPackageDocs :
    { authorName : String
    , packageName : String
    , version : Encode.Value
    }
    -> Cmd msg


acceptPackageDocs_ : (Result Decode.Error DocsResponse -> msg) -> Sub msg
acceptPackageDocs_ tagger =
    acceptPackageDocs (Decode.decodeValue docsResponseDecoder >> tagger)


docsResponseDecoder : Decoder DocsResponse
docsResponseDecoder =
    Decode.map5 DocsResponse
        (Decode.field "readMe" Decode.string)
        (Decode.field "moduleDocs" <| Decode.list Elm.Docs.decoder)
        (Decode.field "authorName" Decode.string)
        (Decode.field "packageName" Decode.string)
        (Decode.field "version" Elm.Version.decoder)


port acceptPackageDocs : (Encode.Value -> msg) -> Sub msg
