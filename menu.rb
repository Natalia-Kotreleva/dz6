load 'train.rb'
load 'passenger_train.rb'
load 'cargo_train.rb'
load 'passenger_wagon.rb'
load 'cargo_wagon.rb'
load 'station.rb'
load 'route.rb'

@created_trains = []
@created_stations = []
@created_routes = []
 
TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

def print_function(array, name)
  array.each { |element|
    print "#{element.send( :"#{name}")}: #{array.index(element) + 1}\n"
  }
end

def create_station
  puts "Введите название станции"
  name_station = gets.chomp
  name_station = Station.new("#{name_station}")
  @created_stations.push(name_station)    
  puts "Создано."
end

def set_route
  puts "Выберите номер поезда для назначения маршрута"	 
  print_function(@created_trains, 'name_train')
  train_number = gets.to_i
  puts "Выберите номер маршрута"
  print_function(@created_routes, 'route_name')
  route_number = gets.to_i
  @created_trains[train_number-1].set_route(@created_routes[route_number-1])
  puts "Назначено."
end

def create_train
  puts "Выберите тип поезда: пассажирский (1), грузовой (2)"
  train_type = gets.to_i

    case train_type
      when 1
        puts "Введите имя поезда"
        passenger_train = gets.chomp    
  
        begin
          raise if passenger_train.length < 3
        rescue 
          puts "Length train name < 3, puts name"
          passenger_train = gets.chomp
        retry if passenger_train.length < 3
        end

        puts "Введите номер поезда"
        passenger_train_number = gets.chomp
        begin
          raise if passenger_train_number !~ TRAIN_NUMBER_FORMAT
        rescue 
          puts "Invalid format train number, puts number"
          passenger_train_number = gets.chomp
        retry if passenger_train_number !~ TRAIN_NUMBER_FORMAT
        end

        passenger_train = PassengerTrain.new("#{passenger_train}", "#{passenger_train_number}")
        @created_trains.push(passenger_train)
        puts "Создан #{passenger_train}"

      when 2
        puts "Введите имя поезда"
        cargo_train = gets.chomp
        begin
          raise if cargo_train.length < 3
        rescue 
          puts "Length train name < 3, puts name"
          cargo_train = gets.chomp
        retry if cargo_train.length < 3
        end

        puts "Введите номер поезда"
        cargo_train_number = gets.chomp
        begin
          raise if cargo_train_number !~ TRAIN_NUMBER_FORMAT
        rescue 
          puts "Invalid format train number, puts number"
          cargo_train_number = gets.chomp
        retry if cargo_train_number !~ TRAIN_NUMBER_FORMAT
        end

        cargo_train = CargoTrain.new("#{cargo_train}", "#{cargo_train_number}")
        @created_trains.push(cargo_train)
        puts "Создан #{cargo_train}"
    end
end

def create_route
  if @created_stations.size < 2 
    puts "Не создано достаточно станций"
  else
    puts "Введите название маршрута" 
    name_route = gets.chomp
    puts "Выберите номер начальной станции из созданных"
    print_function(@created_stations, 'name_station')
    first_station = gets.to_i
    puts "Выберите номер конечной станции, кроме #{first_station}"
    print_function(@created_stations, 'name_station')  
    final_station = gets.to_i
  end
  name_route = Route.new(@created_stations[first_station - 1], @created_stations[final_station-1], "#{name_route}")
  @created_routes.push(name_route) 
  puts "Маршрут #{name_route.route_name} создан."
end

def add_station
  puts "Выберите номер маршрута для добавления станции"
  print_function(@created_routes, 'route_name')
  route_number = gets.to_i
  puts "Какой номер станции добавить?"
  print_function(@created_stations, 'name_station')
  station_number = gets.to_i
  if @created_routes[route_number-1].stations.include?(@created_stations[station_number-1]) == true
    puts "Станция уже добавлена"
  else
     @created_routes[route_number-1].station_add(@created_stations[station_number-1])
    puts "Добавлено"
  end
end

def delete_station
  puts "Выберите номер маршрута для удаления станции"
  print_function(@created_routes, 'route_name')
  route_number = gets.to_i
  puts "Какой номер станции удалить?"
  print_function(@created_stations, 'name_station')
  station_number = gets.to_i
  if @created_stations[station_number-1] != @created_routes[route_number-1].stations.first && @created_stations[station_number-1] != @created_routes[route_number-1].stations.last
    @created_routes[route_number-1].station_delete(@created_stations[station_number-1])
    puts "Станция удалена"
  else
    puts "Выберите станцию, которая не является начальной/конечной."
  end
end

def delete_wagon
  puts "Введите номер поезда, у которого хотите удалить вагон"
  print_function(@created_trains, 'name_train')
  train_number = gets.to_i
  puts "Введите номер вагона #{@created_trains[train_number-1].wagons}"
  wagon_number = gets.to_i
  @created_trains[train_number-1].wagon_decrease(@created_trains[train_number-1].wagons[wagon_number-1])
  puts "Удалено."
end

def show_train
    @created_stations.each { |st|
      puts "Станция: #{st.name_station} поезда на станции: "
      st.trains.each { |tr|
        puts "#{tr.name_train}"
      }
    }
end

def move_train
  puts "Какой поезд перемещать"
  print_function(@created_trains, 'name_train')	  
  train_number = gets.to_i
  if @created_trains[train_number-1].route.nil?
    puts "Поезду не назначен маршрут"
  else puts "Вперед (1) или назад (2)?"
    choice = gets.to_i
    case choice 
      when 1
        @created_trains[train_number-1].station_next
        puts "Поезд перемещен на станцию #{@created_trains[train_number-1].station.name_station}"
      when 2
        @created_trains[train_number-1].station_prev
        puts "Поезд перемещен на станцию #{@created_trains[train_number-1].station.name_station}"
    end
  end
end

def add_wagon
  puts "Введите имя вагона"
  wagon_name = gets.chomp
  puts "Введите номер поезда, к которому хотите добавить"
  print_function(@created_trains, 'name_train')
  train_number = gets.to_i
  if @created_trains[train_number-1].class.name == CargoTrain
    wagon_name = CargoWagon.new
    @created_trains[train_number-1].add_wagon(wagon_name)
    puts "Добавлено."
  else 
    wagon_name = PassengerWagon.new
    @created_trains[train_number-1].add_wagon(wagon_name)
    puts "Добавлено."
  end
end

