require "json"
require "./rickNMortyService.cr"

class OptimizeService
    # Função para reordenar as paradas de viagem
    def self.onlyOptimize(id : Int32, api_data : Array(Location)) : Array(Int32)

      # Ordenar as dimensões com base na popularidade média
      dimensions = api_data.map { |data| data.dimension }.uniq
      sorted_dimensions = dimensions.sort do |a, b|
        popularity_a = calculateAveragePopularity(api_data, a)
        popularity_b = calculateAveragePopularity(api_data, b)
        if popularity_a == popularity_b
          a <=> b # Ordenar em ordem alfabética em caso de empate
        else
          popularity_a <=> popularity_b
        end
      end
      
      # Ordenar as localizações dentro de cada dimensão
      sorted_stops = Array(Int32).new
      sorted_dimensions.each do |dimension|
        locations = api_data.select { |data| data.dimension == dimension }
        locations.sort do |a, b|
          if a.residents.size == b.residents.size
            a.name <=> b.name # Ordenar em ordem alfabética em caso de empate
          else
            a.residents.size <=> b.residents.size
          end
        end
        sorted_stops.concat(locations.map { |location| location.id })
      end

      sorted_stops
    end

    # Função auxiliar para calcular a popularidade média de uma dimensão
    def self.calculateAveragePopularity(api_data : Array(Location), dimension : String) : Float64
      locations = api_data.select { |data| data.dimension == dimension }
      total_popularity = locations.sum { |location| location.residents.size }
      total_popularity.to_f / locations.size.to_f
    end
end