{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Posts where

import Import

getPostsR :: Handler Html
getPostsR = defaultLayout $ do
    [whamlet|
    <div>
        <h1>Novo Post</h1>
            <form action="POST">
                <label>Título</label>
                    <input type="text" name="title" placeholder="Título" pattern="[a-zA-Z0-9]+" required/>
                        <p>Descrição</p>
                            <textarea type="text" name="description" pattern="[a-zA-Z0-9]+" rows="5" cols="50"></textarea>

    
    |]



