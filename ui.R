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
													plotOutput("hosp_plot", height = "800px")
									),
									tabItem(tabName = "change",
													plotOutput("hosp_plot_change", height = "800px")
									)
								)
							)
)

