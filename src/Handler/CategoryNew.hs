{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.CategoryNew where

import Import
import Text.Lucius

categoryForm :: Form Category
categoryForm = renderDivs $ Category
    <$> areq textField  "title" Nothing

getTopicNewR :: Handler Html
getTopicNewR = do
    (widget, _) <- generateFormPost categoryForm
    defaultLayout
        [whamlet|
            <div .container>
                <div class="page-header">
                    <h1>Criar Post
                <form method=post action=@{TopicNewR}>
                    ^{widget}
                   <button .btn .btn-primary .btn-block >Criar Post
        |]

  

postTopicNewR :: Handler Html
postTopicNewR = do
    ((result, _), _) <- runFormPost categoryForm
    case result of
         FormSuccess category -> do
             runDB $ insert category
             redirect HomeR
         _ -> redirect TopicNewR

