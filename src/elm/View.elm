module View exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Types exposing (..)
import Views.Organisms.MultiColumns as MultiColumns
import Views.Utils exposing (rootAttributes)


view : WithKey Model -> Document Msg
view (WithKey _ model) =
    { title = "Elm Local Packages"
    , body =
        [ layoutWith
            { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] }
            rootAttributes
          <|
            MultiColumns.view model
        ]
    }
