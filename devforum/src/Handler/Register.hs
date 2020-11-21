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
        <div>
            <h1>Cadastro</h1>
                <form action="POST">
                    <input type="text" name="name" placeholder="insira seu nome" required/>
                        <p>Senha</p>
                            <input type="password" name="password" placeholder="insira sua senha" required/>
            
    |]

postRegisterR :: Handler Html
postRegisterR = defaultLayout $ do
    [whamlet|
        <h1>
            Cadastro de usuário
            
    |]

