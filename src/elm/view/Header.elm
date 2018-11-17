module Header exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Breadcrumbs
import Constant
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Fake
import Logo
import Types exposing (..)
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view { route } =
    row
        [ width fill
        , height <| px 50
        , Background.color Constant.color.lightGrey
        , Border.widthEach { bottom = 2, left = 0, right = 0, top = 0 }
        , Border.color <| rgb255 96 181 204
        ]
        [ row
            [ paddingXY Constant.padding 0
            , spacing Constant.padding
            , centerX
            , width (maximum Constant.breakPoints.large fill)
            ]
            [ link [] { label = Logo.view, url = Route.homeAsString }
            , Breadcrumbs.view route
            ]
        ]


book : Book
book =
    bookWithFrontCover "Header" (withCss <| view Fake.model)


main : Bibliopola.Program
main =
    fromBook book
