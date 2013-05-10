#Written by Mike Worth

required_temperature=18
SCHMITT_GAP=2
upper_threashold=required_temperature + SCHMITT_GAP/2
lower_threashold=required_temperature - SCHMITT_GAP/2
TEMP_FILE_NAME="dummy_temp"
heater_on=false

#This thread keeps checking the current temperature and switches the heater on and off
Thread.new{
  while true
    tempfile=File.open(TEMP_FILE_NAME)
    if tempfile.readline.split(' ').last=="YES"

      current_temp=tempfile.readline.split('=').last.to_f / 1000
      
      if heater_on && current_temp > upper_threashold
        puts "CODE TO TURN HEATER OFF"
        heater_on=false
      elsif !heater_on && current_temp < lower_threashold
        puts "CODE TO TURN HEATER ON"
        heater_on=true
      end

    else
      puts "Error reading temperature"
    end
    sleep 5
  end
}

#supply an interface for adjusting the thermostat
while true
  puts "enter required temp"
  required_temperature=gets.chomp.to_f
  upper_threashold=required_temperature + SCHMITT_GAP/2
  lower_threashold=required_temperature - SCHMITT_GAP/2
 
end
