module DateFormat exposing (..)

import Date
import Date.Format exposing (format)


niceFormat : String
niceFormat =
    "%d %B %Y"


niceDate : Date.Date -> String
niceDate =
    format niceFormat


fromString : String -> String
fromString dateString =
    case Date.fromString dateString of
        Ok date ->
            niceDate date

        Err err ->
            "Erorr parsing date"
