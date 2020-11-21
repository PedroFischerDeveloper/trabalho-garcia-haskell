{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Register where

import Import

getRegisterR :: Handler Html
getRegisterR = defaultLayout $ do
    [whamlet|
        <form action="POST">
            <p>Nome</p>
                <input type="text" placeholder="insira seu nome" required/>
                    <p>Senha</p>
                        <input type="password" placeholder="insira sua senha" required/>
            
    |]

postRegisterR :: Handler Html
postRegisterR = defaultLayout $ do
    [whamlet|
        <h1>
            Cadastro de usuário
            
    |]

