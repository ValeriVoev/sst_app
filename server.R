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
	
	output$values <- renderPlotly({
		
		s1 <- subplot(reg_plots, nrows = 2, shareX = TRUE, shareY = TRUE, margin = 0.04)
		
		y <- list(
			title = ""
		)
		
		top_plot <- plot_ly(joined, x = ~Date)
		top_plot <- top_plot %>% add_trace(y = ~Hele_landet_hosp,
																			 name = 'hospitalized', type = 'scatter', mode = 'lines+markers',
																			 line = list(color = mypalette[1]),
																			 marker = list(color = mypalette[1]),
																			 legendgroup = "1st")
		top_plot <- top_plot %>% add_trace(y = ~Hele_landet_intens,
																			 name = 'intensive care', type = 'scatter', mode = 'lines+markers',
																			 line = list(color = mypalette[2]),
																			 marker = list(color = mypalette[2]),
																			 legendgroup = "1st")
		top_plot <- top_plot %>% add_trace(y = ~Hele_landet_resp,
																			 name = 'respirator', type = 'scatter', mode = 'lines+markers',
																			 line = list(color = mypalette[3]),
																			 marker = list(color = mypalette[3]),
																			 legendgroup = "1st")
		top_plot <- top_plot %>% layout(yaxis = y,
																		annotations = list(x = 0 , y = 1.05, 
																											 text = "Covid-19 hospitalizations in Denmark", 
																											 showarrow = F, font = list(size = 16),
																											 xref='paper', yref='paper'))
		
		s1 <- s1 %>% layout(yaxis = y,
												annotations = list(x = 0 , y = 1.05, 
																					 text = "Covid-19 hospitalizations by region", 
																					 showarrow = F, font = list(size = 16),
																					 xref='paper', yref='paper'))
		
		fig <- subplot(top_plot, 
									 style(s1, showlegend = FALSE),
									 nrows = 2, margin = 0.04, heights = c(0.6, 0.4))
		
		fig
		
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