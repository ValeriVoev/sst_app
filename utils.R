get_hosp_table <- function(web_url){
	
	webpage <- xml2::read_html(webpage_url)
	tables <- rvest::html_table(webpage, header = TRUE)
	headers <- sapply(tables, function(x) x[1,1])	
	hosp_index = min(which(headers == "Stigning i forhold til dagen før"))
	hosp <- tables[[hosp_index]]
	hosp
}
