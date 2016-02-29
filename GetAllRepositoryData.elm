module GetAllRepositoryData (..) where

import Repository
import Issues
import Effects exposing (Effects)
import Actions exposing (Action)


getRepositoryAndIssueData : String -> Effects Action
getRepositoryAndIssueData input =
  [ Repository.getRepositoryData input
  , Issues.getIssuesData input
  ]
    |> Effects.batch
