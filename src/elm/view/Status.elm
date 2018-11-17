module Status exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Types exposing (Status(..))
import ViewUtil exposing (withCss)


view : (a -> Element msg) -> Status a -> Element msg
view successView status =
    case status of
        Success value ->
            successView value

        Loading ->
            text "Loading..."

        Failure ->
            text "Failure"


book : Book
book =
    intoBook "Status" identity (view (always <| text "Success") >> withCss)
        |> addStory
            (Story "status"
                [ ( "Success", Success 1 )
                , ( "Failure", Failure )
                , ( "Loading", Loading )
                ]
            )
        |> buildBook
        |> withFrontCover (view (always <| text "Success") Loading |> withCss)


main : Bibliopola.Program
main =
    fromBook book
