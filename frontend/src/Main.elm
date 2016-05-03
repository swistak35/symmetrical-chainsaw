import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick, targetValue, on )
import Effects exposing (Effects)
import String

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
  , tags : List String
  }

emptyLink = { name = "", url = "", tags = [] }

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
    [ viewNavbar address model
    , div [ class "row" ]
      [ div [ class "col s6" ]
        [ viewNewLink address model.newLink
        ]
      ]
    , div [ class "row" ]
      [ ul [ class "collection" ] (List.map (viewLink address) model.links)
      ]
    ]

viewNavbar address model =
  nav [] [
    div [ class "nav-wrapper" ]
      [ a [ href "#", class "brand-logo right" ] [ text "Symmetrical Chainsaw" ]
      , ul [ id "nav-mobile", class "left hide-on-med-and-down"]
        [ li [] [ a [ href "#/links" ] [ text "Links" ] ]
        , li [] [ a [ href "#/"      ] [ text "Other" ] ]
        ]
      ]
    ]

viewLink address link =
  li [ class "collection-item avatar" ]
    [ i [ class "material-icons circle" ] [ text "folder" ]
    -- [ img [ src "images/default.png", alt "", class "circle" ] []
    -- , span [ class "title" ] [ text "Title" ]
    , a [ class "title", href link.url ] [ text link.name ]
    , p []
      [ text "Short description of the link"
      , br [] []
      , text (String.append "tags: " (String.join ", " link.tags))
      , br [] []
      , text link.url
      ]
    , div [ class "secondary-content", style [("text-align", "right")] ]
      [ a [ href "#!/grade"  ] [ i [ class "material-icons" ] [ text "grade"  ] ]
      , a [ href "#!/edit"   ] [ i [ class "material-icons" ] [ text "edit"   ] ]
      , a [ href "#!/delete" ] [ i [ class "material-icons" ] [ text "delete" ] ]
      , br [] []
      , text "2016.04.02, 13:15"
      ]
    ]




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
      let newModel = { model | links = model.links ++ [{ name = model.newLink.name, url = model.newLink.url, tags = model.newLink.tags }]}
      in ( newModel, Effects.none )
