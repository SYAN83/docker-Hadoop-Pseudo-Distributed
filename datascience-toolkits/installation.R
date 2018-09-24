install.packages(c('crayon', 'pbdZMQ', 'devtools'), repos = "http://cran.us.r-project.org")
devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))

IRkernel::installspec(user = FALSE)

