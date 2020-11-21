{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Categoria where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

formCategoria :: Form Categoria
formCategoria = renderBootstrap3 BootstrapBasicForm $ Categoria
    <$> areq textField "descricao: " Nothing

getCategoriaR :: Handler Html
getCategoriaR = do
    (formWidget, _) <- generateFormPost formCategoria
    defaultLayout $ do [whamlet|
        <form action=@{CategoriaR} method=post>
            ^{formWidget}
            <input type="submit" value="Salvar">
    |]

postCategoriaR :: Handler Html
postCategoriaR = do
    ((result, _), _) <- runFormPost formCategoria
    case result of
         FormSuccess categoria -> do 
            pid <- runDB $ insert categoria
            redirect (DescR pid)
         _ -> redirect HomeR


getDescR :: CategoriaId -> Handler Html
getDescR pid = do 
    categoria <- runDB $ get404 pid
    defaultLayout $ do 
        [whamlet|
                <ul>
                    <li> Descicao: #{categoriaDescricao categoria}
        |]