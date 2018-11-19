module DocHeader.Util exposing (indent, indentFour, line, parent)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant exposing (color)
import Element exposing (..)
import Element.Font as Font
import Elm.Type exposing (Type(..))
import TypeBody
import Url.Builder exposing (Root(..), custom)
import ViewUtil exposing (class, codeFont, withCss)


parent : List (Element msg) -> Element msg
parent =
    column [ codeFont, paddingXY 0 <| Constant.padding // 2 ]


line : Int -> List (Element msg) -> Element msg
line indentNum texts =
    row [ height <| px 20 ]
        (indent indentNum ++ texts)


indent : Int -> List (Element msg)
indent num =
    List.range 0 (num - 1)
        |> List.map (always indentFour)


indentFour : Element msg
indentFour =
    text "    "
