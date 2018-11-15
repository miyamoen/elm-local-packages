module Util.Packages exposing (find)

{-|

@docs find

-}

import List.Extra
import SelectList
import Types exposing (..)


find : String -> String -> List Package -> Maybe Package
find authorName packageName packages =
    List.Extra.find
        (\versions ->
            let
                pkg =
                    SelectList.selected versions
            in
            pkg.authorName == authorName && pkg.packageName == packageName
        )
        packages
