# arcs <- jsonlite::fromJSON(
#   '[
#     {
#       "e": "CN",
#       "i": "US",
#       "v": 3300000
#     },
#     {
#       "e": "CN",
#       "i": "RU",
#       "v": 10000
#     }
#   ]'
# )
#
# # gio(jsonlite::toJSON(arcs, dataframe = "rows")
# # )
#
# # with serialiser
# gio(arcs)

library(gio)
library(plotly)
library(crosstalk)

url <- paste0(
  "https://raw.githubusercontent.com/JohnCoene/",
  "javascript-for-r/master/data/countries.json"
)
arcs <- jsonlite::fromJSON(url)

# Wrap data frame in SharedData
edges_sd <- SharedData$new(
  arcs,
  key = arcs$i, group = "sharedGroup"
)

# create nodes
iso2c <- unique(arcs$i)
nodes <- data.frame(
  country = iso2c,
  y = rnorm(length(iso2c))
)
nodes_sd <- SharedData$new(
  nodes,
  key = nodes$country,
  group = "sharedGroup"
)

bscols(
  plot_ly(data = nodes_sd, type = "bar", x = ~country, y = ~y) %>%
    config(displayModeBar = FALSE),
  gio(edges_sd)
)
