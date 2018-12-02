module Views.Organisms.ModuleLinks exposing (book, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Elm.Version as Version
import Fake
import Types exposing (..)
import Types.Route as Route
import Views.Atoms.Link as Link
import Views.Constants as Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : DocsKey a -> Exposed -> Element msg
view key exposed =
    case exposed of
        ExposedList names ->
            row [ spacing <| Constants.padding * 2 ]
                [ Link.view [ alignTop ] <| readMeLink key
                , column [ spacing <| fontSize.tiny // 2 ] <|
                    List.map (moduleLink key >> Link.view []) names
                ]

        ExposedKeyValues kvs ->
            row [ width fill, spacing <| Constants.padding * 2 ]
                [ column [ alignTop, spacing <| Constants.padding // 2 ]
                    [ el [ height <| px fontSize.middle ] none
                    , Link.view [ alignTop ] <| readMeLink key
                    ]
                , wrappedRow [ width fill, spacing Constants.padding ] <|
                    List.map
                        (\( groupName, names ) ->
                            column [ alignTop, spacing <| Constants.padding // 2 ]
                                [ el [ Font.size fontSize.middle ] <| text groupName
                                , column [ spacing <| fontSize.tiny // 2 ] <|
                                    List.map (moduleLink key >> Link.view []) names
                                ]
                        )
                        kvs
                ]


moduleLink : DocsKey a -> String -> { url : String, label : Element msg }
moduleLink key moduleName =
    { label = text moduleName
    , url =
        Route.moduleUrl
            { authorName = key.authorName
            , packageName = key.packageName
            , version = key.version
            , moduleName = moduleName
            }
    }


readMeLink : DocsKey a -> { url : String, label : Element msg }
readMeLink key =
    { label = text "README", url = Route.readMeUrl key }


book : Book
book =
    intoBook "ModuleLinks" identity (view fakeKey >> withFrame)
        |> addStory
            (Story "exposed"
                [ ( "KeyValues", Fake.exposedKeyValues )
                , ( "List", Fake.exposedList )
                ]
            )
        |> buildBook
        |> withFrontCover (view fakeKey Fake.exposedKeyValues |> withFrame)


fakeKey : DocsKey {}
fakeKey =
    { authorName = "miyamoen"
    , packageName = "select-list"
    , version = Version.fromString "4.0.0" |> Maybe.withDefault Version.one
    }


main : Bibliopola.Program
main =
    fromBook book
