module Types (..) where


type alias Model =
  { repository : Repository
  , input : String
  }


type alias Repository =
  { fullName : String
  , description : String
  }
