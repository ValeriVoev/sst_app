dashboardPage(title= "Covid-19 related hospitalizations in Denmark",
							dashboardHeader(title = "Covid-19 in Denmark"),
							dashboardSidebar(
								sidebarMenu(
									menuItem("Values", tabName = "values"),
									menuItem("Change", tabName = "change")
								)),
							dashboardBody(
								tabItems(
									tabItem(tabName = "values",
													plotlyOutput("values", height = "800px")
													#plotOutput("hosp_plot", height = "800px"),
													#plotOutput("intens_plot", height = "800px")
									),
									tabItem(tabName = "change",
													plotOutput("hosp_plot_change", height = "800px")
									)
								)
							)
)

