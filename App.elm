module MyApp (..) where

import Html exposing (Html)
import Task exposing (Task)
import Effects exposing (Never, Effects)
import StartApp
import Types exposing (Model, Repository)
import Actions exposing (Action(..))
import Repository
import Issues
import GetAllRepositoryData


initialModel : Model
initialModel =
  { repository = Repository.nullRepository
  , input = "jackfranklin/gulp-load-plugins"
  , issues = []
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    UpdateRepositoryName string ->
      ( { model | input = string }, Effects.none )

    FetchGithubData ->
      ( model, Repository.getRepositoryData model.input )

    NewGithubData repository ->
      case repository of
        Ok repo ->
          ( { model | repository = repo }, Issues.getIssuesData model.input )

        Err err ->
          -- TODO: deal with errors
          ( model, Effects.none )

    FetchGithubIssues ->
      ( model, Issues.getIssuesData model.input )

    NewGithubIssues issues ->
      case issues of
        Ok list ->
          ( { model | issues = list }, Effects.none )

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
  Html.div
    []
    [ Repository.view address model ]


init : ( Model, Effects Action )
init =
  ( initialModel, GetAllRepositoryData.getRepositoryAndIssueData initialModel.input )


port tasks : Signal (Task Never ())
port tasks =
  app.tasks


main : Signal Html
main =
  app.html
