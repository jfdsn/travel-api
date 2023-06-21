require "kemal"
require "../controllers/controller.cr"
require "json"
require "../../sam.cr"

module Routes
    def self.define_routes
        get "/travel_plans" do |env|
            Controller.getTravelPlans(env)
        end

        get "/travel_plans/:id" do |env|
            Controller.getTravelPlanById(env)
        end

        post "/travel_plans" do |env|   
            Controller.createTravelPlan(env)
        end

        put "/travel_plans/:id" do |env|
            Controller.updateTravelPlan(env)
        end

        delete "/travel_plans/:id" do |env|
            Controller.deleteTravelPlan(env)
        end
    end
end

Routes.define_routes