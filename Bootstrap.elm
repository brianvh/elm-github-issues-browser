module Bootstrap (..) where

import Html exposing (Html, Attribute, div, button)
import Html.Attributes exposing (class)


container : List Html -> Html
container contents =
  div [ class "container" ] contents


row : List Html -> Html
row contents =
  div [ class "row" ] contents


column : Int -> List Html -> Html
column width contents =
  div [ class ("col-md-" ++ (toString width)) ] contents


btn : String -> List Attribute -> List Html -> Html
btn className attributes contents =
  button (attributes ++ [ class ("btn " ++ className) ]) contents


btnDefault : List Attribute -> List Html -> Html
btnDefault =
  btn "btn-default"


column3 : List Html -> Html
column3 =
  column 3


column6 : List Html -> Html
column6 =
  column 6


column9 : List Html -> Html
column9 =
  column 9


column12 : List Html -> Html
column12 =
  column 12


formGroup : List Html -> Html
formGroup =
  div [ class "form-group" ]


pageHeader : List Html -> Html
pageHeader =
  div [ class "page-header" ]
