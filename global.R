library(shiny)
library(shinydashboard)
library(xml2)
library(dplyr)
library(ggplot2)

source('utils.R')

webpage_url <- "https://www.sst.dk/da/corona/tal-og-overvaagning"

tables <- get_hosp_table(web_url = webpage_url)

hosp <- tables$hosp
hosp_long <- elong_table(hosp)

intens <- tables$intens
intens_long <- elong_table(intens)