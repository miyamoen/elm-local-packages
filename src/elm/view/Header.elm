module Header exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Constant
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Logo
import ViewUtil exposing (withCss)


view : Element msg
view =
    row
        [ width fill
        , height <| px 50
        , Background.color <| rgb255 238 238 238
        , Border.widthEach { bottom = 2, left = 0, right = 0, top = 0 }
        , Border.color <| rgb255 96 181 204
        ]
        [ row
            [ paddingXY Constant.padding 0
            , spacing Constant.padding
            , centerX
            , width (maximum Constant.breakPoints.large fill)
            ]
            [ Logo.view
            ]
        ]


book : Book
book =
    bookWithFrontCover "Header" (withCss view)


main : Bibliopola.Program
main =
    fromBook book
