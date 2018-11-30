module Views.Utils exposing
    ( rootAttributes, font, codeFont
    , class, id, title
    , withFrame
    )

{-|

@docs rootAttributes, font, codeFont
@docs class, id, title
@docs withFrame

-}

import Element exposing (..)
import Element.Font as Font exposing (typeface)
import Html
import Html.Attributes exposing (href, rel, src)
import Views.Colors exposing (black)
import Views.Constants exposing (fontSize)


class : String -> Attribute msg
class str =
    htmlAttribute <| Html.Attributes.class str


id : String -> Attribute msg
id str =
    htmlAttribute <| Html.Attributes.id str


title : String -> Attribute msg
title str =
    htmlAttribute <| Html.Attributes.title str


withFrame : Element msg -> Element msg
withFrame element =
    column (width fill :: height fill :: rootAttributes) [ element ]


rootAttributes : List (Attribute msg)
rootAttributes =
    [ font
    , Font.color black
    , Font.size fontSize.normal
    ]


font : Attribute msg
font =
    Font.family
        [ typeface "Source Sans Pro"
        , typeface "Trebuchet MS"
        , typeface "Lucida Grande"
        , typeface "Bitstream Vera Sans"
        , typeface "Helvetica Neue"
        , Font.sansSerif
        ]


codeFont : Attribute msg
codeFont =
    Font.family
        [ typeface "Source Code Pro"
        , typeface "Consolas"
        , typeface "Liberation Mono"
        , typeface "Menlo"
        , typeface "Courier"
        , Font.monospace
        ]
