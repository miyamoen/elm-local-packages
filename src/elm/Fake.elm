module Fake exposing (model, package, packages)

import Dict
import Elm.Version as Version
import Route exposing (Route(..))
import SelectList
import Types exposing (..)


model : Model
model =
    { allPackages = packages
    , allDocs =
        Dict.singleton ( "arowM", "elm-reference", "1.0.0" ) <|
            Success
                { readMe = readMe
                , moduleDocs = []
                , authorName = "arowM"
                , packageName = "elm-reference"
                , version = Version.one
                }
    , errors = []
    , route = Home
    }


readMe : String
readMe =
    """# elm-reference

[![Build Status](https://travis-ci.org/arowM/elm-reference.svg?branch=master)](https://travis-ci.org/arowM/elm-reference)

An immutable approach imitating references of mutable languages.

[![elm-reference-small](https://user-images.githubusercontent.com/1481749/43362741-ad7a4868-932c-11e8-94a6-850c904b814e.png)
](https://twitter.com/hashtag/%E3%81%95%E3%81%8F%E3%82%89%E3%81%A1%E3%82%83%E3%82%93%E6%97%A5%E8%A8%98?src=hash)

Any PRs are welcome, even for documentation fixes.  (The main author of this library is not an English native.)

![example](https://user-images.githubusercontent.com/1481749/43438888-6a75b5e8-94cb-11e8-873d-06778ead6051.gif)

## Top of Contents

* [What problem can `Reference` resolve?](#what-problem-can-reference-resolve)
* [Reference of mutable programing languages help us!](#reference-of-mutable-programing-languages-help-us)
* [Concept of the `Reference`](#concept-of-the-reference)
* [Example code using `Reference`](#example-code-using-reference)
* [More examples](#more-examples)
* [Related works](#related-works)

## What problem can `Reference` resolve?

It is often case to render list of sub views, such as TODO lists, registered user lists, list of posts, etc...
`Reference` is useful in such cases.

Here is an part of simple application code that increments numbers on each row by clicking.

```elm
init : ( Model, Cmd Msg )
init =
    ( { nums = [ 1, 2, 3, 4, 5, 6 ]
      }
    , Cmd.none
    )



-- MODEL


type alias Model =
    { nums : List Int
    }



-- UPDATE


type Msg
    = ClickNumber Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickNumber idx ->
            ( { model
                | nums =
                    List.Extra.updateAt idx ((+) 1) model.nums
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div [] <| List.indexedMap renderRow model.nums


renderRow : Int -> Int -> Html Msg
renderRow idx n =
    div
        [ Events.onClick (ClickNumber idx)
        ]
        [ text <| toString n
        ]
```

In this code, index number of clicked number is passed to update function with `ClickNumber` message.
It is common technique of the Elm architecture, but it does not seem to be straightforward...
How can we realize this sort of probrem intuitively?

## Reference of mutable programing languages help us!

Some mutable programing languages can handle reference as following example of JS.

```js
> arr = [ {val: 1}, {val: 2}, {val: 3} ]
> x = arr[1]
> x.val = 3
> arr
[ { val: 1 }, { val: 3 }, { val: 3 } ]
```

If Elm could handle references as mutable languages, it would be possible to resolve the previous problem by passing reference of the clicked number to the `Msg` instead of index as follows.

```elm
type Msg
    = ClickNumber SomeSortOfReference
```

The basic motivation of `Reference` library is to empower the references of mutable languages to the Elm.

## Concept of the `Reference`

`Reference` has concept of `this` and `root`.

* `this` means focused value (`x = arr[1]` in the previous JS example)
* `root` means root value (`arr` in the previous JS example)

The core data type of `Reference` is `Reference this root`, which can be created by providing `this` value and function to specify how `root` depends on the `this` value.

```elm
fromRecord : { this : a, rootWith : a -> root } -> Reference a root
```

To pick out `this` value and `root` value from `Reference`, use following functions.

```elm
this : Reference this root -> this
root : Reference this root -> root
```

Now we can create `Reference` and then pick out `this` and `value`.

```elm
ref : Reference Int (List Int)
ref = fromRecord
    { this = 3
    , rootWith = \\x -> [1,2] ++ x :: [4,5]
    }

this ref
--> 3

root ref
--> [ 1, 2, 3, 4, 5 ]
```

Next, let's modify the `ref` value declared in the above example.
We can use `modify` for the purpose.

```elm
modify : (a -> a) -> Reference a root -> Reference a root
```

As you can see in the bellow example, `modify` also updates `root` value.

```elm
ref2 : Reference Int (List Int)
ref2 = modify (
 -> n + 1) ref

this ref
--> 3
this ref2
--> 4

root ref
--> [ 1, 2, 3, 4, 5 ]
root ref2
--> [ 1, 2, 4, 4, 5 ]
```

## Example code using `Reference`

The following code is the same application using `Reference`s instead of index numbers.

```elm
type Msg
    = ClickNumber (Reference Int (List Int))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickNumber ref ->
            ( { model
                | nums =
                    Reference.root <| Reference.modify ((+) 1) ref
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div [] <| Reference.List.unwrap renderRow <| Reference.top model.nums


renderRow : Reference Int (List Int) -> Html Msg
renderRow ref =
    div
        [ Events.onClick (ClickNumber ref)
        ]
        [ text <| toString <| Reference.this ref
        ]
```

## More examples

Though it would not seem to be better than index number version of code in previous example,
it can be more powerful when we have to handle nested list like tree.

```elm
type alias Model =
    { tree : List Node
    }


type Node
    = Node Int (List Node)
```

Example codes including such cases are available in the `example` directory.

## Related works

### Lens

[Monocle-Lens](http://package.elm-lang.org/packages/arturopala/elm-monocle/1.7.0/Monocle-Lens) is one of the similar concept to `Reference`.

There are three reasons why I developed this library.

First, this is not completely the same structure with Lens. `Reference this root` can be rewritten by following definition.

```elm
type alias Reference this root = ( this, Lens this root )
```

The main target usage of this library is updating list value when some events are fired on sub view as example app described previously.
So, it is important to hold current value (i.e., `this`) itself in the data type.

Second, it is recommended to target a concrete use case as [Designing APIs](https://github.com/elm-lang/elm-package#designing-apis) of elm-package says.
It means `elm-reference` should be published as an independent library to handle concrete use case described above.

Third, the `Reference.List.unwrap` function is so powerful for such a usage but not so easy for end users to implement by themselves.
It is worth publishing `elm-reference` just to provide `Reference.List.unwrap`.

### Zipper

There is an approach called `Zipper` to handle tree-like structures.

For example, following implementations exist.

* `zwilias/elm-rosetree/Tree-Zipper` simple but fast
* `tomjkidd/elm-multiway-tree-zipper` sturdy but faster
* `turboMaCk/lazy-tree-with-zipper` - [Experimental] lazy but very fast

The relation between `Zipper` and `Reference` is:

* `this` is equivalent to a `label`
* `root` is equivalent to the `zipped tree`
* `ref` is equivalent to a tree zipper

But `Zipper` is not exactly for the purpose of updating an element by View events.
I guess it's not so easy question "How to resolve Vue tree view example in Elm using Zipper?".
In that point of view, `Reference` is more suitable to handle such problems.
(Of course, it is recommended to use `Zipper` if an application requires tree navigation feature.)

From another point of view, `Reference` is one of the abstraction of tree Zipper.
The `Zipper` is specialized version of `Reference` (`type alias Zipper a = Reference a (Tree a)`).
It means `Reference` can handle any structures in addition to `Tree`.
One example that `Zipper` cannot handle is strange Tree structure such as `type BiTree = Node (List BiTree) (List BiTree)`.
Another example that `Zipper` could not handle easily is [UpDown example](https://github.com/arowM/elm-reference/blob/master/example/src/UpDown.elm) in the `example` directory.

"""


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
