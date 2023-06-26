# API developed for the Milenio Capital code challenge.
# It was built using Crystal, Kemal, Jennifer, and Postgres.

# It has 5 communication routes:
# GET (/travel_plans) to retrieve all plans from the database.
# GET (/travel_plans/:id) to retrieve the plan with the specified ID.
# POST (/travel_plans) to save new plans. The request body is a JSON object { "travel_stops": [1,2] }.
# PUT (/travel_plans/:id) to update the plan with the specified ID. The body is a JSON object
# Example: {"travel_stops": [1,2] }.
# DELETE (/travel_plans/:id) to delete the plan with the specified ID.

# The GET routes accept two additional parameters (optimize, expand), using data from the Rick and Morty  # API.
# The 'optimize' parameter adjusts the 'travel_stops' array following the following logic: ascending order #  of the average 'residents' of the 'dimensions',
# and in case of equal 'dimensions', the ascending order of 'residents' of each location is respected.
# The 'expand' parameter expands the information of the 'travel_stops' array by providing details of 
# 'name', 'type', and 'dimension'.
# Both parameters can be used together or individually.
# Example: /travel_plans/1?optimize=true&expand=true

require "./routes/routes.cr"

module Travelsapi
  VERSION = "0.1.0"

  Kemal.run
end