module Components.NewLink(Model, init, Action, update, view, Context, viewWithSubmitAction) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)

-- official 'Elm Architecture' package
-- https://github.com/evancz/start-app
-- import StartApp

-- component import example
-- import Components.Hello exposing ( hello )

-- APP KICK OFF!
-- app = StartApp.start
--   { init = init
--   , update = update
--   , view = view
--   , inputs = [ Signal.map (always NoOp) swap]
--   }

-- main = app.html

-- HOT-SWAPPING
-- port swap : Signal.Signal Bool

-- MODEL
type alias Model =
  { name : String
  , url  : String
  }

emptyModel =
  { name = ""
  , url  = ""
  }

-- INIT
init = (emptyModel, Effects.none)

-- VIEW
-- Examples of:
-- 1)  an externally defined component ('hello', takes 'model' as arg)
-- 2a) styling through CSS classes (external stylesheet)
-- 2b) styling using inline style attribute (two variants)
view address model =
  div
    [ class "mt-palette-accent" ]
    [  input [ value model.name, on "input" targetValue (Signal.message address << UpdateName), style [("color", "#000")] ] []
    ,  input [ value model.url, on "input" targetValue (Signal.message address << UpdateUrl), style [("color", "#000")] ] []
    ,  button [ class "mt-button-sm", onClick address Submit ] [ text "Add" ]
    ]

type alias Context =
  { actions : Signal.Address Action
  , submit : Signal.Address ()
  }

viewWithSubmitAction context model =
  div
    [ class "mt-palette-accent" ]
    [  input [ value model.name, on "input" targetValue (Signal.message context.actions << UpdateName), style [("color", "#000")] ] []
    ,  input [ value model.url, on "input" targetValue (Signal.message context.actions << UpdateUrl), style [("color", "#000")] ] []
    ,  button [ class "mt-button-sm", onClick context.submit () ] [ text "Add" ]
    ]

-- UPDATE
type Action 
  = NoOp
  | Submit
  | UpdateName String
  | UpdateUrl String

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Submit -> ( model, Effects.none )
    UpdateName newName -> 
      ( { model | name = newName }, Effects.none )
    UpdateUrl newUrl -> 
      ( { model | url = newUrl }, Effects.none )
