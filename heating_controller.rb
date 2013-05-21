#Written by Mike Worth
require 'cinch'
require 'debugger'


$TEMP_TOLERANCE=1
$TEMP_FILE_NAME="dummy_temp"
$heater_on=false
$heating_active=true
$HEATING_ADMINS=["MikeWorth"]
$bot_name="Craydiator2"

$thermostat_setting=18
$upper_threashold=$thermostat_setting + $TEMP_TOLERANCE
$lower_threashold=$thermostat_setting - $TEMP_TOLERANCE


def current_temperature
  tempfile=File.open($TEMP_FILE_NAME)
  if tempfile.readline.split(' ').last=="YES"
    return tempfile.readline.split('=').last.to_f / 1000
  else
    puts "Error reading temperature"
    return false
  end
end

def turn_heater_on
  $heater_on=true
  puts "CODE TO TURN HEATER ON" 

end

def turn_heater_off
  $heater_on=false
  puts "CODE TO TURN HEATER OFF"
end

def adjust(temperature)
  $thermostat_setting=temperature
  $upper_threashold=temperature + $TEMP_TOLERANCE
  $lower_threashold=temperature - $TEMP_TOLERANCE
end

#initialise a temperature
adjust($thermostat_setting)

#This thread keeps checking the current temperature and switches the heater on and off
Thread.new{
  while true
    if $heating_active
      if $heater_on && current_temperature > $upper_threashold
        turn_heater_off
      elsif !$heater_on && current_temperature < $lower_threashold
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
      c.nick = $bot_name
    end

    on :message do |m|
      if m.message[0..$bot_name.length-1]==$bot_name
        instruction=m.message[$bot_name.length+2..-1]##extra 2 characters for ": "
#puts instruction
        

        if instruction=="status"
          reply="The current temperature is: " + current_temperature.to_s + "C \n"
          reply+="The thermostat is set at: " + $thermostat_setting.to_s + "+/-" + $TEMP_TOLERANCE.to_s + "C \n"

          reply+="The heating is currently : " + ($heating_active ? 'active' : 'inactive') + "\n"
          reply+="The heater itself is currently : " + ($heater_on ? 'on' : 'off') + "\n"

          m.reply(reply)
        end

        if m.user.authed? && $HEATING_ADMINS.include?(m.user.authname)
          if instruction=="activate"
            $heating_active=true
            m.reply "Heating activated"
          end

          if instruction=="deactivate"
            $heating_active=false
            m.reply "Heating deactivated"
          end

          if instruction.start_with?("adjust")
            new_temp=instruction[7..-1].to_f
            adjust(new_temp)
            m.reply "Thermostat adjusted to: "+new_temp.to_s
          end
        end

      end
    end

    on :message, "Activate" do |m|
      if m.user.authed? && $HEATING_ADMINS.include?(m.user.authname)
        $heating_active=true
        m.reply "Heating turned on"
      else
        m.reply "You're not authorised to do that"
      end
    end

    on :message, "Deactivate" do |m|
      if m.user.authed? && $HEATING_ADMINS.include?(m.user.authname)
        $heating_active=false
        m.reply "Heating turned off"
      else
        m.reply "You're not authorised to do that"
      end
    end

  end
  bot.start
}


while true
#stop the thread finishing and terminating
end

#supply an interface for adjusting the thermostat
##while true
##  puts "enter required temp"
##  required_temperature=gets.chomp.to_f
##  $upper_threashold=required_temperature + $TEMP_TOLERANCE
##  $lower_threashold=required_temperature - $TEMP_TOLERANCE
 
##end
