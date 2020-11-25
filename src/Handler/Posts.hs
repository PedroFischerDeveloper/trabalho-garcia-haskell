{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Posts where

import Import
import Text.Lucius

getPostsR :: Key Category -> Handler Html
getPostsR categoryid = do
    posts <- runDB $ selectList [PostCategoryId ==. categoryid] []
    defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/posts.lucius")
        $(whamletFile  "templates/posts.hamlet")
