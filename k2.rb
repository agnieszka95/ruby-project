#komputer2.rb
#kod odpowiedzialny za funkcjonalnosc komputera nr 2

require 'drb/drb'

#klasa, ktora przetrzymuje rozne funkcjonalnosci komputera nr 1
class Functionality	
#utworzona zostaje zmienna w której przetrzymywany jest kod programu do wysłania na komp 2 	
	def code_to_send(code)
		puts "\nDownloading code..."  
		if File.open("out.rb", 'w') {|f| f.write(code) }
			puts "Code downloaded!"
			
			#tworzenie folderu i sprawdzanie czy taki istnieje 
			dir_name = "programs"
			Dir.mkdir(dir_name) unless File.exists?(dir_name)                                                                              

			#zapisywanie tam tego programu
			if File.open("programs/out.rb", 'w') {|f| f.write(code) }
				puts "Program saved!"
			else
				puts "Blad zapisu"
			end
		else
			puts "Error while downloading"
			abort
		end
	end		

	def code_check_result
			#utworzenie zmiennej do wykonania programu z parametrem -c który zwraca czy program wykonał się poprawnie czy wystąpiły w nim jakieś błędy
		check_syntax_cmd = "ruby -c out.rb"
		#wywołanie za pomocą system(check_syntax_cmd) wykonania skryptu z kodem programu odebrsnego z kommp 1, który zwróci jego poprawność
		code_check_result = system(check_syntax_cmd)
		puts ''

		  #Jeśli code_check_result zwróciło 'true' to znaczy ze skrypt poprawnie się wykonał i program działa poprawnie. Zapisanu zostaje status do przesłania na 2 komp
		#Następnie zostaje wykonany skrypt bez dodatkowych parametrów i wszystkie elementy z nim związane zostają wyświetlone na konsoli
		#Wynik działania programu zapisany zostaje do zmiennej code_result który również zostaje wyświetlony na konsoli
		#Zostaje wywołana zdalna metoda send_code_check_result z komp1 za pomocą utworzonego wcześniej obiektu remote_object i przesłany do niej status programu
		#Zostaje wywołana zdalna metoda send_code_result z komp1 za pomocą utworzonego wcześniej obiektu remote_object i przesłany do niej rezultat wykonania programu

		if code_check_result
			code_check_result = "OK"
			puts "Program code: "
			code_result = eval(File.open(File.expand_path('./out.rb')).read)
			puts ''
			puts "Code check result = #{code_check_result}"
			puts "Code result = #{code_result}"
			result = ""
			return result.concat(code_check_result).concat("\nCode result: ").concat(code_result.to_s)
			#return code_check_result
			#return code_result
		else
		#W przypadku gdy code_check_result zwróciło false oznacza to że zapisany pogram w skrypcie jest nie poprawny i zawiera błędy
		#Zostaje wywołana zdalna metoda send_code_check_result z komp1 za pomocą utworzonego wcześniej obiektu remote_object i przesłany do niej status ERROR
			code_check_result = "ERROR"
			return code_check_result
		end
	end

puts "Creating new object..."
#tworzymy obiekt funkcjonalnosci komputera nr 1 i wyświetlamy odpowiedni komunikat na konsoli
if object = Functionality.new									
	puts "Object created!"
	puts ""
else
	puts "Error while creating object"
	abort
end

puts "Starting service..."
#wrzucony zostaje nasz utworzony obiekt z funkcjonalnośćią na sieć. Jako pierwszyy argument podaje się adres wraz z portem a jako drugi argument nasz obiekt
#Nasz obiekt domyślne będzie dostępny pod adresem 'localhost' i portem '8888'
#Jeśli nie wystąpił zaden błąd czy wyjątek zostaje wyswietlony komunikat na konsoli o poprawnosci działania serwisu a w innym przypadku o błędzie
if DRb.start_service('druby://localhost:8888', object)			
	puts "Service start - success!"
	puts ""
else
	puts "Error while starting service"
	abort
end

puts "Joining thread..."
#Nastepnym elementem jest utworzenie wątku by program komputer 1 był cały czas 'live' dostępny bo można było z niego korzystać cały czas
#Równiez zostaje o tym wyświetlona informacja na konsoli
if DRb.thread.join													
	puts "Thread joined"
	puts ""
else
	puts "Error while joining thread"
	abort
end

#kod, ktory wykona sie przed mainem	
BEGIN { 																				
   puts "Initializing Server"
}

#kod, ktory wykona sie po mainie
END {  														
   puts "Closing program Server"
}
