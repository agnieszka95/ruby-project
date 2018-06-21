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
#Połączenie się z komputerem 2 i pobranie obiektu, ktory jest online na adresie localhost i porcie 8888
#Pobrany obiekt z komp2 zapisywany jest w zmiennej remote_object. Następnie wyświetlamy odpowiednie komunikaty w przypadku sukcesu oraz błędu
if remote_object = DRbObject.new_with_uri('druby://localhost:8888')
	puts "Connection established!"
	puts ""
else
	puts "Error while connecting"
	abort
end

#Wczytanie kodu w Ruby do wysłania
code = ""
File.open("program.txt").each do |line|
	puts line
	code.concat(line)
end

#Wysłanie kodu na komputer 2
remote_object.code_to_send(code)

#odebranie rezultatu kompilacji i wartości zwracanej
puts "Code check result: #{remote_object.code_check_result}"

#kod, ktory wykona sie przed mainem		
BEGIN { 																						
   puts "Initializing Client"
}


#kod, ktory wykona sie po mainie
END {  																	
   puts "Closing Client"
}
