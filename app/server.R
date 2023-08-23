function(input, output, session) {
    # check_credentials returns a function to authenticate users
    res_auth <- secure_server(
        check_credentials = check_credentials(
            db_file,
            passphrase = db_passphrase
        ),
        timeout = 0,
        keep_token = FALSE
    )

    get_username <- reactive({
        auth_username <- shiny::reactiveValuesToList(res_auth)$user
        if(is.null(auth_username)) {
            if(is.null(username)) {
                auth_username <- Sys.info()['user']
            } else {
                auth_username <- username
            }

        }
        return(auth_username)
    })

    get_all_students <- reactive({
        shinymanager::read_db_decrypt(
            db_file,
            name = 'credentials',
            passphrase = db_passphrase) |>
            dplyr::filter(admin == FALSE) |>
            dplyr::select(!password)

    })

    output$auth_output <- renderPrint({
        reactiveValuesToList(res_auth)
    })

    output$ui <- renderUI({
        if(res_auth$admin) {
            return(admin_ui)
        } else {
            return(student_ui)
        }
    })

    ###### Admin UI
    admin_ui <- renderUI({
        navbarPage(
            title = app_title,
            position = c("fixed-top"),
            tabPanel(
                'Dashboard',
                verbatimTextOutput('auth_output')

            ),
            tabPanel(
                'Details'
            )
        )
    })

    ###### Student UI
    student_ui <- renderUI({
        modules <- list()
        for(i in names(tutorials)) {
            modules[[length(modules)+1]] <- tabPanel(
                title = i,
                br(),
                HTML(as.character(tags$iframe(src = paste0(tutorials[[i]]$url, '?user=', get_username()),
                                              # height = '100%',
                                              # width = '100%',
                                              frameborder = "0",
                                              scrolling = "yes",
                                              seamless="seamless",
                                              style="display:block; width:100%; height:100vh;")))
            )
        }
        modules$title <- 'Modules'
        modulesUI <- do.call(navbarMenu, modules)

        navbarPage(
            title = app_title,
            tabPanel(
                'Home',
                tags$img(src = 'CUNY_MSDS_Hex.png', width = '250', align = 'right')
            ),
            do.call(navbarMenu, modules)
        )
    })

}
