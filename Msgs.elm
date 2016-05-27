module Msgs exposing (..)

import Types exposing (Repository)
import Http


type Msg
    = UpdateRepositoryName String
    | FetchGithubData
    | NewGithubData Repository
    | FetchGithubIssues
    | NewGithubIssues (List Types.Issue)
    | NoOp
