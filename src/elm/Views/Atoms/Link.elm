module Views.Atoms.Link exposing (book, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Views.Colors as Colors
import Views.Utils exposing (withFrame)


view : List (Attribute msg) -> { url : String, label : Element msg } -> Element msg
view attrs label =
    link
        ([ Font.color Colors.link
         , mouseOver [ Font.color Colors.accent ]
         ]
            ++ attrs
        )
        label


book : Book
book =
    bookWithFrontCover "Link"
        (view [] { url = "#", label = text "link" }
            |> withFrame
        )


main : Bibliopola.Program
main =
    fromBook book
