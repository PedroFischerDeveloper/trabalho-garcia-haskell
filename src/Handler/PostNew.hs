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
  <$> areq textField (FieldSettings "Título do post" Nothing Nothing Nothing [("class", "form-control")]) Nothing
  <*> areq textField (FieldSettings "Descrição do post" Nothing Nothing Nothing [("class", "form-control")]) Nothing
  <*> areq (selectFieldList categories) (FieldSettings "Categoria" Nothing Nothing Nothing [("class", "form-control")]) Nothing

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
                    <a href=@{HomeR}>
                        Voltar
                    <h1>Criar novo post
                <form method=post action=@{PostNewR}>
                    ^{widget}
                   <input type=submit .btn.btn-success.btn-block style="margin-top: 20px">
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