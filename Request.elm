module Request exposing (gitHubRequest)

import GitHubToken
import HttpBuilder exposing (..)
import Task exposing (Task)
import Json.Decode exposing (Decoder)


gitHubRequest : String -> Decoder a -> Task (Error String) (Response a)
gitHubRequest url successDecoder =
    get ("https://api.github.com/repos/" ++ url)
        |> withHeader "Content-Type" "application/json"
        |> withHeader "Authorization" GitHubToken.token
        |> send (jsonReader successDecoder) stringReader
