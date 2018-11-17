module Sidebar exposing (view)

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Font as Font
import Elm.Docs exposing (Module)
import Fake
import Types exposing (..)
import Url.Builder exposing (relative)
import Util.AllDocs as AllDocs
import Util.Route as Route
import Util.Status as Status
import ViewUtil exposing (withCss)


view : Model -> Maybe (Element msg)
view { route, allDocs } =
    Route.docsKey route
        |> Maybe.andThen (\key -> AllDocs.find key allDocs)
        |> Maybe.andThen Status.toMaybe
        |> Maybe.map (.moduleDocs >> moduleList)


moduleList : List Module -> Element msg
moduleList moduleDocs =
    column [ spacing <| Constant.padding // 2 ]
        [ el [ Font.size <| round <| Constant.fontSize * 1.5 ] <| text "Module Docs"
        , column [] <| List.map moduleLink moduleDocs
        ]


moduleLink : Module -> Element msg
moduleLink { name } =
    link
        [ height <| px <| round <| Constant.fontSize * 1.5
        , Font.color Constant.linkColor
        , mouseOver [ Font.color Constant.accentColor ]
        ]
        { label = text name
        , url = relative [ String.replace "." "-" name ] []
        }


book : Book
book =
    bookWithFrontCover "Sidebar" (moduleList Fake.moduleDocs |> withCss)


main : Bibliopola.Program
main =
    fromBook book
