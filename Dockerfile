# get shiny server and R from the rocker project
FROM rocker/shiny-verse

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    pandoc \
    libsodium-dev \
    libxml2-dev \
    libicu-dev \
    libsqlite3-dev \
    r-cran-rsqlite
RUN apt-get clean
# RUN rm -rf /var/lib/apt/lists/*

# install R packages required
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "shiny", \
              "shinymanager", \
              "shinydashboard", \
              "RSQLite", \
              "learnr", \
              "remotes", \
              "rmarkdown", \
              "knitr", \
              "ggplot2" \
            ), \
            repos="https://cran.r-project.org" \
          )'

RUN R -e 'remotes::install_github("rstudio/gradethis")'

# copy the app directory into the image
# COPY ./*.R /srv/shiny-server/
# COPY ./tutorials/* /srv/shiny-server/tutorials/
# COPY ./test/* /srv/shiny-server/test/
# COPY ./data/* /srv/shiny-server/data/

# ADD . /srv/shiny-server/

# run app
CMD ["/usr/bin/shiny-server"]
