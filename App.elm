module MyApp exposing (..)

import Html exposing (Html)
import Types exposing (Model, Repository)
import Msgs exposing (Msg(..))
import Repository
import Issues
import GetAllRepositoryData
import Navigation
import String


-- URL PARSING


toUrl : Model -> String
toUrl model =
    "#/" ++ model.input


fromUrl : String -> String
fromUrl url =
    String.dropLeft 2 url


urlParser : Navigation.Parser String
urlParser =
    Navigation.makeParser (fromUrl << .hash)



-- MODEL AND UPDATE


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
            let
                newModel =
                    { model | input = string }
            in
                ( newModel, Navigation.newUrl (toUrl newModel) )

        FetchGithubData ->
            ( model, Repository.getRepositoryData model.input )

        NewGithubData repo ->
            ( { model | repository = repo }, Issues.getIssuesData model.input )

        FetchGithubIssues ->
            ( model, Issues.getIssuesData model.input )

        NewGithubIssues issues ->
            ( { model | issues = issues }, Cmd.none )


urlUpdate : String -> Model -> ( Model, Cmd Msg )
urlUpdate newInput model =
    ( { model | input = newInput }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Repository.view model ]


init : String -> ( Model, Cmd Msg )
init url =
    ( { initialModel | input = url }, GetAllRepositoryData.getRepositoryAndIssueData url )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , urlUpdate = urlUpdate
        }
