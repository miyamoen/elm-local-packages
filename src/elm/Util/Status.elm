module Util.Status exposing (toMaybe)

{-|

@docs toMaybe

-}

import Types exposing (Status(..))


toMaybe : Status a -> Maybe a
toMaybe status =
    case status of
        Success a ->
            Just a

        _ ->
            Nothing
