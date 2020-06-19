class PlaceSerializer < ActiveModel::Serializer
  attributes :id,
    :locale,
    :name,
    :place_type,
    :coordinates

  def coordinates
    coordinate = object.coordinate
    {
      lng: coordinate.longitude,
      lat: coordinate.latitude,
    }
  end
end
