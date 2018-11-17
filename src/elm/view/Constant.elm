module Constant exposing
    ( breakPoints
    , padding, fontSize
    , linkColor
    )

{-|

@docs breakPoints
@docs padding, fontSize


## Color

@docs linkColor

-}

import Element exposing (Color, rgb255)


breakPoints : { large : number }
breakPoints =
    { large = 960 }


padding : number
padding =
    20


fontSize : number
fontSize =
    16


linkColor : Color
linkColor =
    rgb255 17 132 206
