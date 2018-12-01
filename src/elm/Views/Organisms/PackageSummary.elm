module Views.Organisms.PackageSummary exposing (listView, shelf, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake
import Types exposing (Package)
import Types.Packages as Packages
import Types.Route as Route
import Views.Atoms.Link as Link
import Views.Colors as Colors
import Views.Constants as Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : Package -> Element msg
view package =
    let
        ({ authorName, packageName, summary, version } as info) =
            Packages.latest package
    in
    column
        [ width fill
        , paddingEach { top = 0, right = 0, bottom = fontSize.middle, left = 0 }
        , spacing fontSize.small
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Border.color Colors.lightGrey
        ]
        [ wrappedRow [ width fill ]
            [ Link.view
                [ alignLeft, Font.size fontSize.middle ]
                { url = Route.readMeUrl info
                , label = text <| authorName ++ "/" ++ packageName
                }
            , Link.view
                [ alignRight
                , alignBottom
                , Font.color Colors.grey
                ]
                { url = Route.packageUrl info
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
        , paragraph [] [ text summary ]
        ]


listView : List Package -> Element msg
listView packages =
    column [ width fill, spacing Constants.padding ] <| List.map view packages


shelf : Shelf
shelf =
    shelfWith (bookWithFrontCover "PackageSummary" (view Fake.package |> withFrame))
        |> addBook
            (bookWithFrontCover "ListView"
                (listView Fake.packages |> withFrame)
            )


main : Bibliopola.Program
main =
    fromShelf shelf
