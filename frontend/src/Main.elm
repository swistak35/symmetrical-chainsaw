import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)

-- official 'Elm Architecture' package
-- https://github.com/evancz/start-app
import StartApp

-- component import example
import Components.Hello exposing ( hello )
import Components.NewLink

-- APP KICK OFF!
app = StartApp.start
  { init = init
  , update = update
  , view = view
  , inputs = [ Signal.map (always NoOp) swap]
  }

main = app.html

-- HOT-SWAPPING
port swap : Signal.Signal Bool

-- MODEL
type alias Model =
  { links : List Link
  , newLink : Components.NewLink.Model
  }

type alias Link =
  { name : String
  , url : String
  }

emptyLink = { name = "", url = "" }

-- INIT
init =
    let (newLinkModel, newLinkFx) = Components.NewLink.init
    in ({ links = [], newLink = newLinkModel }, Effects.batch [ newLinkFx ])

-- VIEW
-- Examples of:
-- 1)  an externally defined component ('hello', takes 'model' as arg)
-- 2a) styling through CSS classes (external stylesheet)
-- 2b) styling using inline style attribute (two variants)
viewNewLink address model = 
  let context =
        Components.NewLink.Context
        (Signal.forwardTo address Modify)
        (Signal.forwardTo address (always Submit))
  in Components.NewLink.viewWithSubmitAction context model

view address model =
  div []
    [ nav [] [
        div [ class "nav-wrapper" ]
          [ a [ href "#", class "brand-logo right" ] [ text "Symmetrical Chainsaw" ]
          , ul [ id "nav-mobile", class "left hide-on-med-and-down"]
            [ li [] [ a [ href "#/links" ] [ text "Links" ] ]
            , li [] [ a [ href "#/"      ] [ text "Other" ] ]
            ]
          ]
        ]
    , div [ class "row" ]
      [ div [ class "col s6" ]
        [ viewNewLink address model.newLink
        ]
      ]
    , div [ class "row" ]
      [ ul [ class "collection" ] (List.map (\x -> li [ class "collection-item avatar" ]
        [ i [ class "material-icons circle" ] [ text "folder" ]
        -- [ img [ src "images/default.png", alt "", class "circle" ] []
        -- , span [ class "title" ] [ text "Title" ]
        , a [ class "title", href x.url ] [ text x.name ]
        , p [] [ text "First line" ]
        , a [ href "#!", class "secondary-content" ] [ i [ class "material-icons" ] [ text "grade" ] ]
        ]) model.links)
      ]
    ]
    -- [ hello (List.length model.links)
    -- ,  viewNewLink address model.newLink
    -- ,  p [ style [( "color", "#FFF")] ] [ text ( "Elm Webpack Starter" ) ]
    -- ,  img [ src "img/elm.jpg", style [( "display", "block"), ( "margin", "10px auto")] ] []
    -- ,  ul [] (List.map (\x -> li [] [ a [ href x.url ] [ text x.name ] ]) model.links)
    -- ]


-- UPDATE
type Action 
  = NoOp
  | Increment
  | Modify Components.NewLink.Action
  | Submit

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Increment -> ( model, Effects.none )
    Modify a ->
      let ( newLink', _ ) = Components.NewLink.update a model.newLink
      in ( { model | newLink = newLink' }, Effects.none )
    Submit -> 
      let newModel = { model | links = model.links ++ [{ name = model.newLink.name, url = model.newLink.url }]}
      in ( newModel, Effects.none )
    -- Increment -> ( { links = model.links ++ [{ name = model.newLink.name, url = model.newLink.url}], newLink = model.newLink }, Effects.none )


-- CSS STYLES
styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
  
