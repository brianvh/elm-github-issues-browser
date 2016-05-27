module Msgs exposing (..)

import Types exposing (Repository)


type Msg
    = UpdateRepositoryName String
    | FetchGithubData
    | NewGithubData Repository
    | FetchGithubIssues
    | NewGithubIssues (List Types.Issue)
    | NoOp
