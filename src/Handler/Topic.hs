{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Topic where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)


data NewCategory = NewCategory {
    newTitle                :: Text
}

formCategory :: Form NewCategory
formCategory = renderBootstrap3 BootstrapBasicForm $ NewCategory
    <$> areq textField (FieldSettings "Título" Nothing Nothing Nothing [("class", "form-control")]) Nothing

getTopicR :: Handler Html
getTopicR = do
    msg <- getMessage
    (widget, _) <- generateFormPost formCategory
    muser <- lookupSession "_ID"
    case muser of
        Just ident -> do
            muserdata <- runDB $ selectFirst [UserIdent ==. ident] []
            case muserdata of
                Just (Entity _ (User name _)) -> do
                    defaultLayout $ do
                        setTitle "Cadastrar novo Tópico"
                        $(widgetFile "topicnew")
                Nothing -> redirect HomeR
        Nothing -> redirect HomeR

postTopicR :: Handler Html
postTopicR = do
    ((result, _), _) <- runFormPost formCategory
    case result of
        FormSuccess (NewCategory title) -> do
            muser <- lookupSession "_ID"
            case muser of
                Just ident -> do
                    muserdata <- runDB $ selectFirst [UserIdent ==. ident] []
                    case muserdata of
                        Just (Entity catid _) -> do
                            _ <- runDB $ insert400 (Category title catid)
                            redirect HomeR
                        Nothing -> redirect HomeR
                Nothing -> redirect HomeR
        _ -> redirect TopicR
-- do
-- ((result, _), _) <- runFormPost formCategory
-- case result of
--     FormSuccess category -> do
--         case category of
--             Just _ -> redirect TopicNewR
--             Nothing -> do
--                 _ <- runDB $ insert400 (Book (newBookName book) (newBookISBN book) (newBookNumberPages book) (newBookCategory book))
--                 redirect HomeR
--     _ -> redirect TopicNewR
    
-- do
-- ((result, _), _) <- runFormPost formCategory
-- case result of
--     FormSuccess category -> do
--         case category of
--             Just _ -> redirect TopicNewR
--             Nothing -> do
--                 _ <- runDB $ insert400 (Book (newBookName book) (newBookISBN book) (newBookNumberPages book) (newBookCategory book))
--                 redirect HomeR
--     _ -> redirect TopicNewR
    
