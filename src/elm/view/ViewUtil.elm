module ViewUtil exposing (rootAttributes, withCss)

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
    [ font, Font.color <| rgb255 41 60 75 ]


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
