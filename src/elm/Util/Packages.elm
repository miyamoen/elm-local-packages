module Util.Packages exposing (find, latest, match, hasVersions, sort)

{-|

@docs find, latest, match, hasVersions, sort

-}

import Elm.Version exposing (Version)
import List.Extra
import Route exposing (..)
import SelectList
import Types exposing (..)


find : PackageKey a -> List Package -> Maybe Package
find key packages =
    List.Extra.find (match key) packages


latest : Package -> PackageInfo
latest package =
    SelectList.selected package


match : PackageKey a -> Package -> Bool
match key package =
    let
        target =
            latest package
    in
    target.authorName == key.authorName && target.packageName == key.packageName


hasVersions : Package -> Bool
hasVersions package =
    not <| SelectList.isSingle package


sort : List Package -> List Package
sort packages =
    List.sortBy
        (\package ->
            let
                { authorName, packageName } =
                    SelectList.selected package

                weight =
                    if authorName == "elm" || authorName == "elm-explorations" then
                        0

                    else
                        1000
            in
            ( weight, authorName, packageName )
        )
        packages
