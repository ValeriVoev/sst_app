# Set the account info for deployment.
rsconnect::setAccountInfo(name = Sys.getenv("shinyapps_name"),
							 token  = Sys.getenv("shinyapps_token"),
							 secret = Sys.getenv("shinyapps_secret"))

rsconnect::deployApp()
