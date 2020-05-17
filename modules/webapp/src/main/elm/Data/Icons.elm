module Data.Icons exposing
    ( concerned
    , concernedIcon
    , correspondent
    , correspondentIcon
    , dueDate
    , dueDateIcon
    )

import Html exposing (Html, i)
import Html.Attributes exposing (class)


concerned : String
concerned =
    "crosshairs icon"


concernedIcon : Html msg
concernedIcon =
    i [ class concerned ] []


correspondent : String
correspondent =
    "address card outline icon"


correspondentIcon : Html msg
correspondentIcon =
    i [ class correspondent ] []


dueDate : String
dueDate =
    "bell icon"


dueDateIcon : Html msg
dueDateIcon =
    i [ class dueDate ] []
