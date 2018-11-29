module Types.AllDocs exposing
    ( init, initKey, insert, failed, exists
    , find, findModule
    )

{-|

@docs init, initKey, insert, failed, exists
@docs find, findModule

-}

import Dict exposing (Dict)
import Elm.Docs exposing (Module)
import Elm.Version
import List.Extra
import Types exposing (..)
import Types.Route exposing (..)
import Types.Status as Status


init : AllDocs
init =
    Dict.empty


find : DocsKey a -> AllDocs -> Maybe (Status Docs)
find docsKey allDocs =
    Dict.get (toComparable docsKey) allDocs


findModule : ModuleKey a -> AllDocs -> Maybe (Status ( Docs, Module ))
findModule key allDocs =
    find key allDocs
        |> Maybe.andThen
            (Status.map
                (\docs ->
                    docs.moduleDocs
                        |> List.Extra.find (.name >> (==) key.moduleName)
                        |> Maybe.map (Tuple.pair docs)
                )
                >> Status.liftMaybe
            )


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
