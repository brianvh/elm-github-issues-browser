module Actions (..) where

import Types exposing (Repository)
import Http


type Action
  = UpdateRepositoryName String
  | FetchGithubData
  | NewGithubData (Result Http.Error Types.Repository)
  | FetchGithubIssues
  | NewGithubIssues (Result Http.Error (List Types.Issue))
