module Fake exposing
    ( exposedKeyValues
    , exposedList
    , model
    , moduleDoc
    , moduleDocs
    , route
    )

import Dict
import Elm.Docs exposing (..)
import Elm.Type exposing (Type(..))
import Elm.Version as Version
import Fake.Packages exposing (packages)
import Fake.ReadMe exposing (readMe)
import SelectList
import Types exposing (..)
import Types.Packages as Packages


model : Model
model =
    { allPackages = Packages.sort packages
    , allDocs =
        Dict.singleton ( "arowM", "elm-reference", "1.0.0" ) <|
            Success
                { readMe = readMe
                , moduleDocs = moduleDocs
                , authorName = "arowM"
                , packageName = "elm-reference"
                , version = Version.one
                }
    , errors = []
    , routes = SelectList.fromLists [] route []
    , query = ""
    }


route : Route
route =
    ReadMePage
        { authorName = "arowM"
        , packageName = "elm-reference"
        , version = Version.one
        }


moduleDoc : Module
moduleDoc =
    { aliases = []
    , binops = []
    , comment = " `Reference` is a concept to handle immutable data structure flexibly as using \"reference\" in mutable languages.\n\n\n# Primitives\n\n@docs Reference\n@docs this\n@docs root\n@docs rootWith\n\n\n# Constructors\n\n@docs fromRecord\n@docs top\n\n\n# Operators\n\n@docs modify\n@docs map\n\n"
    , name = "Reference"
    , unions =
        [ { args = [ "a", "root" ]
          , comment = " A core data type to realize references of mutable programing languages in Elm.\nAfter modifying target value by `modify` function, `root` value is also updated as an example bellow.\n\n    ref : Reference Int (List Int)\n    ref = fromRecord\n        { this = 3\n        , rootWith = \\x -> [1,2] ++ x :: [4,5]\n        }\n\n    this ref\n    --> 3\n\n    root ref\n    --> [ 1, 2, 3, 4, 5 ]\n\n    ref2 : Reference Int (List Int)\n    ref2 = modify (\\n -> n + 1) ref\n\n    this ref2\n    --> 4\n\n    root ref2\n    --> [ 1, 2, 4, 4, 5 ]\n\n"
          , name = "Reference"
          , tags = []
          }
        ]
    , values =
        [ { comment = " A constructor for `Reference`.\n"
          , name = "fromRecord"
          , tipe =
                Lambda
                    (Record
                        [ ( "this", Var "a" )
                        , ( "rootWith", Lambda (Var "a") (Var "root") )
                        ]
                        Nothing
                    )
                    (Type "Reference.Reference"
                        [ Var "a", Var "root" ]
                    )
          }
        , { comment = " Change root object type by providing convert function.\n\n    ref : Reference Int (List Int)\n    ref = fromRecord\n        { this = 4\n        , rootWith = \\x ->\n            x :: [5]\n        }\n\n    rootWith : List Int -> List (List Int)\n    rootWith ls =\n        [[2, 3]] ++ [ls] ++ [[6, 7]]\n\n    newRef : Reference Int (List (List Int))\n    newRef = map rootWith ref\n\n    this ref\n    --> 4\n\n    root ref\n    --> [4, 5]\n\n    this newRef\n    --> 4\n\n    root newRef\n    --> [[2,3], [4,5], [6,7]]\n\n    modifiedRef : Reference Int (List (List Int))\n    modifiedRef = modify (\\_ -> 8) newRef\n\n    this modifiedRef\n    --> 8\n\n    root modifiedRef\n    --> [[2,3], [8,5], [6,7]]\n\n"
          , name = "map"
          , tipe =
                Lambda (Lambda (Var "b") (Var "c"))
                    (Lambda (Type "Reference.Reference" [ Var "a", Var "b" ])
                        (Type "Reference.Reference" [ Var "a", Var "c" ])
                    )
          }
        , { comment = " Modify an object. It makes root object also changed.\n\n    ref : Reference Int (List Int)\n    ref = fromRecord\n        { this = 2\n        , rootWith = \\x -> [1] ++ [x] ++ [3]\n        }\n\n    modifiedRef : Reference Int (List Int)\n    modifiedRef = modify (\\n -> n * 10) ref\n\n    this modifiedRef\n    --> 20\n\n    root modifiedRef\n    --> [1, 20, 3]\n\n"
          , name = "modify"
          , tipe =
                Lambda (Lambda (Var "a") (Var "a"))
                    (Lambda (Type "Reference.Reference" [ Var "a", Var "root" ])
                        (Type "Reference.Reference" [ Var "a", Var "root" ])
                    )
          }
        , { comment = " Pick out root object from `Reference` value.\n\n    ref : Reference Int (List Int)\n    ref = fromRecord\n        { this = 2\n        , rootWith = \\x -> [1] ++ [x] ++ [3]\n        }\n\n    root ref\n    --> [1, 2, 3]\n\n"
          , name = "root"
          , tipe = Lambda (Type "Reference.Reference" [ Var "a", Var "root" ]) (Var "root")
          }
        , { comment = " Pick out root object from `Reference` value by specifying `this` value.\n\n    rootWith ref a == root <| modify (\\_ -> a) ref\n\n"
          , name = "rootWith"
          , tipe =
                Lambda (Type "Reference.Reference" [ Var "a", Var "root" ])
                    (Lambda (Var "a") (Var "root"))
          }
        , { comment = " Get focused object from `Reference` value.\n\n    ref : Reference Int (List Int)\n    ref = fromRecord\n        { this = 2\n        , rootWith = \\x -> [1] ++ [x] ++ [3]\n        }\n\n    this ref\n    --> 2\n\n"
          , name = "this"
          , tipe =
                Lambda (Type "Reference.Reference" [ Var "a", Var "root" ])
                    (Var "a")
          }
        , { comment = " A constructor for `Reference` to create top root object.\n\n    ref : Reference (Maybe Int) (Maybe Int)\n    ref = top (Just 3)\n\n    this ref\n    --> Just 3\n\n    root ref\n    --> Just 3\n\n"
          , name = "top"
          , tipe =
                Lambda (Var "a")
                    (Type "Reference.Reference" [ Var "a", Var "a" ])
          }
        ]
    }


