load 'menu.rb'

choice = 0


while (choice != 11)
puts "
  - Создать станцию 1
  - Создать поезд 2
  - Создать маршрут 3
  - Добавить станцию к маршруту 4
  - Удалить станцию из маршрута 5
  - Назначить маршрут поезду 6
  - Добавить вагон 7
  - Отцепить вагон 8
  - Переместить поезд по маршруту 9
  - Вывести список станций и список поездов на станции 10
  - Выход 11"
choice = gets.to_i
attempt = 0

case choice  
  when 1
    create_station
	  
  when 2
    create_train
		
  when 3
    create_route
		
  when 4
    add_station
	  
  when 5
    delete_station
	  
  when 6
    set_route
	  
  when 7
    add_wagon
	  
  when 8
    delete_wagon	
  
  when 9
    move_train
	      
  when 10
    show_train
when 12
show_company
	  
end	 
end

