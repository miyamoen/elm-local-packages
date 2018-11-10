module PackageSummary exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake
import SelectList
import Types exposing (Package)
import Url.Builder exposing (absolute)


splitPackageName : String -> ( String, String )
splitPackageName name =
    case String.split "/" name of
        author :: packageName :: [] ->
            ( author, packageName )

        _ ->
            ( "", name )


view : Package -> Element msg
view package =
    let
        { name, summary, version } =
            SelectList.selected package

        ( author, packageName ) =
            splitPackageName name
    in
    column
        [ paddingEach { top = 20, right = 0, bottom = 20 + 8, left = 0 }
        , spacing 8
        , width fill

        -- , height <| px 50
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Border.color <| rgb255 238 238 238
        ]
        [ row [ width fill, height <| px 30 ]
            [ link
                [ alignLeft
                , Font.size 24
                , Font.color <| rgb255 17 132 206
                , mouseOver
                    [ Font.color <| rgb255 234 21 122
                    , Border.shadow { size = 1, offset = ( -1, 1 ), blur = 0, color = rgb255 234 21 122 }
                    ]
                ]
                { url = absolute [ "packages", author, packageName, Elm.Version.toString version ] []
                , label = row [] [ text author, text "/", text packageName ]
                }
            , row
                [ alignRight
                , alignBottom
                , Font.size 16
                , Font.color <| rgb255 187 187 187
                ]
                [ if SelectList.afterLength package > 1 then
                    text "… "

                  else
                    none
                , el [ pointer ] <| text <| Elm.Version.toString version
                , text " — "
                , el [ pointer ] <| text "Overview"
                ]
            ]
        , el [ Font.size 16, height <| px 24 ] <| text summary
        ]


book : Book
book =
    bookWithFrontCover "PackageSummary" (view Fake.package)


main : Bibliopola.Program
main =
    fromBook book
