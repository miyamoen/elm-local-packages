module Route exposing
    ( Route(..), PackageRoute(..)
    , AuthorName, PackageName, ModuleName
    , routeParser, parse
    , extractVersion
    )

{-|

@docs Route, PackageRoute
@docs AuthorName, PackageName, ModuleName
@docs routeParser, parse
@docs extractVersion

-}

import Elm.Version exposing (Version)
import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = Home
    | NotFound String
    | Packages
    | Package AuthorName PackageName PackageRoute


type PackageRoute
    = Overview
    | ReadMe Version
    | Module Version ModuleName


type alias AuthorName =
    String


type alias PackageName =
    String


type alias ModuleName =
    String


extractVersion :
    Route
    -> Maybe { authorName : String, packageName : String, version : Version }
extractVersion route =
    case route of
        Package authorName packageName (ReadMe version) ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        Package authorName packageName (Module version _) ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        _ ->
            Nothing


parse : Url -> Route
parse url =
    Url.Parser.parse routeParser url
        |> Maybe.withDefault (NotFound <| Url.toString url)


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , s "packages" </> packages
        ]


packages : Parser (Route -> a) a
packages =
    oneOf
        [ map Packages top
        , map Package (string </> string </> package)
        ]


package : Parser (PackageRoute -> a) a
package =
    oneOf
        [ map Overview top
        , map ReadMe versionParser
        , map Module (versionParser </> moduleName)
        ]


versionParser : Parser (Version -> a) a
versionParser =
    custom "VERSION" Elm.Version.fromString


moduleName : Parser (ModuleName -> a) a
moduleName =
    map (String.replace "-" ".") string
