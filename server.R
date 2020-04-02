# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
	
	output$hosp_plot <- renderPlot({
		hosp_long %>% 
			filter(grepl("r_growth", name), !is.na(value)) %>%
			mutate(name = gsub("_r_growth", "", name)) %>% 
			ggplot(aes(x=Date, y=value, fill = name)) +
			geom_col(show.legend = FALSE) +
			geom_label(aes(label=scales::percent(value, 1)), show.legend = FALSE) +
			scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
			facet_wrap(vars(name), nrow = 3) +
			labs(title = "Covid-19 hospitalizations in Denmark", y = "Percentage change")
	})
}
)