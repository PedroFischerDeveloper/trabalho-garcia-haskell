{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    [whamlet|
        <h1>
            <a href=@{CategoriaR}>
                Criar Categoria
    |]

postHomeR :: Handler Html
postHomeR = undefined