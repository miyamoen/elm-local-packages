module Page.Packages exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Fake
import PackageSummary
import Types exposing (..)


view : Model -> Element msg
view model =
    column [] <| List.map PackageSummary.view model.allPackages


book : Book
book =
    bookWithFrontCover "Packages" (view Fake.model)


main : Bibliopola.Program
main =
    fromBook book
