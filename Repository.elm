module Repository exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Json.Decode as JD exposing ((:=), Decoder)
import Http
import String
import Json.Decode.Extra exposing ((|:))
import Task
import Types exposing (Repository, Model)
import Msgs exposing (Msg(..))
import Issues
import Bootstrap exposing (container, row, column3, column6, btnDefault, column12, pageHeader)


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


getRepositoryData : String -> Cmd Msg
getRepositoryData userRepoString =
    Task.perform (always NoOp)
        NewGithubData
        (Http.get repositoryDecoder ("https://api.github.com/repos/" ++ userRepoString))


repositoryNameInput : Model -> Html Msg
repositoryNameInput model =
    Html.form []
        [ Bootstrap.formGroup
            [ input
                [ onInput UpdateRepositoryName
                , value model.input
                , class "form-control"
                ]
                []
            ]
        ]


view : Model -> Html Msg
view model =
    container
        [ row
            [ column6 [ h4 [] [ text "GitHub Issue Browser" ] ]
            , column3 [ (repositoryNameInput model) ]
            , column3
                [ btnDefault [ onClick FetchGithubData, disabled (String.isEmpty model.input) ]
                    [ text "Go!" ]
                ]
            ]
        , row
            [ column12
                [ pageHeader
                    [ h1 []
                        [ text model.repository.fullName
                        , small [] [ text model.repository.description ]
                        ]
                    ]
                ]
            ]
        , Issues.view model
        ]
