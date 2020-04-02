library(rmarkdown)
output_dir <- "./reports"
render("./code/data_read.Rmd", output_dir = output_dir)
render("./code/data_preprocessing.Rmd", output_dir = output_dir)
render("./code/outlier_removal.Rmd", output_dir = output_dir)
