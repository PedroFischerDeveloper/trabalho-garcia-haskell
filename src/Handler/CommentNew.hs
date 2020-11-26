{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}

module Handler.CommentNew where

import Import

data CommentRegular = CommentRegular { description :: Text }

commentForm :: Form CommentRegular
commentForm = renderDivs $ CommentRegular
  <$> areq textField  (FieldSettings "Comentario" Nothing Nothing Nothing [("class", "form-control")]) Nothing

getCommentNewR :: Key Post -> Handler Html
getCommentNewR postId = do
    (widget, _) <- generateFormPost $ commentForm
    defaultLayout $ do
        [whamlet|
            <div .container>
                <div class="page-header">
                    <a href=@{HomeR}>
                        Voltar
                    <h1>Criar comentário
                <form method=post action=@{CommentNewR postId}>
                    ^{widget}
                   <input type=submit .btn.btn-success.btn-block style="margin-top: 20px">
        |]

  

postCommentNewR :: Key Post -> Handler Html
postCommentNewR postId = do
    muser <- lookupSession "_ID"
    case muser of
        Just ident -> do
            muserdata <- runDB $ selectFirst [UserIdent ==. ident] []
            case muserdata of
                Just (Entity userId _) -> do
                    ((result, _), _) <- runFormPost $ commentForm
                    case result of
                        FormSuccess newComment -> do 
                            _ <- runDB $ insert400 (Comment (description newComment) postId userId)
                            redirect (CommentR postId) 
                        _ -> redirect HomeR
                Nothing -> redirect HomeR
        Nothing -> redirect HomeR
   