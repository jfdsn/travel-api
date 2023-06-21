
class CreateStops < Jennifer::Migration::Base
  def up
    create_table :stops do |t|
      t.integer :travel_stops, {:array => true}

    end
  end

  def down
    drop_table :stops if table_exists? :stops
  end
end
