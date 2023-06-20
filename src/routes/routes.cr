module Routes
    def self.define_routes
        get "/travel_plans" do |env|
            "Retorna todos planos e verifica params de otimização/expandir"
        end

        get "/travel_plans/:id" do |env|
            "Retorna o plano do id informado e verifica params de otimização/expandir"
        end

        post "/travel_plans" do |env|
            "Adiciona um plano novo baseado no array travel_stops enviado"
        end

        put "/travel_plans/:id" do |env|
            "Modifica o plano do id informado baseado no array travel_stops enviado"
        end

        delete "/travel_plans/:id" do |env|
            "Deleta o plano de id informado"
        end
    end
end

Routes.define_routes