{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Category where

import Import
import Text.Lucius

getCategorysR :: Handler Html
getCategorysR = do 
    categorys <- runDB $ selectList [] [Desc CategoryId]
    defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/category.lucius")
        $(whamletFile  "templates/category.hamlet")




  