module MyApp exposing (..)

import Html exposing (Html)
import Html.App as Html
import Types exposing (Model, Repository)
import Msgs exposing (Msg(..))
import Repository
import Issues
import GetAllRepositoryData


initialModel : Model
initialModel =
    { repository = Repository.nullRepository
    , input = "jackfranklin/gulp-load-plugins"
    , issues = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateRepositoryName string ->
            ( { model | input = string }, Cmd.none )

        FetchGithubData ->
            ( model, Repository.getRepositoryData model.input )

        NewGithubData repo ->
            ( { model | repository = repo }, Issues.getIssuesData model.input )

        FetchGithubIssues ->
            ( model, Issues.getIssuesData model.input )

        NewGithubIssues issues ->
            ( { model | issues = issues }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Repository.view model ]


init : ( Model, Cmd Msg )
init =
    ( initialModel, GetAllRepositoryData.getRepositoryAndIssueData initialModel.input )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