moduleDocs : List Module
moduleDocs =
    [ moduleDoc
    , { aliases = []
      , binops = []
      , comment = " `List` specific functions for `Reference`.\n\n@docs unwrap\n\n"
      , name = "Reference.List"
      , unions = []
      , values =
            [ { comment = " Map and unwrap to list.\nThis is especially useful for updating list of sub views in the Elm architecture.\n\nSee more about [README](http://package.elm-lang.org/packages/arowM/elm-reference/latest)\n\n"
              , name = "unwrap"
              , tipe =
                    Lambda
                        (Lambda
                            (Type "Reference.Reference" [ Var "a", Var "x" ])
                            (Var "b")
                        )
                        (Lambda (Type "Reference.Reference" [ Type "List.List" [ Var "a" ], Var "x" ])
                            (Type "List.List" [ Var "b" ])
                        )
              }
            ]
      }
    ]


exposedList : Exposed
exposedList =
    ExposedList [ "Json.Decode", "Json.Encode" ]


exposedKeyValues : Exposed
exposedKeyValues =
    ExposedKeyValues
        [ ( "Primitives", [ "Basics", "String", "Char", "Bitwise", "Tuple" ] )
        , ( "Collections", [ "List", "Dict", "Set", "Array" ] )
        , ( "Error Handling", [ "Maybe", "Result" ] )
        , ( "Debug", [ "Debug" ] )
        , ( "Effects", [ "Platform.Cmd", "Platform.Sub", "Platform", "Process", "Task" ] )
        ]
