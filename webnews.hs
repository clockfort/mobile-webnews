-- For Scotty
{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Network.Wai.Handler.Warp (defaultSettings, settingsPort, settingsHost, HostPreference (HostIPv4))
-- For Me
import Control.Monad.Trans (liftIO)
import Data.Text.Lazy (pack, unpack)
-- Project-Internal
-- TODO: Hookup internal modules

listenPort = 3000 -- Might need to change this later, depending on what's free on CSH's webserver's loopback
waiSettings = defaultSettings { settingsPort = fromInteger listenPort, settingsHost = HostIPv4 }
opts = Options {verbose = 1, settings = waiSettings} -- Glad I got xich to put this in scotty :-)

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
