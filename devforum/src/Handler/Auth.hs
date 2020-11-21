{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Auth where

import Import

getAuthR :: Handler Html
getAuthR = defaultLayout $ do
     [whamlet|
      <div>
            <h1>Login</h1>
                <form action="POST">
                    <input type="text" name="name" placeholder="insira seu nome" required/>
                        <p>Senha</p>
                            <input type="password" name="password" placeholder="insira sua senha" required/>
                
    |]

