{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.HomeEdit where

import Import

getHomeEditR :: Key Posts Handler Html
getHomeEditR postid = do    
    post <- runDB $ get404 postid
     defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/home.lucius")
        $(whamletFile  "templates/home.hamlet")


        
