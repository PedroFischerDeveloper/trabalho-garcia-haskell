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
        <h1>
            Cadastro de usuário
            
    |]

