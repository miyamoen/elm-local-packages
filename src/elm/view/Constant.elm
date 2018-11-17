module Constant exposing
    ( breakPoints
    , padding, fontSize
    , color
    )

{-|

@docs breakPoints
@docs padding, fontSize

@docs color

-}

import Element exposing (Color, rgb255)


breakPoints : { large : number }
breakPoints =
    { large = 960 }


padding : number
padding =
    20


fontSize : { small : number, normal : number, middle : number, large : number }
fontSize =
    { small = 12, normal = 16, middle = 24, large = 32 }


color :
    { link : Color
    , black : Color
    , grey : Color
    , lightGrey : Color
    , accent : Color
    }
color =
    { link = rgb255 17 132 206
    , black = rgb255 41 60 75
    , grey = rgb255 187 187 187
    , lightGrey = rgb255 238 238 238
    , accent = rgb255 234 21 122
    }
