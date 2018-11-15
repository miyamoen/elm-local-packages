module Util.Route exposing (extractDocsKey)

import Route exposing (..)
import Types exposing (..)


extractDocsKey : Route -> Maybe (DocsKey {})
extractDocsKey route =
    case route of
        Package authorName packageName (ReadMe version) ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        Package authorName packageName (Module version _) ->
            Just
                { authorName = authorName
                , packageName = packageName
                , version = version
                }

        _ ->
            Nothing
