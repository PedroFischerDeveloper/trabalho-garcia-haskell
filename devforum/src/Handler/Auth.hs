{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Auth where

import Import
import Text.Lucius

authForm :: Form User
authForm = renderDivs $ User
    <$> areq emailField "email" Nothing
    <*> areq textField "password" Nothing


getAuthR :: Handler Html
getAuthR = 
    defaultLayout $ do
        toWidgetHead $(luciusFile  "templates/auth.lucius")
        $(whamletFile  "templates/auth.hamlet")

postAuthR :: Handler Html
postAuthR = do
    ((result, _), _) <- runFormPost authForm
    case result of
         FormSuccess user -> redirect HomeR
