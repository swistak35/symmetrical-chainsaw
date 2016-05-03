module Components.NewLink(Model, init, Action, update, view, Context, viewWithSubmitAction) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)

type alias Model =
  { name : String
  , url  : String
  }

emptyModel =
  { name = ""
  , url  = ""
  }

init = (emptyModel, Effects.none)

view address model =
  div
    [ class "mt-palette-accent" ]
    [  input [ value model.name, on "input" targetValue (Signal.message address << UpdateName), style [("color", "#000")] ] []
    ,  input [ value model.url, on "input" targetValue (Signal.message address << UpdateUrl), style [("color", "#000")] ] []
    ,  button [ class "mt-button-sm", onClick address Submit ] [ text "Add" ]
    ]

type alias Context =
  { actions : Signal.Address Action
  , submit  : Signal.Address ()
  }

viewWithSubmitAction context model =
  Html.form [ class "col s12" ]
    [ div [ class "row" ]
      [ div [ class "input-field col s12" ]
        [ input [ value model.name, class "validate", placeholder "Name", id "link_name", on "input" targetValue (Signal.message context.actions << UpdateName) ] []
        -- , label [ for "link_name" ] [ text "Name of the bookmark" ]
        ]
      ]
    , div [ class "row" ]
      [ div [ class "input-field col s12" ]
        [ input [ value model.url, class "validate", placeholder "URL", id "link_url", on "input" targetValue (Signal.message context.actions << UpdateUrl) ] []
        -- , label [ for "link_url" ] [ text "URL of the bookmark" ]
        ]
      ]
    , div [ class "row" ]
      [ div [ class "col s3 offset-s9"]
        [ button [ class "waves-effect waves-light btn", onClick context.submit () ] [ text "Add" ]
        ]
      ]
    ]

-- viewWithSubmitAction context model =
--   div
--     [ class "mt-palette-accent" ]
--     [  input [ value model.name, on "input" targetValue (Signal.message context.actions << UpdateName), style [("color", "#000")] ] []
--     ,  input [ value model.url, on "input" targetValue (Signal.message context.actions << UpdateUrl), style [("color", "#000")] ] []
--     ,  button [ class "mt-button-sm", onClick context.submit () ] [ text "Add" ]
--     ]

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
