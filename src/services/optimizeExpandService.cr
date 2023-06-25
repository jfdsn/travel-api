require "json"
require "./rickNMortyService.cr"
require "./optimizeService.cr"

class OptimizeExpandService
    # Função para otimizar e expandir as paradas de viagem
    def self.optimizeAndExpand(id : Int32, api_data : Array(Location))


        optimized_result = OptimizeService.onlyOptimize(id, api_data)
        
        if optimized_result
            expanded_result = ExpandService.onlyExpand(id, optimized_result, api_data)
        end

        expanded_result
    end
end