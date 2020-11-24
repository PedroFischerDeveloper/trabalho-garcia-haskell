{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.HomeDelete where

import Import

deleteHomeDeleteR :: PostsId -> Handler Html
deleteHomeDeleteR pid = do 
    runDB $ delete pid
    redirect HomeR
