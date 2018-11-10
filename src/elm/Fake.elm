module Fake exposing (package, packages)

import Elm.Version as Version
import SelectList
import Types exposing (..)


package : Package
package =
    SelectList.fromLists []
        { deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm/virtual-dom"
        , authorName = "elm"
        , packageName = "virtual-dom"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.2"
        , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 2 ) |> Maybe.withDefault Version.one
        }
        [ { deps =
                [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "elm/virtual-dom"
          , authorName = "elm"
          , packageName = "virtual-dom"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.1"
          , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
          }
        , { deps =
                [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "elm/virtual-dom"
          , authorName = "elm"
          , packageName = "virtual-dom"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.0"
          , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]


packages : List Package
packages =
    [ SelectList.fromLists []
        { authorName = "akoppela"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/svg", "1.0.0 <= v < 2.0.0" )
            , ( "mdgriffith/elm-ui", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "akoppela/elm-logo"
        , packageName = "elm-logo"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/akoppela/elm-logo/1.0.1"
        , summary = "SVG Elm Logo"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "arowM"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "MIT"
        , name = "arowM/elm-reference"
        , packageName = "elm-reference"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/arowM/elm-reference/1.0.4"
        , summary = "An immutable approach imitating references of mutable languages."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 4 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "avh4"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "avh4/elm-color"
        , packageName = "elm-color"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/avh4/elm-color/1.0.0"
        , summary = "Standard representation of colors, encouraging sharing between packages"
        , testDeps =
            [ ( "elm-explorations/test", "1.1.0 <= v < 2.0.0" )
            , ( "rtfeldman/elm-hex", "1.0.0 <= v < 2.0.0" )
            , ( "NoRedInk/elm-json-decode-pipeline", "1.0.0 <= v < 2.0.0" )
            ]
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/time", "1.0.0 <= v < 2.0.0" )
            , ( "elm/url", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm/browser"
        , packageName = "browser"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/browser/1.0.1"
        , summary = "Run Elm in browsers, with access to browser history for single-page apps (SPAs)"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm"
          , deps =
                [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/html", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                , ( "elm/time", "1.0.0 <= v < 2.0.0" )
                , ( "elm/url", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "elm/browser"
          , packageName = "browser"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/browser/1.0.0"
          , summary = "Run Elm in browsers, with access to browser history for single-page apps (SPAs)"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = []
        , license = "BSD-3-Clause"
        , name = "elm/core"
        , packageName = "core"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/core/1.0.0"
        , summary = "Elm's standard libraries"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/json", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/http"
        , packageName = "http"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/http/1.0.0"
        , summary = "Make HTTP requests"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm/html"
        , packageName = "html"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/html/1.0.0"
        , summary = "Fast HTML, rendered with virtual DOM diffing"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/json"
        , packageName = "json"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/json/1.0.0"
        , summary = "Encode and decode JSON values"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/parser"
        , packageName = "parser"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/parser/1.1.0"
        , summary = "a parsing library, focused on simplicity and great error messages"
        , testDeps = []
        , version = Version.fromTuple ( 1, 1, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "elm/parser"
          , packageName = "parser"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/parser/1.0.0"
          , summary = "a parsing library, focused on simplicity and great error messages"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/parser", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm/project-metadata-utils"
        , packageName = "project-metadata-utils"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/project-metadata-utils/1.0.0"
        , summary = "Work with elm.json and docs.json files in Elm"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/regex"
        , packageName = "regex"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/regex/1.0.0"
        , summary = "Support for JS-style regular expressions in Elm"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/time", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/random"
        , packageName = "random"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/random/1.0.0"
        , summary = "Generate random numbers and values (RNG)"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm/svg"
        , packageName = "svg"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/svg/1.0.1"
        , summary = "Fast SVG, rendered with virtual DOM diffing"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm"
          , deps =
                [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/html", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "elm/svg"
          , packageName = "svg"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/svg/1.0.0"
          , summary = "Fast SVG, rendered with virtual DOM diffing"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/time"
        , packageName = "time"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/time/1.0.0"
        , summary = "Work with POSIX times, time zones, years, months, days, hours, seconds, etc."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/url"
        , packageName = "url"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/url/1.0.0"
        , summary = "Create and parse URLs. Use for HTTP and \"routing\" in single-page apps (SPAs)"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/json", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm/virtual-dom"
        , packageName = "virtual-dom"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.2"
        , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 2 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/json", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "elm/virtual-dom"
          , packageName = "virtual-dom"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.1"
          , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
          }
        , { authorName = "elm"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/json", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "elm/virtual-dom"
          , packageName = "virtual-dom"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm/virtual-dom/1.0.0"
          , summary = "Core virtual DOM implementation, basis for HTML and SVG libraries"
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm-explorations"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/html", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm-explorations/markdown"
        , packageName = "markdown"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-explorations/markdown/1.0.0"
        , summary = "Fast markdown parsing and rendering"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm-explorations"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/random", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm-explorations/test"
        , packageName = "test"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-explorations/test/1.1.0"
        , summary = "Write unit and fuzz tests for Elm code."
        , testDeps = []
        , version = Version.fromTuple ( 1, 1, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm-explorations"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/random", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "elm-explorations/test"
          , packageName = "test"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-explorations/test/1.0.0"
          , summary = "Write unit and fuzz tests for Elm code."
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm-community"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm-community/list-extra"
        , packageName = "list-extra"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-community/list-extra/8.1.0"
        , summary = "Convenience functions for working with List"
        , testDeps = [ ( "elm-explorations/test", "1.0.0 <= v < 2.0.0" ) ]
        , version = Version.fromTuple ( 8, 1, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm-community"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "elm-community/list-extra"
          , packageName = "list-extra"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-community/list-extra/8.0.0"
          , summary = "Convenience functions for working with List"
          , testDeps = []
          , version = Version.fromTuple ( 8, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "elm-community"
        , deps =
            [ ( "avh4/elm-color", "1.0.0 <= v < 2.0.0" )
            , ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "elm-community/typed-svg"
        , packageName = "typed-svg"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-community/typed-svg/5.0.0"
        , summary = "A Typed SVG (Scalable Vector Graphics) builder"
        , testDeps = []
        , version = Version.fromTuple ( 5, 0, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "elm-community"
          , deps =
                [ ( "avh4/elm-color", "1.0.0 <= v < 2.0.0" )
                , ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/html", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "elm-community/typed-svg"
          , packageName = "typed-svg"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-community/typed-svg/4.0.0"
          , summary = "A Typed SVG (Scalable Vector Graphics) builder"
          , testDeps = []
          , version = Version.fromTuple ( 4, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "folkertdev"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/parser", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "folkertdev/svg-path-lowlevel"
        , packageName = "svg-path-lowlevel"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/folkertdev/svg-path-lowlevel/3.0.0"
        , summary = "Parser and pretty printer for SVG paths"
        , testDeps =
            [ ( "elm/random", "1.0.0 <= v < 2.0.0" )
            , ( "elm-explorations/test", "1.0.0 <= v < 2.0.0" )
            ]
        , version = Version.fromTuple ( 3, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "elm-lang"
        , deps = [ ( "elm-lang/core", "5.0.0 <= v < 6.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "elm-lang/lazy"
        , packageName = "lazy"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/elm-lang/lazy/2.0.0"
        , summary = "Basic primitives for working with laziness"
        , testDeps = []
        , version = Version.fromTuple ( 2, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "Gizra"
        , deps =
            [ ( "SwiftsNamesake/proper-keyboard", "4.0.0 <= v < 5.0.0" )
            , ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "MIT"
        , name = "Gizra/elm-keyboard-event"
        , packageName = "elm-keyboard-event"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/Gizra/elm-keyboard-event/1.0.1"
        , summary = "Decoders for keyboard events"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "mdgriffith"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/parser", "1.1.0 <= v < 2.0.0" )
            , ( "mdgriffith/elm-ui", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "mdgriffith/elm-markup"
        , packageName = "elm-markup"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/mdgriffith/elm-markup/1.0.0"
        , summary = "An Elm-friendly markup parser and format. Write articles and embed Elm views."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "mdgriffith"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "mdgriffith/elm-ui"
        , packageName = "elm-ui"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/mdgriffith/elm-ui/1.1.0"
        , summary = "Layout and style that's easy to refactor, all without thinking about CSS."
        , testDeps = []
        , version = Version.fromTuple ( 1, 1, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "mdgriffith"
          , deps =
                [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/html", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "mdgriffith/elm-ui"
          , packageName = "elm-ui"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/mdgriffith/elm-ui/1.0.0"
          , summary = "Layout and style that's easy to refactor, all without thinking about CSS."
          , testDeps = []
          , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "mdgriffith"
        , deps =
            [ ( "Skinney/murmur3", "2.0.7 <= v < 3.0.0" )
            , ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/regex", "1.0.0 <= v < 2.0.0" )
            , ( "elm/virtual-dom", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "mdgriffith/style-elements"
        , packageName = "style-elements"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/mdgriffith/style-elements/5.0.0"
        , summary = "Style and Layout that doesn't mysteriously break."
        , testDeps = []
        , version = Version.fromTuple ( 5, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "miyamoen"
        , deps =
            [ ( "elm/browser", "1.0.0 <= v < 2.0.0" )
            , ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            , ( "elm/parser", "1.1.0 <= v < 2.0.0" )
            , ( "elm/svg", "1.0.0 <= v < 2.0.0" )
            , ( "elm/url", "1.0.0 <= v < 2.0.0" )
            , ( "mdgriffith/elm-ui", "1.0.0 <= v < 2.0.0" )
            , ( "miyamoen/select-list", "4.0.0 <= v < 5.0.0" )
            , ( "miyamoen/tree-with-zipper", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "miyamoen/bibliopola"
        , packageName = "bibliopola"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/miyamoen/bibliopola/2.0.1"
        , summary = "UI Catalog for Elm applications built by elm-ui inspired by Storybook"
        , testDeps = [ ( "elm-explorations/test", "1.1.0 <= v < 2.0.0" ) ]
        , version = Version.fromTuple ( 2, 0, 1 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "miyamoen"
          , deps =
                [ ( "elm/browser", "1.0.0 <= v < 2.0.0" )
                , ( "elm/core", "1.0.0 <= v < 2.0.0" )
                , ( "elm/html", "1.0.0 <= v < 2.0.0" )
                , ( "elm/json", "1.0.0 <= v < 2.0.0" )
                , ( "elm/parser", "1.1.0 <= v < 2.0.0" )
                , ( "elm/svg", "1.0.0 <= v < 2.0.0" )
                , ( "elm/url", "1.0.0 <= v < 2.0.0" )
                , ( "mdgriffith/elm-ui", "1.0.0 <= v < 2.0.0" )
                , ( "miyamoen/select-list", "3.0.0 <= v < 4.0.0" )
                , ( "miyamoen/tree-with-zipper", "1.0.0 <= v < 2.0.0" )
                ]
          , license = "BSD-3-Clause"
          , name = "miyamoen/bibliopola"
          , packageName = "bibliopola"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/miyamoen/bibliopola/2.0.0"
          , summary = "UI Catalog for Elm applications built by elm-ui inspired by Storybook"
          , testDeps = [ ( "elm-explorations/test", "1.1.0 <= v < 2.0.0" ) ]
          , version = Version.fromTuple ( 2, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "miyamoen"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "miyamoen/select-list"
        , packageName = "select-list"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/miyamoen/select-list/4.0.0"
        , summary = "A non-empty list and one of zipper."
        , testDeps = [ ( "elm-explorations/test", "1.1.0 <= v < 2.0.0" ) ]
        , version = Version.fromTuple ( 4, 0, 0 ) |> Maybe.withDefault Version.one
        }
        [ { authorName = "miyamoen"
          , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
          , license = "BSD-3-Clause"
          , name = "miyamoen/select-list"
          , packageName = "select-list"
          , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/miyamoen/select-list/3.0.0"
          , summary = "A non-empty list in which exactly one element is always selected."
          , testDeps = [ ( "elm-explorations/test", "1.0.0 <= v < 2.0.0" ) ]
          , version = Version.fromTuple ( 3, 0, 0 ) |> Maybe.withDefault Version.one
          }
        ]
    , SelectList.fromLists []
        { authorName = "miyamoen"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "miyamoen/tree-with-zipper"
        , packageName = "tree-with-zipper"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/miyamoen/tree-with-zipper/1.0.0"
        , summary = "Rose tree (multiway tree) with zipper."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "NoRedInk"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ), ( "elm/json", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "NoRedInk/elm-json-decode-pipeline"
        , packageName = "elm-json-decode-pipeline"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/NoRedInk/elm-json-decode-pipeline/1.0.0"
        , summary = "Use pipelines to build JSON Decoders."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "NoRedInk"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "NoRedInk/elm-simple-fuzzy"
        , packageName = "elm-simple-fuzzy"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/NoRedInk/elm-simple-fuzzy/1.0.3"
        , summary = "Fuzzy matching and filtering for strings."
        , testDeps = [ ( "elm-explorations/test", "1.0.0 <= v < 2.0.0" ) ]
        , version = Version.fromTuple ( 1, 0, 3 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "ohanhi"
        , deps =
            [ ( "elm/browser", "1.0.0 <= v < 2.0.0" )
            , ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "elm/json", "1.0.0 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "ohanhi/keyboard"
        , packageName = "keyboard"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/ohanhi/keyboard/1.0.0"
        , summary = "Helpers for working with keyboard inputs (ex keyboard-extra)"
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "Skinney"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "MIT"
        , name = "Skinney/murmur3"
        , packageName = "murmur3"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/Skinney/murmur3/2.0.7"
        , summary = "An implementation of the Murmur3 hash function for Elm"
        , testDeps = []
        , version = Version.fromTuple ( 2, 0, 7 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "SwiftsNamesake"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "MIT"
        , name = "SwiftsNamesake/proper-keyboard"
        , packageName = "proper-keyboard"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/SwiftsNamesake/proper-keyboard/4.0.0"
        , summary = "Introduces type-safe keys"
        , testDeps = []
        , version = Version.fromTuple ( 4, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "turboMaCk"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "turboMaCk/any-dict"
        , packageName = "any-dict"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/turboMaCk/any-dict/1.0.1"
        , summary = "Elm dictionary with custom key types."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 1 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "turboMaCk"
        , deps =
            [ ( "elm/core", "1.0.0 <= v < 2.0.0" )
            , ( "turboMaCk/any-dict", "1.0.1 <= v < 2.0.0" )
            ]
        , license = "BSD-3-Clause"
        , name = "turboMaCk/any-set"
        , packageName = "any-set"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/turboMaCk/any-set/1.0.0"
        , summary = "Sets with custom key types."
        , testDeps = []
        , version = Version.fromTuple ( 1, 0, 0 ) |> Maybe.withDefault Version.one
        }
        []
    , SelectList.fromLists []
        { authorName = "zwilias"
        , deps = [ ( "elm/core", "1.0.0 <= v < 2.0.0" ) ]
        , license = "BSD-3-Clause"
        , name = "zwilias/elm-rosetree"
        , packageName = "elm-rosetree"
        , path = "C:/Users/miyam/AppData/Roaming/elm/0.19.0/package/zwilias/elm-rosetree/1.2.2"
        , summary = "Strict multiway trees aka rosetrees and a Zipper to go with them"
        , testDeps =
            [ ( "elm/html", "1.0.0 <= v < 2.0.0" )
            , ( "elm-explorations/test", "1.0.0 <= v < 2.0.0" )
            ]
        , version = Version.fromTuple ( 1, 2, 2 ) |> Maybe.withDefault Version.one
        }
        []
    ]
