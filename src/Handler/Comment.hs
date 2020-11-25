{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Comment where

import Import
import Text.Lucius

getCommentR :: Key Post -> Handler Html
getCommentR postId = do 
    comments <- runDB $ selectList [CommentPost ==. postId] []
    defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/comment.lucius")
        $(whamletFile  "templates/comment.hamlet")




  