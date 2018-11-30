module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Logo
import Views.Atoms.MarkdownBlock
import Views.Atoms.Status


shelf : Shelf
shelf =
    emptyShelf "elm-local-packages"
        |> addShelf
            (emptyShelf "Atoms"
                |> addBook Views.Atoms.Logo.book
                |> addBook Views.Atoms.MarkdownBlock.book
                |> addBook Views.Atoms.Status.book
            )


main : Bibliopola.Program
main =
    fromShelf shelf
