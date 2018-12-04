module Views.Pages.Overview exposing (view, book)

{-|

@docs view, book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Font as Font
import Elm.Version
import Fake
import SelectList
import Types exposing (..)
import Types.Packages as Packages
import Types.Route as Route
import Views.Atoms.Link as Link
import Views.Constants as Constants exposing (fontSize)
import Views.Utils exposing (withFrame)


view : Route -> Model -> Element msg
view route { allPackages } =
    let
        package =
            Route.packageKey route
                |> Maybe.andThen (\key -> Packages.find key allPackages)
    in
    column [ width fill, spacing Constants.padding ]
        [ el [ Font.size fontSize.large ] <| text "Local Cached Versions"
        , row [ spacing fontSize.normal ] <|
            (Maybe.map versionLinks package
                |> Maybe.withDefault [ text "No versions" ]
            )
        ]


versionLinks : Package -> List (Element msg)
versionLinks package =
    SelectList.selectedMap (\_ -> SelectList.selected >> versionLink) package


versionLink : PackageInfo -> Element msg
versionLink package =
    Link.view []
        { url = Route.readMeUrl package
        , label =
            text <| Elm.Version.toString <| package.version
        }


book : Book
book =
    bookWithFrontCover "Overview" (view Fake.route Fake.model |> withFrame)


main : Bibliopola.Program
main =
    fromBook book
