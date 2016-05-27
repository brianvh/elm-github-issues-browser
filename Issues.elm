module Issues exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Model, Issue)
import Msgs exposing (Msg(..))
import Json.Decode as JD exposing ((:=), Decoder)
import Json.Decode.Extra exposing ((|:))
import Task exposing (Task)
import List
import Bootstrap exposing (btnDefault, column12, row)
import Request
import HttpBuilder


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


getIssuesData : String -> Cmd Msg
getIssuesData userRepoString =
    Task.perform (always NoOp)
        (NewGithubIssues << .data)
        (httpRequest userRepoString)


httpRequest : String -> Task (HttpBuilder.Error String) (HttpBuilder.Response (List Issue))
httpRequest userRepoString =
    Request.gitHubRequest (userRepoString ++ "/issues") issuesDecoder


renderIssue : Issue -> Html Msg
renderIssue issue =
    row [ column12 [ h4 [] [ text issue.title ] ] ]


view : Model -> Html Msg
view model =
    div []
        (List.concat
            [ [ btnDefault [ onClick FetchGithubIssues ] [ text "Fetch issues" ] ]
            , List.map renderIssue model.issues
            ]
        )
