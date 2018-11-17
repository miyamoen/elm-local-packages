module Util.Packages exposing (find, latest, match, hasVersions)

{-|

@docs find, latest, match, hasVersions

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
