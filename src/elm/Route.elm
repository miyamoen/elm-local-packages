module Route exposing
    ( Route(..), PackageRoute(..)
    , AuthorName, PackageName, ModuleName
    , route, parse
    )

{-|

@docs Route, PackageRoute
@docs AuthorName, PackageName, ModuleName
@docs route, parse

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


parse : Url -> Route
parse url =
    Url.Parser.parse route url
        |> Maybe.withDefault (NotFound <| Url.toString url)


route : Parser (Route -> a) a
route =
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
        , map ReadMe version
        , map Module (version </> moduleName)
        ]


version : Parser (Version -> a) a
version =
    custom "VERSION" Elm.Version.fromString


moduleName : Parser (ModuleName -> a) a
moduleName =
    map (String.replace "-" ".") string
