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
    <$> areq textField "user" Nothing
    <*> areq passwordField "password" Nothing


getAuthR :: Handler Html
getAuthR = do
    (widget, _) <- generateFormPost authForm
    defaultLayout
        [whamlet|
            <div .container>
                <div class="page-header">
                    <h1>Entrar
                <form method=post action=@{AuthR}>
                    ^{widget}
                   <button .btn .btn-primary .btn-block >Submit
        |]

  

postAuthR :: Handler Html
postAuthR = do
    ((result, _), _) <- runFormPost authForm
    case result of
         FormSuccess (User email password) -> do 
             user <- runDB $ getBy (UniqueName email)
             case user of 
                 Just (Entity _ (User _ dataBasePass)) -> do
                     if(password == dataBasePass) then do
                        setSession "_ID" email 
                        redirect HomeR
                     else do 
                        setMessage [shamlet|
                           <h1>
                               WRONG PASSWORD
                        |]
                        redirect AuthR
                 Nothing -> do 
                     setMessage [shamlet|
                           <h1>
                                USER NOT FOUND
                     |]
                     redirect AuthR
         _ -> redirect AuthR