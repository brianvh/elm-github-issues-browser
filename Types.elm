module Types (..) where


type alias Model =
  { repository : Repository
  , input : String
  , issues : List Issue
  }


type alias Repository =
  { fullName : String
  , description : String
  }


type alias Issue =
  { title : String
  , createdAt : String
  }
