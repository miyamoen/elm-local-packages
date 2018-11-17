module Util.Route exposing
    ( authorKey, packageKey, docsKey, moduleKey
    , home, packages, package, readMe, moduleRoute
    , homeAsString, packagesAsString, packageAsString, readMeAsString, moduleAsString
    )

{-|

@docs authorKey, packageKey, docsKey, moduleKey
@docs home, packages, package, readMe, moduleRoute
@docs homeAsString, packagesAsString, packageAsString, readMeAsString, moduleAsString

-}

import Route exposing (..)
import Types exposing (..)


authorKey : Route -> Maybe (AuthorKey {})
authorKey route =
    case route of
        Package { authorName } ->
            Just { authorName = authorName }

        ReadMe { authorName } ->
            Just { authorName = authorName }

        Module { authorName } ->
            Just { authorName = authorName }

        _ ->
            Nothing


packageKey : Route -> Maybe (PackageKey {})
packageKey route =
    case route of
        Package { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        ReadMe { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        Module { authorName, packageName } ->
            Just { authorName = authorName, packageName = packageName }

        _ ->
            Nothing


docsKey : Route -> Maybe (DocsKey {})
docsKey route =
    case route of
        ReadMe { authorName, packageName, version } ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        Module { authorName, packageName, version } ->
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
        Module { authorName, packageName, version, moduleName } ->
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
    Home


homeAsString : String
homeAsString =
    Route.toString home


packages : Route
packages =
    Packages


packagesAsString : String
packagesAsString =
    Route.toString packages


package : PackageKey a -> Route
package { authorName, packageName } =
    Package { authorName = authorName, packageName = packageName }


packageAsString : PackageKey a -> String
packageAsString key =
    package key |> Route.toString


readMe : DocsKey a -> Route
readMe { authorName, packageName, version } =
    ReadMe { authorName = authorName, packageName = packageName, version = version }


readMeAsString : DocsKey a -> String
readMeAsString key =
    readMe key |> Route.toString


moduleRoute : ModuleKey a -> Route
moduleRoute { authorName, packageName, version, moduleName } =
    Module
        { authorName = authorName
        , packageName = packageName
        , version = version
        , moduleName = moduleName
        }


moduleAsString : ModuleKey a -> String
moduleAsString key =
    moduleRoute key |> Route.toString
