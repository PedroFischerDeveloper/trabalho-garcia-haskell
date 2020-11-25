{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Register where

import Import
import Text.Lucius
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

registerForm :: Form User
registerForm = renderBootstrap3 BootstrapBasicForm $ User
    <$> areq textField  (FieldSettings "Usuário" Nothing Nothing Nothing [("class", "form-control")]) Nothing
    <*> areq passwordField (FieldSettings "Senha" Nothing Nothing Nothing [("class", "form-control")]) Nothing


getRegisterR :: Handler Html
getRegisterR = do
    (widget, _) <- generateFormPost registerForm
    defaultLayout
        [whamlet|
            <div .container>
                <div class="page-header">
                    <h1>Cadastre-se
                <form method=post action=@{RegisterR}>
                    ^{widget}
                   <button .btn .btn-primary .btn-block >Register
        |]

  

postRegisterR :: Handler Html
postRegisterR = do
    ((result, _), _) <- runFormPost registerForm
    case result of
         FormSuccess user -> do
             runDB $ insert user
             redirect HomeR
         _ -> redirect RegisterR

