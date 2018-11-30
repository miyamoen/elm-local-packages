module Views.Atoms.Status exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Types exposing (Status(..))
import Views.Utils exposing (withFrame)


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
    intoBook "Status" identity (view (always <| text "Success") >> withFrame)
        |> addStory
            (Story "status"
                [ ( "Success", Success () )
                , ( "Failure", Failure )
                , ( "Loading", Loading )
                ]
            )
        |> buildBook
        |> withFrontCover (view (always <| text "Success") Loading |> withFrame)


main : Bibliopola.Program
main =
    fromBook book
