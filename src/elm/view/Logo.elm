module Logo exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Font as Font
import ElmLogo
import ViewUtil exposing (withCss)


view : Element msg
view =
    row [ spacing 8, height <| px 30 ]
        [ el [] <| ElmLogo.element 30
        , column [ spacing 0 ]
            [ el [ Font.size 24, height <| px 20 ] <| text "Local"
            , el [ Font.size 12, height <| px 10 ] <| text "packages"
            ]
        ]


book : Book
book =
    bookWithFrontCover "Logo" (withCss view)


main : Bibliopola.Program
main =
    fromBook book
