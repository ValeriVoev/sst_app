webpage_url <- "https://www.sst.dk/da/corona/tal-og-overvaagning"
webpage <- xml2::read_html(webpage_url)

hosp <- rvest::html_table(webpage, header = TRUE)[[4]]
hosp <-hosp[-1,]
hosp[2:dim(hosp)[2]] <- sapply(hosp[2:dim(hosp)[2]],as.numeric)

colnames(hosp) <- gsub(" ", "_",  colnames(hosp))
colnames(hosp)[1] <- "Date"

hosp <- hosp %>% purrr::map_df(rev)

hosp <- hosp %>% 
	mutate_if(is.numeric, list(growth = ~(. - lag(.)), r_growth = ~(. - lag(.))/lag(.)  ) )

proper_dates <- seq(as.Date("2020-03-16"), as.Date("2020-03-16") + (nrow(hosp) - 1), by = "day")
hosp$Date <- proper_dates

hosp_long <- hosp %>% 
	tidyr::pivot_longer(cols = -Date)