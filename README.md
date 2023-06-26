<h1 align="center">Milenio Travel API</h1>

<p align="center">
    <img src="https://img.shields.io/badge/crystal-v1.8.2-blue">
</p>

## Description
API developed for the Milenio Capital code challenge. It was built using Crystal, Kemal, Jennifer, and Postgres.

Nota: A proposta inicial era de otimizar o resultado baseado em uma pesquisa graphql. Tentei bastante mas por falta de experiência acabei não conseguindo realizar o desafio da forma esperada. A função de otimizar até funciona mas acaba retornando valores diferentes do 'runtest' por ser baseado na quantidade de residents de cada localidade (Get em /localidades/:ids da api) e não pela 'popularidade' retirada do array de episodes na consulta graphql. 

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
- `Milenio Capital`: https://www.milenio.capital/

## :smile: Author

- `Jônathan Faria`