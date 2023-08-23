ui <- uiOutput('ui')

shinymanager::secure_app(ui, enable_admin = TRUE)
