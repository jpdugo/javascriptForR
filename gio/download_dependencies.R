# create directories for JS dependencies
dir.create("./inst/htmlwidgets/three", recursive = TRUE)
dir.create("./inst/htmlwidgets/gio", recursive = TRUE)

# download JS dependencies
three <- paste0(
  "https://cdnjs.cloudflare.com/ajax/",
  "libs/three.js/110/three.min.js"
)
gio <- paste0(
  "https://raw.githubusercontent.com/",
  "syt123450/giojs/master/build/gio.min.js"
)

download.file(three, "./inst/htmlwidgets/three/three.min.js")
download.file(gio, "./inst/htmlwidgets/gio/gio.min.js")
