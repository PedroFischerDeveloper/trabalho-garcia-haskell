{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Register where

import Import
import Text.Lucius

registerForm :: Form User
registerForm = renderDivs $ User
    <$> areq textField  "email" Nothing
    <*> areq passwordField "password" Nothing


getRegisterR :: Handler Html
getRegisterR = do
    (widget, _) <- generateFormPost registerForm
    defaultLayout
        [whamlet|
            <form method=post action=@{RegisterR}>
                ^{widget}
              
                <button>Submit
        |]

  

postRegisterR :: Handler Html
postRegisterR = do
    ((result, _), _) <- runFormPost registerForm
    case result of
         FormSuccess user -> do
             runDB $ insert user
             redirect HomeR
         _ -> redirect RegisterR

