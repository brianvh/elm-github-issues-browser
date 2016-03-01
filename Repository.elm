module Repository (..) where

import Html exposing (..)
import Html.Events exposing (onClick, on, targetValue)
import Html.Attributes exposing (..)
import Json.Decode as JD exposing ((:=), Decoder)
import Http
import String
import Json.Decode.Extra exposing ((|:))
import Effects exposing (Effects)
import Task
import Types exposing (Repository, Model)
import Actions exposing (Action(..))
import Issues


nullRepository : Repository
nullRepository =
  { fullName = "Loading..."
  , description = ""
  }


repositoryDecoder : Decoder Repository
repositoryDecoder =
  JD.succeed Repository
    |: ("full_name" := JD.string)
    |: ("description" := JD.string)


getRepositoryData : String -> Effects Action
getRepositoryData userRepoString =
  Http.get repositoryDecoder ("https://api.github.com/repos/" ++ userRepoString)
    |> Task.toResult
    |> Task.map NewGithubData
    |> Effects.task


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ button [ onClick address FetchGithubData, disabled (String.isEmpty model.input) ] [ text "Go!" ]
    , input [ on "input" targetValue (\str -> Signal.message address (UpdateRepositoryName str)), value model.input ] []
    , div [] [ text model.repository.fullName ]
    , div [] [ text model.repository.description ]
    , Issues.view address model
    ]
