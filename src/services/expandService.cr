require "json"
require "./rickNMortyService.cr"

# The 'travel_stops' array received by the function is replaced by the values of 'id', 'name', 'type', and 'dimension' contained in the 'api_data' variable. After each 'id' in the 'travel_stops' array has the new format stored in the 'expanded_stops' variable, the 'expanded_result' object is returned as the response.
class ExpandService
    # Function to expand the 'travel_stops' array
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