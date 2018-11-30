module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Logo
import Views.Atoms.MarkdownBlock


shelf : Shelf
shelf =
    emptyShelf "elm-local-packages"
        |> addBook Views.Atoms.Logo.book
        |> addBook Views.Atoms.MarkdownBlock.book


main : Bibliopola.Program
main =
    fromShelf shelf
