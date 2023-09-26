require "json"
require "../services/service.cr"

class Controller
    #Retorna todos planos e verifica params de otimização/expandir
    def self.getTravelPlans(env : HTTP::Server::Context)
        begin
            optimize = env.params.query["optimize"]? == "true" ? true : false
            expand = env.params.query["expand"]? == "true" ? true : false

            travel_plans = Service.getTravelPlan(optimize, expand)

            env.response.status_code = 200
            env.response.content_type = "application/json"
            travel_plans.to_json
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    #Retorna o plano do id informado e verifica params de otimização/expandir
    def self.getTravelPlanById(env : HTTP::Server::Context)
        begin
            id = env.params.url["id"].to_i
            optimize = env.params.query["optimize"]? == "true" ? true : false
            expand = env.params.query["expand"]? == "true" ? true : false
            
            travel_plan_by_id = Service.getTravelPlanById(id, optimize, expand)
            
            env.response.status_code = 200
            env.response.content_type = "application/json"
            travel_plan_by_id.to_json
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    #Adiciona um plano novo baseado no array travel_stops enviado
    def self.createTravelPlan(env : HTTP::Server::Context)
        begin
            data_json = env.params.json["travel_stops"].as(Array(JSON::Any))
            travel_stops = data_json.map { |stop| stop.as_i }
            
            new_plan = Service.createTravelPlan(travel_stops)
            
            env.response.status_code = 201
            env.response.content_type = "application/json"
            new_plan.to_json
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    #Modifica o plano do id informado baseado no array travel_stops enviado
    def self.updateTravelPlan(env : HTTP::Server::Context)
        begin
            data_json = env.params.json["travel_stops"].as(Array(JSON::Any))
            updated_travel_stops = data_json.map { |stop| stop.as_i }
            id = env.params.url["id"].to_i
            
            res = Service.updateTravelPlan(id, updated_travel_stops)

            env.response.status_code = 200
            env.response.content_type = "application/json"
            res.to_json
            
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    #Deleta o plano de id informado
    def self.deleteTravelPlan(env : HTTP::Server::Context)
        begin
            id = env.params.url["id"].to_i
            
            Service.deleteTravelPlan(id)

            env.response.status_code = 204 
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end  
end