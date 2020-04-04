# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

# Value tables --------------------------------------------------------------------------------

	
	output$hosp_plot <- renderPlot({
		hosp_long %>% 
			filter(!grepl("_growth", name), !is.na(value)) %>%
			mutate(name = gsub("_", " ", name)) %>%
			ggplot(aes(x=Date, y=value, color = name, fill = name)) +
			geom_line(size = 2, show.legend = FALSE) +
			geom_label(aes(label=value), show.legend = FALSE, nudge_y = 50, size = 3, color = "black") +
			#scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
			facet_wrap(vars(name), nrow = 3) +
			labs(title = "Covid-19 hospitalizations in Denmark", y = "Number of patients")
	})
		

	output$intens_plot <- renderPlot({
		intens_long %>% 
			filter(!grepl("_growth", name), !is.na(value)) %>%
			mutate(name = gsub("_", " ", name)) %>%
			ggplot(aes(x=Date, y=value, color = name, fill = name)) +
			geom_line(size = 2, show.legend = FALSE) +
			geom_label(aes(label=value), show.legend = FALSE, nudge_y = 50, size = 3, color = "black") +
			#scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
			facet_wrap(vars(name), nrow = 3) +
			labs(title = "Covid-19 hospitalizations in Denmark", y = "Number of patients")
	})
	
# Change tables -------------------------------------------------------------------------------


	
	output$hosp_plot_change <- renderPlot({
		hosp_long %>% 
			filter(grepl("r_growth", name), !is.na(value)) %>%
			mutate(name = gsub("_r_growth", "", name)) %>% 
			mutate(name = gsub("_", " ", name)) %>%
			ggplot(aes(x=Date, y=value, fill = name)) +
			geom_col(show.legend = FALSE) +
			geom_label(aes(label=scales::percent(value, 1)), show.legend = FALSE) +
			scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
			facet_wrap(vars(name), nrow = 3) +
			labs(title = "Covid-19 hospitalizations in Denmark", y = "Percentage change")
	})
	

	
	
}
)