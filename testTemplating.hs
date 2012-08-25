import Data.Maybe
import Text.Html
import Text.StringTemplate

main = renderNewsgroupIndex

renderNewsgroupIndex = do
	newsgroupsFile <- readFile "templates/newsgroups.template.html"
	headerFile <- readFile "templates/header.template.html"
	let newsgroups = newSTMP newsgroupsFile :: StringTemplate String
	let header = newSTMP headerFile :: StringTemplate String
	let group = groupStringTemplates [("newsgroups", newsgroups),("header", header)]
	--setEncoderGroup stringToHtmlString group 
	putStrLn $ toString $ fromJust $ getStringTemplate "newsgroups" group

