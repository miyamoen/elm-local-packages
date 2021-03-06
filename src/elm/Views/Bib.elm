module Views.Bib exposing (main, shelf)

import Bibliopola exposing (..)
import Views.Atoms.Breadcrumbs
import Views.Atoms.Link
import Views.Atoms.Logo
import Views.Atoms.MarkdownBlock
import Views.Atoms.SearchInput
import Views.Atoms.Status
import Views.Organisms.Breadcrumbs
import Views.Organisms.Error
import Views.Organisms.Header
import Views.Organisms.ModuleLinks
import Views.Organisms.MultiColumns
import Views.Organisms.PackageSummary
import Views.Pages.Module
import Views.Pages.Overview
import Views.Pages.Packages
import Views.Pages.ReadMe


shelf : Shelf
shelf =
    emptyShelf "elm-local-packages"
        |> addShelf
            (emptyShelf "Atoms"
                |> addBook Views.Atoms.Link.book
                |> addBook Views.Atoms.SearchInput.book
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
                |> addShelf Views.Organisms.MultiColumns.shelf
            )
        |> addShelf
            (emptyShelf "Pages"
                |> addBook Views.Pages.Packages.book
                |> addBook Views.Pages.Overview.book
                |> addBook Views.Pages.ReadMe.book
                |> addBook Views.Pages.Module.book
            )


main : Bibliopola.Program
main =
    fromShelf shelf
