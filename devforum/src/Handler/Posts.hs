{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Posts where

import Import

getPostsR :: Handler Html
getPostsR = defaultLayout $ do
    [whamlet|
        <h1>
            Novo Post

            
    |]



