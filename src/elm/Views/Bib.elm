module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Logo


shelf : Shelf
shelf =
    emptyShelf "elm-local-packages"
        |> addBook Views.Atoms.Logo.book


main : Bibliopola.Program
main =
    fromShelf shelf
