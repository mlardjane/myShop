{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Item where

import Import



getItemR :: ItemId -> Handler Html
getItemR itemId = do
	item <- runDB $ get404 itemId
	defaultLayout $ do
		$(widgetFile "item")