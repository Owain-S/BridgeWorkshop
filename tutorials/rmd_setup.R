library(learnr)
library(shiny)
library(rmarkdown)
library(knitr)

knitr::opts_chunk$set(echo = TRUE)
tutorial_options(
	exercise.eval = FALSE,
	exercise.timelimit = 60,
	exercise.startover = FALSE)

log_recorder <- function(tutorial_id, tutorial_version, user_id, event, data) {
	cat(tutorial_id, " (", tutorial_version, "): ",
		user_id, ", ", event, ", ", data$label, ", ", data$answers, ", ", data$correct, "\n",
		sep = "",
		file = paste0('../data/log/', tutorial_id, '.log'),
		append = TRUE)
}

db_recorder <- function(tutorial_id, tutorial_version, user_id, event, data) {

}

options(tutorial.event_recorder = log_recorder)
