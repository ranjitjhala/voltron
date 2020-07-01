{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Types where

import           Data.Aeson
import           Data.Text                      ( Text(..) )
import           GHC.Generics
import Model
import JSON

data Buffer = Buffer
  { bufferId   :: GroupId
  , bufferHash :: Text
  , bufferText :: Text
  }
  deriving (Show, Generic)

instance ToJSON Buffer where
  toEncoding = genericToEncoding (stripPrefix "buffer")

data UserNG = UserNG 
  { userFirstName :: Text
  , userLastName  :: Text
  }
  deriving Generic

instance ToJSON UserNG where
  toEncoding = genericToEncoding (stripPrefix "user")

data ClassData 
  = Student 
     { classClass     :: Text
     , classGrpBuffer :: Buffer
     }
  | Instructor 
     { classClass      :: Text 
     , classAllBuffers :: [Buffer]
     }
  deriving Generic

instance ToJSON ClassData where
  toEncoding = genericToEncoding (stripPrefix "class")

data UserData = UserData 
  { userUser    :: UserNG 
  , userClasses :: [ClassData]
  }
  deriving Generic

instance ToJSON UserData where
  toEncoding = genericToEncoding (stripPrefix "user")

data LoginResponse = LoginResponse
  { respAccessToken :: String
  , respUser        :: UserData
  }
  deriving Generic
    
instance ToJSON LoginResponse where
  toEncoding = genericToEncoding (stripPrefix "resp")

