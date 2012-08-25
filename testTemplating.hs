import Data.Maybe
import Text.Html
import Text.StringTemplate

main = do newsgroupsFile <- readFile "newsgroups.template.html"
	  headerFile <- readFile "header.template.html"
	  let newsgroups = newSTMP newsgroupsFile :: StringTemplate String
	  let header = newSTMP headerFile :: StringTemplate String
	  let group = groupStringTemplates [("newsgroups", newsgroups),("header", header)]
	  --setEncoderGroup stringToHtmlString group 
	  putStrLn $ toString $ fromJust $ getStringTemplate "newsgroups" group
