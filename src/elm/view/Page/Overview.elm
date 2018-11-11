module Page.Overview exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake
import SelectList
import Types exposing (..)
import Url.Builder exposing (absolute)


view : Package -> Model -> Element msg
view package model =
    column []
        [ el
            [ Font.size <| Constant.fontSize * 2
            , paddingXY 0 Constant.padding
            ]
          <|
            text "Local Cached Versions"
        , row
            [ height <| px <| round <| Constant.fontSize * 1.5
            , spacing 16
            , Font.size Constant.fontSize
            , Font.color <| rgb255 17 132 206
            ]
          <|
            SelectList.selectedMap
                (\_ selected ->
                    let
                        info =
                            SelectList.selected selected
                    in
                    link
                        [ mouseOver
                            [ Font.color <| rgb255 234 21 122
                            , Border.shadow
                                { size = 0
                                , offset = ( 0, 1 )
                                , blur = 0
                                , color = rgb255 234 21 122
                                }
                            ]
                        ]
                        { url =
                            absolute
                                [ "packages"
                                , info.authorName
                                , info.packageName
                                , Elm.Version.toString info.version
                                ]
                                []
                        , label =
                            text <| Elm.Version.toString <| info.version
                        }
                )
                package
        ]


book : Book
book =
    bookWithFrontCover "Overview" (view Fake.package Fake.model)


main : Bibliopola.Program
main =
    fromBook book
