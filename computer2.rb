# computer2.rb
# Code responsible for the functionality of computer no. 2

require 'drb/drb'

# Class that holds various functionalities for computer no. 1
class Functionality
  # Save the code received from computer 1
  def code_to_send(code)
    puts "\nDownloading code..."
    if File.open("out.rb", 'w') { |f| f.write(code) }
      puts "Code downloaded!"

      # Create folder if it doesn't exist
      dir_name = "programs"
      Dir.mkdir(dir_name) unless File.exists?(dir_name)

      # Save the program to that folder
      if File.open("programs/out.rb", 'w') { |f| f.write(code) }
        puts "Program saved!"
      else
        puts "Error while saving"
      end
    else
      puts "Error while downloading"
      abort
    end
  end

  def code_check_result
    # Create command to check syntax
    check_syntax_cmd = "ruby -c out.rb"
    # Run the syntax check
    code_check_result = system(check_syntax_cmd)
    puts ''

    if code_check_result
      code_check_result = "OK"
      puts "Program code: "
      code_result = eval(File.open(File.expand_path('./out.rb')).read)
      puts ''
      puts "Code check result = #{code_check_result}"
      puts "Code result = #{code_result}"
      result = ""
      return result.concat(code_check_result).concat("\nCode result: ").concat(code_result.to_s)
    else
      # If syntax check failed
      code_check_result = "ERROR"
      return code_check_result
    end
  end

  # Compare files in terms of structure
  def print_raport
    folder_path = "programs"
    filenames = Dir.glob 'programs/*.rb'

    # Rename files to indexes
    filenames.each_with_index do |filename, index|
      new_name = "#{folder_path}/#{index}#{File.extname(filename)}"
      unless File.exists?(new_name)
        File.rename(filename, new_name)
      else
        index += 1
      end
    end

    filenames = Dir.glob 'programs/*.rb'
    num = filenames.length

    if num >= 2
      report = "Report:"
      for i in 0..num - 1 do
        for j in i..num -
