-- Grant's GitHub wiki page ( https://github.com/grantovich/CSH-WebNews/wiki/API )
-- is the canonical source for all WebNews returned-JSON-data API information.
-- The API is not currently versioned, so please refer to there in case of any breaking changes.
module WebNewsAPITypes where
	data User = User
		{ 
			username :: String,
			real_name :: String,
			created_at :: String,
			updated_at :: String,
			preferences :: Preferences
		}
		deriving(Show)
	
	data Preferences = Preferences
		{
			thread_mode :: String,
			time_zone :: String
		}
		deriving(Show)

	data Unread = Unread
		{
			unread_counts :: UnreadCounts
		}
		deriving(Show)

	data UnreadCounts = UnreadCounts
		{
			normal :: Integer,
			in_thread :: Integer,
			in_reply :: Integer
		}
		deriving(Show)

	data Newsgroup = Newsgroup
		{
			name :: String,
			status :: Char,
			unread_count :: Integer,
			unread_class :: String
		}

	data Newsgroups = Newsgroups
		{
			newsgroups :: [Newsgroup]
		}
	--TODO: Implement all WebNews-provided data structures. Mostly POST-ones missing.
