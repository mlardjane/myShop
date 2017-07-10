{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Newshop where

import Import
import Yesod.Form.Bootstrap3


-- data Shop = Shop
-- 	{ name :Text
-- 	, descrption :: Text
-- 	}


newshopForm :: AForm Handler Shop
newshopForm = Shop
		   <$> areq textField (bfs ("Name" :: Text)) Nothing
		   <*> areq textField (bfs ("Description"::Text)) Nothing

getNewshopR :: Handler Html
getNewshopR = do
	  (widget,enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm newshopForm
	  defaultLayout $ do 
	  	 $(widgetFile "newshop")


postNewshopR:: Handler Html
postNewshopR = do
	((result,widget),enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm newshopForm
	case result of
		FormSuccess newShop -> do
			newShopId <- runDB $ insert newShop
			redirect $ ShopR newShopId
		_ -> defaultLayout $(widgetFile "newshop")
