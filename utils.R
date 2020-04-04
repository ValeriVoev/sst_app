get_hosp_table <- function(web_url){
	
	webpage <- xml2::read_html(webpage_url)
	tables <- rvest::html_table(webpage, header = TRUE)
	headers <- sapply(tables, function(x) x[1,1])	
	hosp_index = min(which(headers == "Stigning i forhold til dagen før"))
	hosp <- tables[[hosp_index]]
	intens <- tables[[hosp_index+1]]
	resp <- tables[[hosp_index+2]]
	return(list(hosp=hosp, intens = intens, resp = resp))
}

elong_table <- function(table){
	
	table <-table[-1,]
	table[2:dim(table)[2]] <- sapply(table[2:dim(table)[2]],as.numeric)
	
	colnames(table) <- gsub(" ", "_",  colnames(table))
	colnames(table)[1] <- "Date"
	
	table <- table %>% purrr::map_df(rev)
	
	table <- table %>% 
		mutate_if(is.numeric, list(growth = ~(. - lag(.)), r_growth = ~(. - lag(.))/lag(.)  ) )
	
	proper_dates <- seq(as.Date("2020-03-16"), as.Date("2020-03-16") + (nrow(table) - 1), by = "day")
	table$Date <- proper_dates
	
	table_long <- table %>% 
		tidyr::pivot_longer(cols = -Date)
	
	return(table_long)
	
}