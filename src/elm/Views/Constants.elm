module Views.Constants exposing
    ( breakPoints
    , padding, fontSize
    )

{-|

@docs breakPoints
@docs padding, fontSize

-}

import Element exposing (Color, rgb255)


breakPoints : { large : number }
breakPoints =
    { large = 960 }


padding : number
padding =
    20


fontSize : { small : number, normal : number, middle : number, large : number, huge : number }
fontSize =
    { small = 12, normal = 16, middle = 24, large = 32, huge = 48 }
