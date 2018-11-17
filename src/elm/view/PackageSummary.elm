module PackageSummary exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Constant
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
        , Border.color Constant.color.lightGrey
        ]
        [ wrappedRow [ width fill, height <| px 30 ]
            [ link
                [ alignLeft
                , Font.size Constant.fontSize.middle
                , Font.color Constant.color.link
                , mouseOver [ Font.color Constant.color.accent ]
                ]
                { url = Route.readMeAsString info
                , label = row [] [ text authorName, text "/", text packageName ]
                }
            , link
                [ alignRight
                , alignBottom
                , Font.color Constant.color.grey
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
        , paragraph [ height <| px Constant.fontSize.middle ] [ text summary ]
        ]


book : Book
book =
    bookWithFrontCover "PackageSummary" (view Fake.package |> withCss)


main : Bibliopola.Program
main =
    fromBook book
