# create directories for JS dependencies
dir.create("./inst/htmlwidgets/roughViz", recursive = TRUE)

# download JS dependencies
roughViz <- paste0(
  "https://unpkg.com/rough-viz@1.0.6"
)

download.file(roughViz, "./inst/htmlwidgets/roughViz/roughViz.min.js")
