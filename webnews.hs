-- For Scotty
{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty

-- For Me
import Control.Monad.Trans
import Data.Text.Lazy

-- Project-Internal
-- TODO: Hookup internal modules

import Network.Wai.Handler.Warp

listenPort = 3000 -- Might need to change this later, depending on what's free on CSH's webserver's loopback
waiSettings = defaultSettings { settingsPort = (fromInteger listenPort), settingsHost = HostIPv4 }
opts = Options {verbose = 1, settings = waiSettings}

main = scottyOpts opts $ do
	get "/" $ text "200: OK, Content not written yet"
	
--	TODO: Actually write these functions. This is just brainstorming.	
--	get "/newsgroups/:newsgroup" $ do
--		newsgroup <- param "newsgroup"
--		posts <- liftIO $ getPostsFromNewsgroup $ unpack newsgroup
--		html $ pack $ renderNewsgroupPage newsgroup posts
		
	get "/content/:handle" $ do
		handle <- param "handle"
		file $ "content/" ++ unpack handle

	get "/themes/:handle" $ do
		handle <- param "handle"
		file $ "themes/" ++ unpack handle
