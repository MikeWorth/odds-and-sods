#This takes a measurement and converts it to the FFF unit system

require_relative 'unit_definitions.rb'

def nonFFFUnits(unitsString)
  for unit in unitsString.split(' ')
    if $baseUnits.include?(unit.split('^')[0])==false
#    puts"nonFFF:#{unit.split('^')[0]}"
      return true #we've found a non FFF unit
    end
  end
  return false
end

def multiplyAllUnits(unitsString,newPower)
  newUnitsString=''
  for workingSection in unitsString.split(' ')
    
    unit,oldPower=workingSection.split('^')
    oldPower=1 if oldPower==nil

    newUnitsString+=" #{unit}^#{oldPower.to_f*newPower.to_f}"
  end
  return newUnitsString
end
  
#Found this on stackoverflow TODO: can I do this in a better way?
class Float
  def sigfigs(signs)
    Float("%.#{signs}g" % self)
  end
end

puts 'Input value:'#TODO explain formatting
originalInput=gets.chomp

runningValue,unitsString = originalInput.split(' ',2)

#echo back our interpretation of units
inputInterpretation = runningValue.to_s
for workingSection in unitsString.split(' ')
  unit,power=workingSection.split('^') #TODO: cope with si prefixes
  power=1 if power==nil

  inputInterpretation+= " #{$units[unit][:name]}^#{power}"
end
puts "Input interpreted as: #{inputInterpretation}"

runningValue=runningValue.to_f#TODO: this is a bodge to fix up some weird integer multiplication issues

while nonFFFUnits(unitsString)



  workingSection,unitsString=unitsString.split(' ',2)

  unit,power=workingSection.split('^') #TODO: cope with si prefixes
  power=1 if power==nil

  if $baseUnits.include?(unit) #skip iterations that already contain base units
    unitsString+= " #{unit}^#{power}"
    next
  end

  runningValue*= $units[unit][:value].to_f ** power.to_f

  unitsString='' if unitsString.nil?
  unitsString+= ' '+ multiplyAllUnits($units[unit][:inUnits],power)

  puts "= #{runningValue.to_s} #{unitsString}"

end

#Clean up the units before final output
furlongsPower=0
firkinsPower=0
fortnightsPower=0
for unitTerm in unitsString.split(' ')
  unit,power=unitTerm.split('^')
  power=1 if power==nil
  
  power=power.to_f#TODO: why doesnt duck typing sort this?

  furlongsPower += power if unit=='fur'
  firkinsPower += power if unit=='fir.mass'
  fortnightsPower += power if unit=='ftn'
end

unitsString = ''

furlongsPower=furlongsPower.to_i if furlongsPower==furlongsPower.to_i#gets rid of horrible ".0"s on the end of integer powers TODO: do this in a less crude way
unitsString+=' fur' unless furlongsPower==0
unitsString+="^#{furlongsPower}" unless [0,1].include?(furlongsPower)

firkinsPower=firkinsPower.to_i if firkinsPower==firkinsPower.to_i#gets rid of horrible ".0"s on the end of integer powers TODO: do this in a less crude way
unitsString+=' fir.mass' unless firkinsPower==0
unitsString+="^#{firkinsPower}" unless [0,1].include?(firkinsPower)

fortnightsPower=fortnightsPower.to_i if fortnightsPower==fortnightsPower.to_i#gets rid of horrible ".0"s on the end of integer powers TODO: do this in a less crude way
unitsString+=' ftn' unless fortnightsPower==0
unitsString+="^#{fortnightsPower}" unless [0,1].include?(fortnightsPower)

puts "#{originalInput} converted to #{runningValue.sigfigs(3).to_s}#{unitsString}"

