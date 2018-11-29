module Util.Packages exposing (find, latest, match, hasVersions, sort, filter)

{-|

@docs find, latest, match, hasVersions, sort, filter

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


filter : String -> List Package -> List Package
filter query packages =
    let
        words =
            String.words (String.toLower query)
    in
    List.filter (filterHelp words) packages


filterHelp : List String -> Package -> Bool
filterHelp words package =
    let
        latest_ =
            latest package

        name =
            String.toLower latest_.name

        summary =
            String.toLower latest_.summary

        matches word =
            String.contains word name
                || String.contains word summary
    in
    List.all matches words
