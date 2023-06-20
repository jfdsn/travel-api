class Stops < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    travel_stops: Array(Int32),
    created_at: Time?,
    updated_at: Time?,
  )

end
