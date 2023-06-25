require "json"
require "./rickNMortyService.cr"

#O array travel_stops recebido pela função é substituido pelos valores id, name,type e dimension contidos na variavel api_data. Após cada id do array travel_stops tiver o novo formato guardado na variavel expanded_stops, o objeto expanded_result é devolvido como resposta.
class ExpandService
    # Função para expandir o array travel_stops
    def self.onlyExpand(id : Int32, travel_stops : Array(Int32), api_data : Array(Location)): Hash(String, Array(Hash(String, Int32 | String)) | Int32)
    
        expanded_stops = travel_stops.map do |stop_id|
            location = api_data.find { |data| data.id == stop_id }
            if location
            {
                "id" => location.id,
                "name" => location.name,
                "type" => location.type,
                "dimension" => location.dimension
            }
            else
                raise "Ops! Something wrong happened!"
            end
        end
        
        expanded_result = {
        "id" => id,
        "travel_stops" => expanded_stops 
        }
    end
end