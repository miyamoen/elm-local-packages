module TypeAnnotation exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Docs exposing (Block(..))
import Elm.Type exposing (Type(..))
import Elm.Version
import Fake exposing (model)
import MarkdownBlock
import Status
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Type -> Element msg
view tipe =
    text <| toString tipe


toString : Type -> String
toString tipe =
    case tipe of
        Var var ->
            var

        Lambda arg return ->
            "handle Lambda _ _"

        Tuple _ ->
            "handle Tuple _"

        Type _ _ ->
            "handle Type _ _"

        Record _ _ ->
            "handle Record _ _"


book : Book
book =
    intoBook "TypeAnnotation" identity (view >> withCss)
        |> addStory
            (Story "type"
                [ ( "variable", Var "variable" )
                , ( "a->b", Lambda (Var "a") (Var "b") )
                , ( "(a,b)", Tuple [ Var "a", Var "b" ] )
                , ( "Maybe a", Type "Maybe" [ Var "a" ] )
                , ( "{ x : Float }", Record [ ( "x", Type "Float" [] ) ] Nothing )
                ]
            )
        |> buildBook
        |> withFrontCover (view (Var "variable") |> withCss)


main : Bibliopola.Program
main =
    fromBook book
