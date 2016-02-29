module Issues (..) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Model, Issue)
import Actions exposing (Action(..))
import Json.Decode as JD exposing ((:=), Decoder)
import Http
import Json.Decode.Extra exposing ((|:))
import Effects exposing (Effects)
import Task
import List


nullIssue : Issue
nullIssue =
  { title = ""
  , createdAt = ""
  }


issueDecoder : Decoder Issue
issueDecoder =
  JD.succeed Issue
    |: ("title" := JD.string)
    |: ("created_at" := JD.string)


issuesDecoder : Decoder (List Issue)
issuesDecoder =
  JD.list issueDecoder


getIssuesData : String -> Effects Action
getIssuesData userRepoString =
  Http.get issuesDecoder ("https://api.github.com/repos/" ++ userRepoString ++ "/issues")
    |> Task.toResult
    |> Task.map NewGithubIssues
    |> Effects.task


renderIssue : Issue -> Html
renderIssue issue =
  div [] [ text issue.title ]


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    (List.concat
      [ [ button [ onClick address FetchGithubIssues ] [ text "Fetch issues" ] ]
      , List.map
          renderIssue
          model.issues
      ]
    )
