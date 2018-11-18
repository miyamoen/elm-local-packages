module TypeAnnotation exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Elm.Docs exposing (Block(..))
import Elm.Type exposing (Type(..))
import Elm.Version
import Fake exposing (model)
import MarkdownBlock
import Status
import Types exposing (..)
import Util.AllDocs as AllDocs
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Type -> Element msg
view tipe =
    none


book : Book
book =
    bookWithFrontCover "TypeAnnotation" (view (Var "constant"))


main : Bibliopola.Program
main =
    fromBook book
