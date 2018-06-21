#komputer1.rb
#kod odpowiedzialny za funkcjonalnosc komputera nr 1

require 'drb/drb'

#rozpoczecie uslugi RMI
puts "Starting service..."
if DRb.start_service									
	puts "Starting service - succes!"
	puts ""
else
	puts "Error while starting service"
	abort
end

puts "Connecting..."
#Połączenie się z komputerem 1 i pobranie obiektu, ktory jest online na adresie localhost i porcie 8888
#Pobrany obiekt z komp1 zapisywany jest w zmiennej remote_object. Następnie wyświetlamy odpowiednie komunikaty w przypadku sukcesu oraz błędu
if remote_object = DRbObject.new_with_uri('druby://localhost:8888')
	puts "Connection established!"
	puts ""
else
	puts "Error while connecting"
	abort
end



#kod, ktory wykona sie przed mainem		
BEGIN { 																						
   puts "Initializing Client"
}


#kod, ktory wykona sie po mainie
END {  																	
   puts "Closing Client"
}
