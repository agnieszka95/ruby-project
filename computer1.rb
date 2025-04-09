# computer1.rb
# Code responsible for the functionality of computer no. 1

require 'drb/drb'

# Start RMI service
puts "Starting service..."
if DRb.start_service
  puts "Service started successfully!"
  puts ""
else
  puts "Error while starting service"
  abort
end

puts "Connecting..."
# Connect to computer 2 and retrieve the object that is online at localhost:8888
# The object from comp2 is stored in remote_object and used to display appropriate messages
if remote_object = DRbObject.new_with_uri('druby://localhost:8888')
  puts "Connection established!"
  puts ""
else
  puts "Error while connecting"
  abort
end

# Load Ruby code to send
code = ""
File.open("program.txt").each do |line|
  puts line
  code.concat(line)
end

# Send code to computer 2
remote_object.code_to_send(code)

# Receive compilation result and return value
puts "Code check result: #{remote_object.code_check_result}"

# Receive similarity report
puts "#{remote_object.print_raport}"

# Code that runs before main
BEGIN {
  puts "Initializing Client"
}

# Code that runs after main
END {
  puts "Closing Client"
}
