install.packages(c('remotes',
				   'tidyverse',
				   'ShinyManager',
				   'shiny',
				   'shinydashboard',
				   'RSQLite',
				   'learnr',
				   'ggplot2'),
				 repos = 'https://cran.r-project.org')

remotes::install_github("rstudio/gradethis")

# Create initial database with two users
source('config.R')
if(!file.exists(db_file)) {
	credentials <- data.frame(
		user = c("admin", "student"),
		password = c("test", "test"),
		admin = c(TRUE, FALSE),
		email = c('jason.bryer@cuny.edu', 'jason@bryer.org'),
		application_id = c(NA, NA),
		stringsAsFactors = FALSE
	)

	# Init the database
	shinymanager::create_db(
		credentials_data = credentials,
		sqlite_path = db_file,
		passphrase = db_passphrase
	)
}
