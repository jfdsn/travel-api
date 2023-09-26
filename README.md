<h1 align="center">Travel API</h1>

<p align="center">
    <img src="https://img.shields.io/badge/crystal-v1.8.2-blue">
</p>

## Description
API developed for a code challenge built using Crystal, Kemal, Jennifer, and Postgres.
The objective of the API is to register travel plans using locations from the Rick and Morty universe. In addition to registration, it's possible to retrieve the registered data and use optimization and expansion parameters to return organized results based on data present in the external "Rick and Morty API."

##  :hammer: Features

- `Get(/travel_plans)`: to retrieve all plans from the database.

- `Get(/travel_plans/:id)`:  to retrieve the plan with the specified ID.

- `Post(/travel_plans)`: to save new plans. The request body is a JSON object like:
{ "travel_stops": [1,2] }.

- `Put(/travel_plans/:id)`: to update the plan with the specified ID. The body is a JSON object like: 
{ "travel_stops": [1,2] }.

- `Delete(/travel_plans/:id)`: to delete the plan with the specified ID.

Additional features:

- `Optimization`: The GET routes accept the 'optimize' parameter to adjust the order of the 'travel_stops' array based on popularity criteria.

- `Expansion`: The GET routes accept the 'expand' parameter to provide additional details (name, type, dimension) for each 'travel_stop' in the response.
Example usage: /travel_plans/1?optimize=true&expand=true

## :gear: Configuration

To use this application, simply download the project or clone this repository. Once done, navigate to the root directory and execute the following command in the terminal:

```sh
    docker-compose up
```
Please ensure that you have Docker properly installed on your local environment.

## :heavy_check_mark: Techniques and Technologies Used

- `Crystal`
- `Kemal`
- `Jennifer ORM`
- `Postgres`
- `Docker`

## :link: Credits

- `Crystal-lang`: https://crystal-lang.org/reference/1.8/database/index.html
- `Rick and Morty API`: https://rickandmortyapi.com/
- `Kemal`: https://crystal-lang.org/reference/1.8/database/index.html
- `Jennifer`: https://crystal-lang.org/reference/1.8/database/index.html

## :smile: Author

- `Jônathan Faria`