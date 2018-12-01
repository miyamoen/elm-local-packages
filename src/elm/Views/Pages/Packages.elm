module Views.Pages.Packages exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Fake
import Types exposing (..)
import Types.Packages as Packages
import Views.Atoms.SearchInput as SearchInput
import Views.Constants as Constants
import Views.Organisms.Error as Error
import Views.Organisms.PackageSummary as PackageSummary
import Views.Utils exposing (withFrame)


view : Model -> Element Msg
view model =
    column [ width fill, spacing <| Constants.padding * 2 ]
        [ SearchInput.view NewQuery model.query
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
