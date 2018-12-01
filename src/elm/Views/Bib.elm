module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Breadcrumbs
import Views.Atoms.Link
import Views.Atoms.Logo
import Views.Atoms.MarkdownBlock
import Views.Atoms.Status
import Views.Organisms.Breadcrumbs
import Views.Organisms.Header


shelf : Shelf
shelf =
    emptyShelf "elm-local-packages"
        |> addShelf
            (emptyShelf "Atoms"
                |> addBook Views.Atoms.Link.book
                |> addBook Views.Atoms.Logo.book
                |> addBook Views.Atoms.Breadcrumbs.book
                |> addBook Views.Atoms.MarkdownBlock.book
                |> addBook Views.Atoms.Status.book
            )
        |> addShelf
            (emptyShelf "Organisms"
                |> addBook Views.Organisms.Breadcrumbs.book
                |> addBook Views.Organisms.Header.book
            )


main : Bibliopola.Program
main =
    fromShelf shelf
