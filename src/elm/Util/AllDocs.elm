module Util.AllDocs exposing (init, find, initKey, insert, failed, exists)

{-|

@docs init, find, initKey, insert, failed, exists

-}

import Dict exposing (Dict)
import Elm.Version
import Route exposing (..)
import Types exposing (..)


init : AllDocs
init =
    Dict.empty


find : DocsKey a -> AllDocs -> Maybe (Status Docs)
find docsKey allDocs =
    Dict.get (toComparable docsKey) allDocs


initKey : DocsKey a -> AllDocs -> AllDocs
initKey docsKey allDocs =
    Dict.update (toComparable docsKey) (Maybe.withDefault Loading >> Just) allDocs


insert : DocsKey a -> Docs -> AllDocs -> AllDocs
insert docsKey docs allDocs =
    Dict.insert (toComparable docsKey) (Success docs) allDocs


failed : DocsKey a -> AllDocs -> AllDocs
failed docsKey allDocs =
    Dict.insert (toComparable docsKey) Failure allDocs


exists : DocsKey a -> AllDocs -> Bool
exists docsKey allDocs =
    case find docsKey allDocs of
        Just (Success _) ->
            True

        _ ->
            False


toComparable : DocsKey a -> ( String, String, String )
toComparable { authorName, packageName, version } =
    ( authorName, packageName, Elm.Version.toString version )
