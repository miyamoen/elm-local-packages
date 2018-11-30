module Views.Atoms.Logo exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Font as Font
import ElmLogo
import Views.Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : Element msg
view =
    row [ spacing fontSize.tiny, height <| px 30 ]
        [ el [] <| ElmLogo.element 30
        , column []
            [ el [ Font.size fontSize.middle, height <| px 20 ] <|
                text "Local"
            , el [ Font.size fontSize.small, height <| px 10 ] <|
                text "packages"
            ]
        ]


book : Book
book =
    bookWithFrontCover "Logo" (withFrame view)


main : Bibliopola.Program
main =
    fromBook book
