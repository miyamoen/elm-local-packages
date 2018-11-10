module Decoder exposing (allPackages)

{-| -}

import Elm.Version
import Json.Decode as Decode exposing (..)
import List.Extra
import SelectList
import Types exposing (..)


allPackages : Decoder (List Package)
allPackages =
    Decode.map
        (List.Extra.gatherEqualsBy .name
            >> List.map
                (\( first, versions ) ->
                    List.sortWith
                        (\p1 p2 -> Elm.Version.compare p2.version p1.version)
                        (first :: versions)
                        |> SelectList.fromList
                        |> Maybe.withDefault (SelectList.singleton first)
                )
        )
    <|
        list package


packageHelp :
    String
    -> String
    -> String
    -> Elm.Version.Version
    -> List ( String, String )
    -> List ( String, String )
    -> String
    -> PackageInfo
packageHelp name summary license version deps testDeps =
    let
        ( authorName, packageName ) =
            splitName name
    in
    PackageInfo name authorName packageName summary license version deps testDeps


package : Decoder PackageInfo
package =
    Decode.map7 packageHelp
        (field "name" string)
        (field "summary" string)
        (field "license" string)
        (field "version" Elm.Version.decoder)
        (field "dependencies" depsDecoder)
        (field "test-dependencies" depsDecoder)
        (field "path" string)


depsDecoder : Decoder (List ( String, String ))
depsDecoder =
    keyValuePairs string


splitName : String -> ( String, String )
splitName name =
    case String.split "/" name of
        author :: packageName :: [] ->
            ( author, packageName )

        _ ->
            ( "", name )
