import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)

-- official 'Elm Architecture' package
-- https://github.com/evancz/start-app
import StartApp

-- component import example
import Components.Hello exposing ( hello )

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
  , newLink : Link
  }

type alias Link =
  { name : String
  , url : String
  }

emptyLink = { name = "", url = "" }

-- INIT
init =
  ({ links = [], newLink = emptyLink }, Effects.none)

-- VIEW
-- Examples of:
-- 1)  an externally defined component ('hello', takes 'model' as arg)
-- 2a) styling through CSS classes (external stylesheet)
-- 2b) styling using inline style attribute (two variants)
view address model =
  div
    [ class "mt-palette-accent", style styles.wrapper ]
    [ hello (List.length model.links)
    ,  p [ style [( "color", "#FFF")] ] [ text ( "Elm Webpack Starter" ) ]
    ,  input [ value model.newLink.name, on "input" targetValue (Signal.message address << UpdateName), style [("color", "#000")] ] []
    ,  button [ class "mt-button-sm", onClick address Increment ] [ text "FTW!" ]
    ,  img [ src "img/elm.jpg", style [( "display", "block"), ( "margin", "10px auto")] ] []
    ,  ul [] (List.map (\x -> li [] [ a [ href x.url ] [ text x.name ] ]) model.links)
    ]


-- UPDATE
type Action 
  = NoOp
  | Increment
  | UpdateName String

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Increment -> ( { links = model.links ++ [{ name = model.newLink.name, url = "bar"}], newLink = model.newLink }, Effects.none )
    UpdateName newName -> 
      let newLink' = model.newLink
      in ( { model | newLink = { newLink' | name = newName }}, Effects.none)


-- CSS STYLES
styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
  
