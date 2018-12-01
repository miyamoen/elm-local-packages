module Views.Organisms.Header exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Fake
import Types exposing (..)
import Types.Route as Route
import Views.Atoms.Logo as Logo
import Views.Colors as Colors
import Views.Constants as Constants exposing (breakPoints)
import Views.Organisms.Breadcrumbs as Breadcrumbs
import Views.Utils exposing (withFrame)


view : Model -> Element msg
view { route } =
    row
        [ width fill
        , height <| px 50
        , Background.color Colors.lightGrey
        , Border.widthEach { bottom = 2, left = 0, right = 0, top = 0 }
        , Border.color Colors.secondary
        , paddingXY Constants.padding 0
        , spacing Constants.padding
        ]
        [ link [] { label = Logo.view, url = Route.homeUrl }
        , el [ alignRight ] <| Breadcrumbs.view route
        ]


book : Book
book =
    bookWithFrontCover "Header" (withFrame <| view Fake.model)


main : Bibliopola.Program
main =
    fromBook book
