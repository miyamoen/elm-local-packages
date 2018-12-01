module Views.Pages.Packages exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (labelHidden, placeholder)
import Fake
import Json.Decode as Decode
import Types exposing (..)
import Types.Packages as Packages
import Views.Constants as Constants exposing (fontSize)
import Views.Organisms.Error as Error
import Views.Organisms.PackageSummary as PackageSummary
import Views.Utils exposing (withFrame)


view : Model -> Element Msg
view model =
    column [ width fill ]
        [ Input.text [ Border.rounded 8, padding 10, Font.size fontSize.middle ]
            { onChange = NewQuery
            , text = model.query
            , placeholder =
                if String.isEmpty model.query then
                    Just <| placeholder [] <| text "Search"

                else
                    Nothing
            , label = labelHidden "search"
            }
        , PackageSummary.listView <| Packages.filter model.query model.allPackages
        , Error.listView model.errors
        ]


book : Book
book =
    bookWithFrontCover "Packages"
        (view Fake.model
            |> withFrame
            |> Element.map msgToString
        )


main : Bibliopola.Program
main =
    fromBook book
