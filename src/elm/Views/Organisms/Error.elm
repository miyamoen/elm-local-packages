module Views.Organisms.Error exposing (listView, shelf, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Json.Decode as Decode
import Json.Encode as Encode
import Types exposing (..)
import Views.Constants as Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : Error -> Element msg
view error =
    case error of
        ElmJsonDecodeError decodeError ->
            column [ width fill, spacing <| Constants.padding // 2 ]
                [ el [ Font.size fontSize.middle ] <| text "elm.json deecode failed"
                , text <| Decode.errorToString decodeError
                ]

        DocsDecodeError decodeError ->
            column [ width fill, spacing <| Constants.padding // 2 ]
                [ el [ Font.size fontSize.middle ] <| text "docs.json decode failed"
                , text <| Decode.errorToString decodeError
                ]


listView : List Error -> Element msg
listView errors =
    column [ width fill, spacing <| Constants.padding * 2 ] <| List.map view errors


shelf : Shelf
shelf =
    shelfWith (bookWithFrontCover "Error" (view fakeError |> withFrame))
        |> addBook
            (bookWithFrontCover "ListView"
                (listView fakeErrors |> withFrame)
            )


fakeError : Error
fakeError =
    ElmJsonDecodeError (Decode.Failure "int" (Encode.string "4%5"))


fakeErrors : List Error
fakeErrors =
    [ fakeError
    , DocsDecodeError (Decode.Failure "MODULE DECODER" (Encode.string "Murmur3"))
    ]


main : Bibliopola.Program
main =
    fromShelf shelf
