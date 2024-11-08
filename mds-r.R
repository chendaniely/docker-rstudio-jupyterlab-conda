install.packages(c(
    'renv',
    'languageserver',
    'janitor',
    'gapminder',
    'readxl'
))

devtools::install_github("ucbds-infra/ottr@stable")
devtools::install_github("ttimbers/canlang")

install.packages("StanHeaders", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install.packages('IRkernel')

#IRkernel::installspec()
