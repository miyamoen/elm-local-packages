module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Breadcrumbs
import Views.Atoms.Link
import Views.Atoms.Logo
import Views.Atoms.MarkdownBlock
import Views.Atoms.Status
import Views.Organisms.Breadcrumbs
import Views.Organisms.Error
import Views.Organisms.Header
import Views.Organisms.ModuleLinks
import Views.Organisms.PackageSummary
import Views.Pages.Packages


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
                |> addBook Views.Organisms.ModuleLinks.book
                |> addShelf Views.Organisms.PackageSummary.shelf
                |> addShelf Views.Organisms.Error.shelf
                |> addBook Views.Organisms.Header.book
            )
        |> addShelf
            (emptyShelf "Pages"
                |> addBook Views.Pages.Packages.book
            )


main : Bibliopola.Program
main =
    fromShelf shelf
