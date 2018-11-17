module Page.Overview exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Constant
import Element exposing (..)
import Element.Font as Font
import Elm.Version
import Fake
import SelectList
import Types exposing (..)
import Util.Packages as Packages
import Util.Route as Route
import ViewUtil exposing (withCss)


view : Model -> Element msg
view model =
    let
        package =
            Route.packageKey model.route
                |> Maybe.andThen (\key -> Packages.find key model.allPackages)
    in
    column []
        [ el
            [ Font.size Constant.fontSize.large
            , paddingXY 0 Constant.padding
            ]
          <|
            text "Local Cached Versions"
        , row
            [ height <| px Constant.fontSize.middle
            , spacing Constant.fontSize.normal
            , Font.color Constant.color.link
            ]
          <|
            (Maybe.map versionLinks package |> Maybe.withDefault [ text "No versions" ])
        ]


versionLinks : Package -> List (Element msg)
versionLinks package =
    SelectList.selectedMap (\_ -> SelectList.selected >> versionLink) package


versionLink : PackageInfo -> Element msg
versionLink package =
    link
        [ mouseOver [ Font.color Constant.color.accent ] ]
        { url = Route.readMeAsString package
        , label =
            text <| Elm.Version.toString <| package.version
        }


book : Book
book =
    bookWithFrontCover "Overview" (view Fake.model |> withCss)


main : Bibliopola.Program
main =
    fromBook book
