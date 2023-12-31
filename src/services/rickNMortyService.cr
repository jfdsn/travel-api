require "http/client"
require "json"

class Location
    include JSON::Serializable
    property id : Int32
    property name : String
    property type : String
    property dimension : String
    property residents : Array(String)
    property url : String
    property created : String
end

#Realiza a consulta na API Rick and Morty baseado no array de int32 travel_stops.
#Retorna um Array(Location) com as informações necessárias para expandir e otimizar o travel plan.
class RickNMortyService
    # Função para consultar os dados na API externa
    def self.consult(travel_stops : Array(Int32)) : Array(Location) 
        addr = "https://rickandmortyapi.com/api/location/#{travel_stops.join(",")}"
        result_body = [] of Location
    
        HTTP::Client.get(addr) do |result|
            if result.status_code == 200
            result_body = Array(Location).from_json(result.body_io.try(&.gets_to_end))
            else
            raise "Request failed with status #{result.status_code.inspect}"
            end
        end
        
        result_body
    end
end