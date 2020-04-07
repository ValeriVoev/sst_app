library(shiny)
library(shinydashboard)
library(xml2)
library(dplyr)
library(ggplot2)
library(plotly)
library(RColorBrewer)

source('utils.R')

mypalette<-brewer.pal(3,"Dark2")

webpage_url <- "https://www.sst.dk/da/corona/tal-og-overvaagning"

tables <- get_hosp_table(web_url = webpage_url)

hosp <- prepare_table(tables$hosp)
hosp_long <- elong_table(hosp)

intens <- prepare_table(tables$intens)
intens_long <- elong_table(intens)

resp <- prepare_table(tables$resp)
resp_long <- elong_table(resp)

joined <- left_join(hosp, intens, by = "Date", suffix = c("", "_intens")) %>% 
	left_join(resp, by = "Date", suffix = c("_hosp", "_resp"))


# Region plots --------------------------------------------------------------------------------

regs <- grep("Region", colnames(tables$hosp), value = TRUE)
reg_plots <- plotList(regs)

