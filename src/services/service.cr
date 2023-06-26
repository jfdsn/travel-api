require "../../sam.cr"
require "./rickNMortyService.cr"
require "./optimizeService.cr"
require "./expandService.cr"
require "./optimizeExpandService.cr"

# Responsible for the logic before the Controller layer
class Service
    def self.getTravelPlan(optimize : Bool, expand : Bool)
        result = Stops.all

        if !optimize && !expand
            #Both false 
            result
        elsif optimize && !expand
            #optimize=true expand=false 
            optimized_result = [] of Hash(String, Array(Int32) | Int32 | Nil) 
            
            result.each do |travel_plan|
                id = travel_plan.id
                travel_stops = travel_plan.travel_stops

                api_data = RickNMortyService.consult(travel_stops)
                optimized_stops = OptimizeService.onlyOptimize(id || 0, api_data)
                optimized_result << {"id" => id, "travel_stops" => optimized_stops}
            end
            optimized_result 
        elsif !optimize && expand
            #optimize=false expand=true
            expanded_result = [] of Hash(String, Array(Hash(String, Int32 | String)) | Int32) 
            
            result.each do |travel_plan|
                id = travel_plan.id
                travel_stops = travel_plan.travel_stops

                api_data = RickNMortyService.consult(travel_stops)
                expanded_stops = ExpandService.onlyExpand(id || 0, travel_stops, api_data)
                expanded_result << expanded_stops
            end
            expanded_result
        else
            #Both true
            expanded_optimized_result = [] of (Hash(String, Array(Hash(String, Int32 | String)) | Int32) | Nil)

            result.each do |travel_plan|
                id = travel_plan.id
                travel_stops = travel_plan.travel_stops

                api_data = RickNMortyService.consult(travel_stops)

                expanded_optimized = OptimizeExpandService.optimizeAndExpand(id || 0, api_data)
                expanded_optimized_result << expanded_optimized 
            end
            expanded_optimized_result
        end
    end

    def self.getTravelPlanById(id : Int, optimize : Bool, expand : Bool)
        result = Stops.where { _id == id }.first
        travel_stops = [] of Int32

        if result
            travel_stops = result.travel_stops
        end

        if !optimize && !expand
            #Both false 
            result
        elsif optimize && !expand
            #optimize=true expand=false 
            api_data = RickNMortyService.consult(travel_stops)
            optimized_stops = OptimizeService.onlyOptimize(id, api_data)
            optimized_result = {
                "id" => id,
                "travel_stops" => optimized_stops
            }
        elsif !optimize && expand
            #optimize=false expand=true 
            api_data = RickNMortyService.consult(travel_stops) 
            ExpandService.onlyExpand(id, travel_stops, api_data)
        else
            #Both true 
            api_data = RickNMortyService.consult(travel_stops)
            OptimizeExpandService.optimizeAndExpand(id, api_data)
        end
    end

    def self.createTravelPlan(travel_stops : Array(Int32))
        result = Stops.create({travel_stops: travel_stops})
        result
    end

    def self.updateTravelPlan(id : Int, updated_travel_stops : Array(Int32))
        Stops.where { _id == id }.update(travel_stops: updated_travel_stops)    
        optimize = false
        expand = false

        result = getTravelPlanById(id, optimize, expand)
        result
    end

    def self.deleteTravelPlan(id : Int)
        Stops.delete(id)
    end
end