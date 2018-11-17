module ViewUtil exposing (rootAttributes, withCss)

import Constant
import Element exposing (..)
import Element.Font as Font exposing (typeface)
import Html
import Html.Attributes exposing (href, rel, src)


withCss : Element msg -> Element msg
withCss element =
    column (width fill :: height fill :: rootAttributes)
        [ element
        , html <| Html.node "link" [ rel "stylesheet", href "/public/style.css" ] []
        ]


rootAttributes : List (Attribute msg)
rootAttributes =
    [ font
    , Font.color Constant.color.black
    , Font.size Constant.fontSize.normal
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
