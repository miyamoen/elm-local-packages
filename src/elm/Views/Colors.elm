module Views.Colors exposing
    ( link, accent, secondary, cover
    , black, grey, lightGrey
    )

{-|

@docs link, accent, secondary, cover
@docs black, grey, lightGrey

-}

import Element exposing (..)


link : Color
link =
    rgb255 17 132 206


accent : Color
accent =
    rgb255 234 21 122


secondary : Color
secondary =
    rgb255 96 181 204


cover : Color
cover =
    rgb255 252 255 236


black : Color
black =
    rgb255 41 60 75


grey : Color
grey =
    rgb255 187 187 187


lightGrey : Color
lightGrey =
    rgb255 238 238 238
