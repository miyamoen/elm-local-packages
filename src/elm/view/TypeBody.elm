module TypeBody exposing (view, toString, book)

{-|

@docs view, toString, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Type exposing (Type(..))
import ViewUtil exposing (codeFont, withCss)


view : Type -> Element msg
view tipe =
    el [ codeFont ] <| text <| toString tipe


toString : Type -> String
toString tipe =
    case tipe of
        Var var ->
            var

        Lambda arg return ->
            String.join " -> " [ toString arg, toString return ]

        Tuple [] ->
            "()"

        Tuple tipes ->
            List.map toString tipes
                |> String.join ", "
                |> (\inner -> String.join inner [ "( ", " )" ])

        Type ctr tipes ->
            String.join " " <| ctr :: List.map toString tipes

        Record [] Nothing ->
            "{}"

        Record fields Nothing ->
            List.map (\( name, tipe_ ) -> String.join " : " [ name, toString tipe_ ]) fields
                |> String.join ", "
                |> (\inner -> String.join inner [ "{ ", " }" ])

        Record [] (Just extension) ->
            String.join " " [ "{", extension, "|", "}" ]

        Record fields (Just extension) ->
            String.join " "
                [ "{"
                , extension
                , "|"
                , List.map (\( name, tipe_ ) -> String.join " : " [ name, toString tipe_ ]) fields
                    |> String.join ", "
                , "}"
                ]


book : Book
book =
    intoBook "TypeBody" identity (view >> withCss)
        |> addStory
            (Story "type"
                [ ( "variable", Var "variable" )
                , ( "a->b", Lambda (Var "a") (Var "b") )
                , ( "a->b->c", Lambda (Var "a") (Lambda (Var "b") (Var "c")) )
                , ( "(a,b)->(b,c)", Lambda (Tuple [ Var "a", Var "b" ]) (Tuple [ Var "b", Var "c" ]) )
                , ( "()", Tuple [] )
                , ( "(a,b)", Tuple [ Var "a", Var "b" ] )
                , ( "(a,b,c)", Tuple [ Var "a", Var "b", Var "c" ] )
                , ( "(a->b,b->c)", Tuple [ Lambda (Var "a") (Var "b"), Lambda (Var "b") (Var "c") ] )
                , ( "Maybe_a", Type "Maybe" [ Var "a" ] )
                , ( "Float", Type "Float" [] )
                , ( "{}", Record [] Nothing )
                , ( "{x:Float}", Record [ ( "x", Type "Float" [] ) ] Nothing )
                , ( "{x:Float,maybe:Maybe_a}"
                  , Record
                        [ ( "x", Type "Float" [] )
                        , ( "maybe", Type "Maybe" [ Var "a" ] )
                        ]
                        Nothing
                  )
                , ( "{ext|x:Float,maybe:Maybe_a}"
                  , Record
                        [ ( "x", Type "Float" [] )
                        , ( "maybe", Type "Maybe" [ Var "a" ] )
                        ]
                        (Just "ext")
                  )
                ]
            )
        |> buildBook
        |> withFrontCover (view (Var "variable") |> withCss)


main : Bibliopola.Program
main =
    fromBook book
