shinyUI(
	
	dashboardPage(title= "Covid-19 related hospitalizations in Denmark",
								dashboardHeader(),
								dashboardSidebar(),
								dashboardBody(
									plotOutput("hosp_plot", height = "800px")
								)
	)
	

)
