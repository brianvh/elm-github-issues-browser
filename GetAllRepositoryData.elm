module GetAllRepositoryData exposing (..)

import Repository
import Issues
import Msgs exposing (Msg)


getRepositoryAndIssueData : String -> Cmd Msg
getRepositoryAndIssueData input =
    [ Repository.getRepositoryData input
    , Issues.getIssuesData input
    ]
        |> Cmd.batch
