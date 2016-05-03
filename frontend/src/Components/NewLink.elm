module Components.NewLink(Model, init, Action, update, Context, viewWithSubmitAction) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)
import String
import List

------------
-- MODEL

type alias Model =
  { name     : String
  , url      : String
  , tags     : List String
  , typedTag : String
  }

emptyModel =
  { name     = ""
  , url      = ""
  , tags     = []
  , typedTag = ""
  }

init = (emptyModel, Effects.none)

------------
-- VIEW

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
      [ div [ class "input-field col s12"] (List.map viewTag model.tags)
      ]
    , div [ class "row" ]
      [ div [ class "input-field col s12" ]
        [ input [ value model.typedTag, class "validate", placeholder "Add Tags", on "input" targetValue (Signal.message context.actions << UpdateTypedTag) ] []
        ]
      ]
    , div [ class "row" ]
      [ div [ class "col s3 offset-s9"]
        [ button [ class "waves-effect waves-light btn", onClick context.submit () ] [ text "Add" ]
        ]
      ]
    ]

viewTag tag =
  div
    [ class "chip" ]
    [ text tag, i [ class "material-icons" ] [ text "close" ] ]


------------
-- UPDATE

type Action 
  = NoOp
  | Submit
  | UpdateName String
  | UpdateUrl String
  | UpdateTypedTag String

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Submit -> ( model, Effects.none )
    UpdateName newName -> 
      ( { model | name = newName }, Effects.none )
    UpdateUrl newUrl -> 
      ( { model | url = newUrl }, Effects.none )
    UpdateTypedTag newTypedTag ->
      if String.endsWith "," newTypedTag
      then ( { model | typedTag = "", tags = List.append model.tags [ cleanTag newTypedTag ] }, Effects.none )
      else ( { model | typedTag = newTypedTag }, Effects.none )

cleanTag tag = String.trim (String.dropRight 1 tag)
