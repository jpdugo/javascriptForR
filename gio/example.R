arcs <- jsonlite::fromJSON(
  '[
    {
      "e": "CN",
      "i": "US",
      "v": 3300000
    },
    {
      "e": "CN",
      "i": "RU",
      "v": 10000
    }
  ]'
)

# gio(jsonlite::toJSON(arcs, dataframe = "rows")
# )

# with serialiser
gio(arcs)

