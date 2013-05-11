#Written by Mike Worth
require 'cinch'


required_temperature=18
SCHMITT_GAP=2
upper_threashold=required_temperature + SCHMITT_GAP/2
lower_threashold=required_temperature - SCHMITT_GAP/2
TEMP_FILE_NAME="dummy_temp"
heater_on=false
heating_active=true
HEATING_ADMINS=["MikeWorth"]

def current_temperature
  tempfile=File.open(TEMP_FILE_NAME)
  if tempfile.readline.split(' ').last=="YES"
    return tempfile.readline.split('=').last.to_f / 1000
  else
    puts "Error reading temperature"
    return false
  end
end

def turn_heater_on
  puts "CODE TO TURN HEATER ON"
  heater_on=true
end

def turn_heater_off
  puts "CODE TO TURN HEATER OFF"
  heater_on=false
end


#This thread keeps checking the current temperature and switches the heater on and off
Thread.new{
  while true
    if heating_active
      if heater_on && current_temperature > upper_threashold
        turn_heater_off
      elsif !heater_on && current_temperature < lower_threashold
        turn_heater_on
      end
    end
    sleep 5
  end
}

#Run an irc bot to interact with people
Thread.new{
  bot = Cinch::Bot.new do
    configure do |c|
      c.server = "irc.freenode.org"
      c.channels = ["#mikeistestingsomething"]
      c.nick = "Craydiator"
    end

    on :message, "Status report" do |m|
      m.reply "The temperature is currently #{current_temperature}"
    end

    on :message, "Activate" do |m|
      if m.user.authed? && HEATING_ADMINS.include?(m.user.authname)
        heating_active=true
        m.reply "Heating turned on"
      else
        m.reply "You're not authorised to do that"
      end
    end

    on :message, "Deactivate" do |m|
      if m.user.authed? && HEATING_ADMINS.include?(m.user.authname)
        heating_active=false
        m.reply "Heating turned off"
      else
        m.reply "You're not authorised to do that"
      end
    end

  end
  bot.start
}


#supply an interface for adjusting the thermostat
while true
  puts "enter required temp"
  required_temperature=gets.chomp.to_f
  upper_threashold=required_temperature + SCHMITT_GAP/2
  lower_threashold=required_temperature - SCHMITT_GAP/2
 
end
