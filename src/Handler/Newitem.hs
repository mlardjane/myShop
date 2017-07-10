{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Newitem where

import Import
import Yesod.Form.Bootstrap3



newItemForm :: AForm Handler Item
newItemForm = Item
	<$> areq textField (bfs ("Name" :: Text)) Nothing
	<*> areq textField (bfs ("description" :: Text)) Nothing
	<*> areq textField (bfs ("Price" :: Text)) Nothing
	

getNewitemR :: Handler Html
getNewitemR = do
	(widget,enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm newItemForm
	defaultLayout $ do
		$(widgetFile "newitem")


postNewitemR:: Handler Html
postNewitemR = do
	((result,widget),enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm newItemForm
	case result of
		FormSuccess newItem -> do
			newItemId <- runDB $ insert newItem
			redirect $ ItemR newItemId
		_ -> defaultLayout $(widgetFile "newitem")

