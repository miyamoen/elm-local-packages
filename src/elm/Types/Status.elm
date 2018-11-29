module Types.Status exposing (toMaybe, map, liftMaybe)

{-|

@docs toMaybe, map, liftMaybe

-}

import Types exposing (Status(..))


toMaybe : Status a -> Maybe a
toMaybe status =
    case status of
        Success a ->
            Just a

        _ ->
            Nothing


map : (a -> b) -> Status a -> Status b
map tagger status =
    case status of
        Success a ->
            Success <| tagger a

        Failure ->
            Failure

        Loading ->
            Loading


liftMaybe : Status (Maybe a) -> Maybe (Status a)
liftMaybe status =
    case status of
        Success (Just a) ->
            Just <| Success a

        Success Nothing ->
            Nothing

        Failure ->
            Just Failure

        Loading ->
            Just Loading
