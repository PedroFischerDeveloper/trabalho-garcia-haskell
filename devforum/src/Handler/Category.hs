{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Category where

import Import

getCategoryR :: Handler Html
getCategoryR = defaultLayout $ do
    [whamlet|
    <div>
        <h1>Forums</h1>
            <div>
                <ul>
                    <li>Forum
                        <li>Tópicos
                            <li>Posts
                                <li>Última Atividade
                                    <ul>
                                        <li>News & Announciments
                                            <li>2
                                                <li>4
                                                    <li> 8 21/11/2020

                                            


    
    |]



