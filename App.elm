module MyApp (..) where

import Html exposing (..)
import Html.Events exposing (onClick, on, targetValue)
import Html.Attributes exposing (..)
import Task exposing (Task)
import Effects exposing (Never, Effects)
import String
import StartApp
import Types exposing (Model, Repository)
import Actions exposing (Action(..))
import Repository


initialModel : Model
initialModel =
  { repository = Repository.nullRepository
  , input = "jackfranklin/dotfiles"
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    UpdateRepositoryName string ->
      ( model, Effects.none )

    FetchGithubData ->
      ( model, Repository.getRepositoryData model.input )

    NewGithubData repository ->
      case repository of
        Ok repo ->
          ( { model | repository = repo }, Effects.none )

        Err err ->
          -- TODO: deal with errors
          ( model, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ Repository.view address model ]


init : ( Model, Effects Action )
init =
  ( initialModel, Repository.getRepositoryData initialModel.input )


port tasks : Signal (Task Never ())
port tasks =
  app.tasks


main : Signal Html
main =
  app.html
