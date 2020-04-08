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

prepare_table <- function(table){
	
	table <- lapply(table, function(x) gsub("✱", "", x)) %>% as_tibble(.name_repair = "minimal")
	print("prepare_table_step1")
	table <- table[-1,]
	table[2:dim(table)[2]] <- sapply(table[2:dim(table)[2]],as.numeric)
	print("prepare_table_step2")
	colnames(table) <- gsub(" ", "_",  colnames(table))
	colnames(table)[1] <- "Date"
	print("prepare_table_step3")
	table <- table %>% purrr::map_df(rev)
	print("prepare_table_step4")
	table <- table %>% 
		mutate_if(is.numeric, list(growth = ~(. - dplyr::lag(.)), r_growth = ~(. - dplyr::lag(.))/dplyr::lag(.)  ) )
	print("prepare_table_step5")
	proper_dates <- seq(as.Date("2020-03-16"), as.Date("2020-03-16") + (nrow(table) - 1), by = "day")
	table$Date <- proper_dates
	
	return(table)
}

elong_table <- function(table){
	
	table_long <- table %>% 
		tidyr::pivot_longer(cols = -Date)
	
	return(table_long)
	
}

plotList <- function(regs) {
	lapply(regs, function(reg) {
		
		reg_colname_hosp <- paste0(gsub(" ", "_", reg), "_hosp")
		reg_colname_intens <- paste0(gsub(" ", "_", reg), "_intens")
		reg_colname_resp <- paste0(gsub(" ", "_", reg), "_resp")
		
		plot <- plot_ly(joined, x = ~Date)
		plot <- plot %>% add_trace(y = as.formula(paste0("~", reg_colname_hosp)),
															 name = 'hospitalized', type = 'scatter', mode = 'lines+markers',
															 line = list(color = mypalette[1]),
															 marker = list(color = mypalette[1]),
															 legendgroup = "1st")
		plot <- plot %>% add_trace(y = as.formula(paste0("~", reg_colname_intens)),
															 name = 'intensive care', type = 'scatter', mode = 'lines+markers',
															 line = list(color = mypalette[2]),
															 marker = list(color = mypalette[2]),
															 legendgroup = "1st")
		plot <- plot %>% add_trace(y = as.formula(paste0("~", reg_colname_resp)),
															 name = 'respirator', type = 'scatter', mode = 'lines+markers',
															 line = list(color = mypalette[3]),
															 marker = list(color = mypalette[3]),
															 legendgroup = "1st")
		plot <- plot %>% layout(annotations = list(x = 0.5 , y = 1, text = gsub("Region ", "", reg), 
																							 showarrow = F, font = list(size = 12), xanchor = 'center',
																							 xref='paper', yref='paper'))
		return(plot)
		
	})
}
