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
        <h1>
            Login de usuário
            
    |]

