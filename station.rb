load 'instance_counter.rb'

class Station
  include InstanceCounter

  @@stations = []

  attr_accessor :trains, :name_station

  def initialize(name_station)
    @name_station = name_station
    @trains = []
    validate!
    register_instance
    @@stations << self
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def train_arrives(train)
    @trains.push(train)
  end

  def trains_type
    cargo_trains = @trains.count { |train| train.type == :cargo }
    passenger_trains = @trains.count { |train| train.type == :passenger }
  "cargo: #{cargo_trains}, passenger: #{passenger_trains}"
  end

  def Station.all
    @@stations
  end
  
  def valid?
    validate!
    true
    rescue false
  end

  protected
  
  def validate!
    raise "Name is nil" if name_station.nil?
    raise "Length < 3" if name_station.length < 3
  end
end

