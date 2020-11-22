{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Auth where

import Import


authForm :: Form User
authForm = renderDivs $ User
    <$> areq emailField "email" Nothing
    <*> areq textField "password" Nothing


getAuthR :: Handler Html
getAuthR = do
    (widget, _) <- generateFormPost authForm
    defaultLayout
        [whamlet|
            <form method=post action=@{AuthR}>
                ^{widget}
              
                <button>Submit
        |]

  

postAuthR :: Handler Html
postAuthR = do
    ((result, _), _) <- runFormPost authForm
    case result of
         FormSuccess user -> redirect HomeR
