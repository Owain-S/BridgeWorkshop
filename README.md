# CUNY MSDS Bridge Tutorial




Install Docker for [Mac](https://docs.docker.com/desktop/install/mac-install/) or [Windows](https://docs.docker.com/desktop/install/windows-install/).



```
docker build --platform linux/x86_64 -t msdsbridge .
```

```
docker run --rm -p 3838:3838 -v ./shinylog/:/var/log/shiny-server/ -v ./:/srv/shiny-server/ msdsbridge
```

Run a RStudio server locally:

```
docker run --rm \
  -p 127.0.0.1:8787:8787 \
  -e DISABLE_AUTH=true \
  rocker/rstudio
```


## `learnr` Tutorials

```
	```{r setup, include=FALSE}
	source('rmd_setup.R')
	```
	
	```{r, child="user_check.Rmd"}
	```
```

Links to relevant R packages:

* [`learnr`](https://rstudio.github.io/learnr/)
* [`gradethis`](https://github.com/rstudio/gradethis)
* [`shinymanager`](https://datastorm-open.github.io/shinymanager/)
* [Prerendered Shiny Documents](https://rmarkdown.rstudio.com/authoring_shiny_prerendered.HTML)
* [Recording answers from learnr](https://stackoverflow.com/questions/51778262/how-can-i-record-exercise-submission-in-a-learnr-r-tutorial)
* [Mathematics for Data Science](https://towardsdatascience.com/mathematics-for-data-science-e53939ee8306)
