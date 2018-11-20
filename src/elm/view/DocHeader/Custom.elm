module DocHeader.Custom exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant exposing (color)
import DocHeader.Util exposing (..)
import Element exposing (..)
import Element.Font as Font
import Elm.Type exposing (Type(..))
import TypeBody
import Url.Builder exposing (Root(..), custom)
import ViewUtil exposing (class, codeFont, withCss)


type alias Custom a =
    { a
        | name : String
        , args : List String
        , tags : List ( String, List Type )
    }


view : Custom a -> Element msg
view { name, args, tags } =
    parent <|
        customFirst name args
            :: List.indexedMap
                (\index tag ->
                    line 1 [ text <| tagLine index tag ]
                )
                tags


tagLine : Int -> ( String, List Type ) -> String
tagLine index ( ctr, tipes ) =
    String.join " "
        ((if index == 0 then
            "="

          else
            "|"
         )
            :: ctr
            :: List.map TypeBody.toString tipes
        )


customFirst : String -> List String -> Element msg
customFirst name args =
    line 0
        [ el [ class "hljs-keyword" ] <| text "type "
        , link
            [ Font.bold
            , Font.color color.link
            , mouseOver [ Font.color color.accent ]
            ]
            { label = text name
            , url = custom Relative [] [] (Just name)
            }
        , text <| " " ++ String.join " " args
        ]


book : Book
book =
    intoBook "Custom" identity (view >> withCss)
        |> addStory
            (Story "header"
                [ ( "Maybe", maybe )
                , ( "hiddenMaybe", hiddenMaybe )
                ]
            )
        |> buildBook
        |> withFrontCover (view maybe |> withCss)


maybe : Custom {}
maybe =
    { name = "Maybe"
    , args = [ "a" ]
    , tags = [ ( "Just", [ Var "a" ] ), ( "Nothing", [] ) ]
    }


hiddenMaybe : Custom {}
hiddenMaybe =
    { name = "Maybe"
    , args = [ "a" ]
    , tags = []
    }


main : Bibliopola.Program
main =
    fromBook book
