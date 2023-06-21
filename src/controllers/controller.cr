require "json"
require "../../sam.cr"
require "../services/service.cr"
#TODO: implementar logica de otimize/expand consumindo a API externa
class Controller
    def self.getTravelPlans(env : HTTP::Server::Context)
        #Retorna todos planos e verifica params de otimização/expandir
        begin
            travel_plans = (Stops.all).to_json
            env.response.status_code = 200
            env.response.content_type = "application/json"
            travel_plans
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    def self.getTravelPlanById(env : HTTP::Server::Context)
        #Retorna o plano do id informado e verifica params de otimização/expandir
        begin
            id = env.params.url["id"].to_i
            travel_plan_by_id = (Stops.where { _id == id }).to_json
            env.response.status_code = 200
            env.response.content_type = "application/json"
            travel_plan_by_id
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    def self.createTravelPlan(env : HTTP::Server::Context)
        #Adiciona um plano novo baseado no array travel_stops enviado
        begin
            data_json = env.params.json["travel_stops"].as(Array(JSON::Any))
            travel_stops = data_json.map { |stop| stop.as_i }
            new_plan = Stops.create({travel_stops: travel_stops})
            env.response.status_code = 201
            env.response.content_type = "application/json"
            new_plan.to_json
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    def self.updateTravelPlan(env : HTTP::Server::Context)
        #Modifica o plano do id informado baseado no array travel_stops enviado
        begin
            data_json = env.params.json["travel_stops"].as(Array(JSON::Any))
            updated_travel_stops = data_json.map { |stop| stop.as_i }
            id = env.params.url["id"].to_i
            Stops.where { _id == id }.update(travel_stops: updated_travel_stops)
            
            res = getTravelPlanById(env)

            env.response.status_code = 200
            env.response.content_type = "application/json"
            res
            
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end

    def self.deleteTravelPlan(env : HTTP::Server::Context)
        #Deleta o plano de id informado
        begin
            id = env.params.url["id"].to_i
            Stops.delete(id)
            
            env.response.status_code = 204 
        rescue ex
            puts "Oops! Ocorreu um error #{ex}"
            env.response.status_code = 404
        end
    end  
end