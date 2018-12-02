module Decoder exposing (allPackages)

{-| -}

import Elm.Version
import Json.Decode as Decode exposing (..)
import List.Extra
import SelectList
import Types exposing (..)


allPackages : Decoder ( List Decode.Error, List Package )
allPackages =
    result package
        |> list
        |> Decode.map resultsToTuple
        |> Decode.map (Tuple.mapSecond gatherPackageInfos)


packageHelp :
    String
    -> String
    -> String
    -> Elm.Version.Version
    -> Exposed
    -> List ( String, String )
    -> List ( String, String )
    -> String
    -> PackageInfo
packageHelp name summary license version exposed deps testDeps path =
    let
        ( authorName, packageName ) =
            splitName name
    in
    PackageInfo name authorName packageName summary license version exposed deps testDeps path


package : Decoder PackageInfo
package =
    Decode.map8 packageHelp
        (field "name" string)
        (field "summary" string)
        (field "license" string)
        (field "version" Elm.Version.decoder)
        (field "exposed-modules" exposedDecoder)
        (field "dependencies" depsDecoder)
        (field "test-dependencies" depsDecoder)
        (field "path" string)


depsDecoder : Decoder (List ( String, String ))
depsDecoder =
    keyValuePairs string



-- helper


result : Decoder a -> Decoder (Result Decode.Error a)
result decoder =
    Decode.map (Decode.decodeValue decoder) Decode.value


splitName : String -> ( String, String )
splitName name =
    case String.split "/" name of
        author :: packageName :: [] ->
            ( author, packageName )

        _ ->
            ( "", name )


gatherPackageInfos : List PackageInfo -> List Package
gatherPackageInfos packageInfos =
    List.Extra.gatherEqualsBy .name packageInfos
        |> List.map
            (\( first, versions ) ->
                List.sortWith
                    (\p1 p2 -> Elm.Version.compare p2.version p1.version)
                    (first :: versions)
                    |> SelectList.fromList
                    |> Maybe.withDefault (SelectList.singleton first)
            )


resultsToTuple : List (Result e a) -> ( List e, List a )
resultsToTuple results =
    List.foldr
        (\res ( errors, values ) ->
            case res of
                Ok value ->
                    ( errors, value :: values )

                Err err ->
                    ( err :: errors, values )
        )
        ( [], [] )
        results



-- Exposed Decoder


exposedDecoder : Decoder Exposed
exposedDecoder =
    oneOf
        [ map ExposedList (list string)
        , map ExposedKeyValues (keyValuePairs (list string))
        ]
