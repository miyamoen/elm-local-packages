module Route exposing
    ( Route(..)
    , AuthorKey, PackageKey, DocsKey, ModuleKey
    , parser, parse, toString
    )

{-|

@docs Route
@docs AuthorKey, PackageKey, DocsKey, ModuleKey
@docs parser, parse, toString

-}

import Elm.Version exposing (Version)
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser exposing (..)


type Route
    = Home
    | NotFound String
    | Packages
    | Package (PackageKey {})
    | ReadMe (DocsKey {})
    | Module (ModuleKey {})


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


toString : Route -> String
toString route =
    case route of
        Home ->
            absolute [] []

        NotFound string ->
            absolute [ "notfound" ] []

        Packages ->
            absolute [ "packages" ] []

        Package key ->
            absolute [ "packages", key.authorName, key.packageName ] []

        ReadMe key ->
            absolute
                [ "packages"
                , key.authorName
                , key.packageName
                , Elm.Version.toString key.version
                ]
                []

        Module key ->
            absolute
                [ "packages"
                , key.authorName
                , key.packageName
                , Elm.Version.toString key.version
                , String.replace "." "-" key.moduleName
                ]
                []


parse : Url -> Route
parse url =
    Url.Parser.parse parser url
        |> Maybe.withDefault (NotFound <| Url.toString url)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , s "packages" </> packages
        ]


packages : Parser (Route -> a) a
packages =
    oneOf
        [ map Packages top
        , map Package packageKey
        , map ReadMe docsKey
        , map Module moduleKey
        ]


moduleKey : Parser (ModuleKey {} -> a) a
moduleKey =
    map
        (\key moduleName_ ->
            { authorName = key.authorName
            , packageName = key.packageName
            , version = key.version
            , moduleName = moduleName_
            }
        )
        (docsKey </> moduleName)


docsKey : Parser (DocsKey {} -> a) a
docsKey =
    map
        (\{ authorName, packageName } version_ ->
            { authorName = authorName, packageName = packageName, version = version_ }
        )
        (packageKey </> version)


packageKey : Parser (PackageKey {} -> a) a
packageKey =
    map
        (\{ authorName } packageName ->
            { authorName = authorName, packageName = packageName }
        )
        (authorKey </> string)


authorKey : Parser (AuthorKey {} -> a) a
authorKey =
    map (\authorName -> { authorName = authorName }) string


version : Parser (Version -> a) a
version =
    custom "VERSION" Elm.Version.fromString


moduleName : Parser (String -> a) a
moduleName =
    map (String.replace "-" ".") string
