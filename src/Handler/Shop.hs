{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Shop where

import Import



getShopR :: ShopId -> Handler Html
getShopR shopId = do
	shop <- runDB $ get404 shopId
	defaultLayout $ do
		$(widgetFile "shop")

