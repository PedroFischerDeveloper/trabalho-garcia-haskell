{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Home where

import Import
import Text.Lucius

getHomeR :: Handler Html
getHomeR = do 
    categorys <- runDB $ selectList [] [Desc CategoryId]    
    defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/home.lucius")
        $(whamletFile  "templates/home.hamlet")




  
