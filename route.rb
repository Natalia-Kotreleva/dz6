load 'instance_counter.rb' 

class Route
  include InstanceCounter

  attr_accessor :stations, :route_name

  def initialize(first_station, final_station, route_name)
    validate!
    @stations = [first_station, final_station]
    @route_name = route_name
    register_instance
  end
    
  def station_add(station)
    @stations.insert(-2, station)
  end

  def station_delete(station)
    @stations.delete(station)
  end

  def valid?
    validate!
    true
    rescue false
  end

  protected 
  
  def validate!
    raise "Length first element < 3" if stations.first.length < 3 
    raise "Length last element < 3" if stations.last.length < 3 
    raise "Length route name < 3" if route_name.length < 3
  end
end

