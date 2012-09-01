#You’ll have to look this up manually by using the hcitool command
BLUETOOTH_ADDRESS='00:26:5F:C6:30:A3'

#Get this from http://www.mike-worth.com/2012/02/24/controlling-the-mains-via-the-parallel-port/
PARALLEL_CONTROL='/home/mike/parallel_control/parallel_control'
ADDRESS_BIT=1

#If the process is terminated turn everything back on
Kernel.at_exit{system(PARALLEL_CONTROL+' '+ADDRESS_BIT.to_s+' 1 > /dev/null')}

def isPresent(address)
  if (`hcitool name #{address}`=='')
    return false
  else
    return true
  end
end

while true
  if isPresent(BLUETOOTH_ADDRESS)
    system(PARALLEL_CONTROL+' '+ADDRESS_BIT.to_s+' 1 > /dev/null')
    sleep 5
  else
    #double check we didn't just momentarily loose the connection
    if !isPresent(BLUETOOTH_ADDRESS)
      system(PARALLEL_CONTROL+' '+ADDRESS_BIT.to_s+' 0 > /dev/null')
    end
  end
end
