module Types.Route exposing
    ( parse, parser
    , authorKey, packageKey, docsKey, moduleKey
    , home, packages, package, readMe, moduleRoute
    , toString
    , homeUrl, packagesUrl, packageUrl, readMeUrl, moduleUrl
    , moduleTagUrl
    )

{-|

@docs parse, parser
@docs authorKey, packageKey, docsKey, moduleKey
@docs home, packages, package, readMe, moduleRoute
@docs toString
@docs homeUrl, packagesUrl, packageUrl, readMeUrl, moduleUrl
@docs moduleTagUrl

-}

import Elm.Version exposing (Version)
import Types exposing (..)
import Url exposing (Url)
import Url.Builder exposing (Root(..), absolute)
import Url.Parser exposing (..)


toString : Route -> String
toString route =
    case route of
        HomePage ->
            absolute [] []

        NotFoundPage string ->
            absolute [ "notfound" ] []

        PackagesPage ->
            absolute [ "packages" ] []

        PackagePage key ->
            absolute [ "packages", key.authorName, key.packageName ] []

        ReadMePage key ->
            absolute
                [ "packages"
                , key.authorName
                , key.packageName
                , Elm.Version.toString key.version
                ]
                []

        ModulePage key ->
            absolute
                [ "packages"
                , key.authorName
                , key.packageName
                , Elm.Version.toString key.version
                , String.replace "." "-" key.moduleName
                ]
                []


authorKey : Route -> Maybe (AuthorKey {})
authorKey route =
    case route of
        PackagePage { authorName } ->
            Just { authorName = authorName }

        ReadMePage { authorName } ->
            Just { authorName = authorName }

        ModulePage { authorName } ->
            Just { authorName = authorName }

        _ ->
            Nothing


packageKey : Route -> Maybe (PackageKey {})
packageKey route =
    case route of
        PackagePage { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        ReadMePage { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        ModulePage { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        _ ->
            Nothing


docsKey : Route -> Maybe (DocsKey {})
docsKey route =
    case route of
        ReadMePage { authorName, packageName, version } ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        ModulePage { authorName, packageName, version } ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        _ ->
            Nothing


moduleKey : Route -> Maybe (ModuleKey {})
moduleKey route =
    case route of
        ModulePage { authorName, packageName, version, moduleName } ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                , moduleName = moduleName
                }

        _ ->
            Nothing


home : Route
home =
    HomePage


homeUrl : String
homeUrl =
    toString home


packages : Route
packages =
    PackagesPage


packagesUrl : String
packagesUrl =
    toString packages


package : PackageKey a -> Route
package { authorName, packageName } =
    PackagePage { authorName = authorName, packageName = packageName }


packageUrl : PackageKey a -> String
packageUrl key =
    package key |> toString


readMe : DocsKey a -> Route
readMe { authorName, packageName, version } =
    ReadMePage { authorName = authorName, packageName = packageName, version = version }


readMeUrl : DocsKey a -> String
readMeUrl key =
    readMe key |> toString


moduleRoute : ModuleKey a -> Route
moduleRoute { authorName, packageName, version, moduleName } =
    ModulePage
        { authorName = authorName
        , packageName = packageName
        , version = version
        , moduleName = moduleName
        }


moduleUrl : ModuleKey a -> String
moduleUrl key =
    moduleRoute key |> toString


moduleTagUrl : ModuleKey a -> String -> String
moduleTagUrl key tag =
    Url.Builder.custom
        Absolute
        [ "packages"
        , key.authorName
        , key.packageName
        , Elm.Version.toString key.version
        , String.replace "." "-" key.moduleName
        ]
        []
        (Just tag)



-- Parser


parse : Url -> Route
parse url =
    Url.Parser.parse parser url
        |> Maybe.withDefault (NotFoundPage <| Url.toString url)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map HomePage top
        , s "packages" </> packagesParser
        ]


packagesParser : Parser (Route -> a) a
packagesParser =
    oneOf
        [ map PackagesPage top
        , map PackagePage packageKeyParser
        , map ReadMePage docsKeyParser
        , map ModulePage moduleKeyParser
        ]


moduleKeyParser : Parser (ModuleKey {} -> a) a
moduleKeyParser =
    map
        (\key moduleName_ ->
            { authorName = key.authorName
            , packageName = key.packageName
            , version = key.version
            , moduleName = moduleName_
            }
        )
        (docsKeyParser </> moduleNameParser)


docsKeyParser : Parser (DocsKey {} -> a) a
docsKeyParser =
    map
        (\{ authorName, packageName } version_ ->
            { authorName = authorName, packageName = packageName, version = version_ }
        )
        (packageKeyParser </> versionParser)


packageKeyParser : Parser (PackageKey {} -> a) a
packageKeyParser =
    map
        (\{ authorName } packageName ->
            { authorName = authorName, packageName = packageName }
        )
        (authorKeyParser </> string)


authorKeyParser : Parser (AuthorKey {} -> a) a
authorKeyParser =
    map (\authorName -> { authorName = authorName }) string


versionParser : Parser (Version -> a) a
versionParser =
    custom "VERSION" Elm.Version.fromString


moduleNameParser : Parser (String -> a) a
moduleNameParser =
    map (String.replace "-" ".") string
