module PackageSummary exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake
import Types exposing (Package)
import Util.Packages as Packages
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Package -> Element msg
view package =
    let
        ({ authorName, packageName, summary, version } as info) =
            Packages.latest package
    in
    column
        [ paddingEach { top = 20, right = 0, bottom = 20 + 8, left = 0 }
        , spacing 8
        , width fill
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Border.color <| rgb255 238 238 238
        ]
        [ wrappedRow [ width fill, height <| px 30 ]
            [ link
                [ alignLeft
                , Font.size 24
                , Font.color <| rgb255 17 132 206
                , mouseOver [ Font.color <| rgb255 234 21 122 ]
                ]
                { url = Route.readMeAsString info
                , label = row [] [ text authorName, text "/", text packageName ]
                }
            , link
                [ alignRight
                , alignBottom
                , Font.size 16
                , Font.color <| rgb255 187 187 187
                , pointer
                ]
                { url = Route.packageAsString info
                , label =
                    text <|
                        String.join " "
                            [ if Packages.hasVersions package then
                                "..."

                              else
                                ""
                            , Elm.Version.toString version
                            , "-"
                            , "Overview"
                            ]
                }
            ]
        , paragraph [ Font.size 16, height <| px 24 ] [ text summary ]
        ]


book : Book
book =
    bookWithFrontCover "PackageSummary" (view Fake.package |> withCss)


main : Bibliopola.Program
main =
    fromBook book
