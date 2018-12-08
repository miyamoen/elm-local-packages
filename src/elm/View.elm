module View exposing (view)

import Browser exposing (Document)
import CommandPallet
import Element exposing (..)
import SelectList
import Types exposing (..)
import Views.Organisms.MultiColumns as MultiColumns
import Views.Organisms.Routing as Routing
import Views.Utils exposing (rootAttributes)


view : WithKey Model -> Document Msg
view (WithKey _ model) =
    { title = "Elm Local Packages"
    , body =
        [ layoutWith
            { options = [ focusStyle <| FocusStyle Nothing Nothing Nothing ] }
            ([ CommandPallet.inFront model.commandPallet
             , height fill
             ]
                ++ rootAttributes
            )
          <|
            MultiColumns.view model
        ]
    }
