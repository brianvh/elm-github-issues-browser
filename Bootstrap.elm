module Bootstrap exposing (..)

import Html exposing (Html, Attribute, div, button)
import Msgs exposing (Msg)
import Html.Attributes exposing (class)


container : List (Html Msg) -> Html Msg
container contents =
    div [ class "container" ] contents


row : List (Html Msg) -> Html Msg
row contents =
    div [ class "row" ] contents


column : Int -> List (Html Msg) -> Html Msg
column width contents =
    div [ class ("col-md-" ++ (toString width)) ] contents


btn : String -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
btn className attributes contents =
    button (attributes ++ [ class ("btn " ++ className) ]) contents


btnDefault : List (Attribute Msg) -> List (Html Msg) -> Html Msg
btnDefault =
    btn "btn-default"


column3 : List (Html Msg) -> Html Msg
column3 =
    column 3


column6 : List (Html Msg) -> Html Msg
column6 =
    column 6


column9 : List (Html Msg) -> Html Msg
column9 =
    column 9


column12 : List (Html Msg) -> Html Msg
column12 =
    column 12


formGroup : List (Html Msg) -> Html Msg
formGroup =
    div [ class "form-group" ]


pageHeader : List (Html Msg) -> Html Msg
pageHeader =
    div [ class "page-header" ]
