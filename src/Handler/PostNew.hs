{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}

module Handler.PostNew where

import Import

postForm :: [(Text, Key Category)] -> Form Post
postForm categories = renderDivs $ Post
  <$> areq textField "Título do post" Nothing
  <*> areq textField "Descrição do post" Nothing
  <*> areq (selectFieldList categories) "Categoria" Nothing

mapCategories :: [Entity Category] -> [(Text, Key Category)]
mapCategories [] = []
mapCategories xs = map (\(Entity eid (Category name _)) -> (name, eid)) xs

getPostNewR :: Handler Html
getPostNewR = do
    categories  <- runDB $ selectList [] [] 
    (widget, _) <- generateFormPost $ postForm $ mapCategories categories
    defaultLayout $ do
        [whamlet|
            <div .container>
                <div class="page-header">
                    <h1>Criar novo post
                <form method=post action=@{PostNewR}>
                    ^{widget}
                   <input type=submit .btn.btn-primary.btn-block>
        |]

  

postPostNewR :: Handler Html
postPostNewR = do
    categories <- runDB $ selectList [] [] 
    ((result, _), _) <- runFormPost $ postForm $ mapCategories categories
    case result of
         FormSuccess newpost -> do 
             _ <- runDB $ insert400 newpost
             redirect HomeR 
         _ -> redirect AuthR