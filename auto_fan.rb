require 'hpricot'
require 'open-uri'

#Get this from http://www.mike-worth.com/2012/02/24/controlling-the-mains-via-the-parallel-port/
PARALLEL_CONTROL='/home/mike/parallel_control/parallel_control'
ADDRESS_BIT=1
#Set up a default temperature
threshold_temperature=18

#This is where the clever stuff happens, scrape the current temperature adjusted for wind
# and humidity from a weather station in Southampton and adjust the fan state accordingly
def check_temperature(threshold)
  doc = Hpricot(open("http://www.southamptonweather.co.uk/"))
  temperature=doc.search("span[@id=ajaxfeelslike]")[0].innerHTML.to_i
  if (temperature<threshold)
    system(PARALLEL_CONTROL+' '+ADDRESS_BIT.to_s+' 0 > /dev/null')
  else
    system(PARALLEL_CONTROL+' '+ADDRESS_BIT.to_s+' 1 > /dev/null')
  end
end

#Start a separate thread to check the temperature and adjust the fan state every 5 minutes
Thread.new{
  while true
    check_temperature(threshold_temperature)
    sleep 300
  end
}

#Give a basic UI that allows the threshold temperature to be adjusted
puts 'threshold temperature is currently set to '+threshold_temperature.to_s+'°C'
while true
  puts 'Set threshold temperature'
  threshold_temperature = gets.chomp.to_i
  #We don't want to have to wait 5 minutes for the fan state to update
  check_temperature(threshold_temperature)
end

