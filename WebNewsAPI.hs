{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module WebNewsAPI where
	import Network.Curl
	import Data.String.Utils --MissingH
	import Network.HTTP
	import Data.Aeson (decode, encode)
	import Data.Aeson.TH (deriveJSON)
	import qualified Data.ByteString.Lazy.Char8 as BL (pack, unpack)
	import WebNewsAPITypes
	import Data.Maybe (Maybe, fromJust)
	import Control.Monad.Trans (liftIO)

	opts = [CurlHttpHeaders ["Accept: application/json"]]
	baseURL = "https://webnews-dev.csh.rit.edu/" --Temporary, production environment doesn't have API access yet

	loginEncapsulation url apiKey = baseURL ++ url ++ parameterize [("api_key", apiKey), ("api_agent", "Clockfort's Mobile WebNews")]

	-- queryList should look like [ (param1, value1), (param2, value2) ]
	parameterize queryList = '?' : join "&" ( map (\ x -> concat[fst x, "=", urlEncode (snd x)]) queryList )
	
	$(deriveJSON id ''Preferences)
	$(deriveJSON id ''UserObj)
	$(deriveJSON id ''User)
	$(deriveJSON id ''Unread)
	$(deriveJSON id ''UnreadCounts)
	$(deriveJSON id ''Newsgroup)
	$(deriveJSON id ''Newsgroups)
	getJSON url apiKey = withCurlDo $ do
		curl <- initialize
		setopts curl opts
		response <- do_curl_ curl (loginEncapsulation url apiKey) method_GET :: IO CurlResponse
		let json = respBody response
		return json

	getUnread apiKey = do
		json <- getJSON "unread_counts" apiKey
		let req = decode (BL.pack json) :: Maybe Unread
		return req
	
	getUser apiKey = do
		json <- getJSON "user" apiKey
		let req = decode (BL.pack json) :: Maybe User
		return req

	getPreferences apiKey = do
		json <- getJSON "preferences" apiKey
		let req = decode (BL.pack json) :: Maybe Preferences
		return req

	getNewsgroups apiKey = do
		json <- getJSON "newsgroups" apiKey
		let req = decode (BL.pack json) :: Maybe Newsgroups
		return req

	
