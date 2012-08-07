{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module WebNewsAPI where
	import Network.Curl
	import Data.String.Utils --MissingH
	import Network.HTTP
	import Data.Aeson (decode, encode)
	import Data.Aeson.TH (deriveJSON)
	import qualified Data.ByteString.Lazy.Char8 as BL

	opts = [CurlHttpHeaders ["Accept: application/json"]]
	baseURL = "https://webnews-dev.csh.rit.edu/" --Temporary, production environment doesn't have API access yet

	loginEncapsulation url apiKey = baseURL ++ url ++ parameterize [("api_key", apiKey), ("api_agent", "Clockfort's Mobile WebNews")]

	-- queryList should look like [ (param1, value1), (param2, value2) ]
	parameterize queryList = '?' : join "&" ( map (\ x -> concat[fst x, "=", urlEncode (snd x)]) queryList )

	
	get url apiKey = withCurlDo $ do
		curl <- initialize
		setopts curl opts
		response <- do_curl_ curl (loginEncapsulation url apiKey) method_GET :: IO CurlResponse
		return $ respBody response
