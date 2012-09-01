#You'll have to look this up manually by using the hcitool command
BLUETOOTH_ADDRESS='00:26:5F:C6:30:A3'

def isPresent(address)
  #do it twice to double check that we didn't just momentarily loose contact
  if (`hcitool name #{address}`=='' && `hcitool name #{address}`=='')
    return false
  else
    return true
  end
end

previous_state=true
paused=false
while true
  if isPresent(BLUETOOTH_ADDRESS)
    #if the phone wasn't here before but is now, it's just arrived back
    if !previous_state
      if paused
        sleep 3
        system('banshee --play')
        paused=false
      end
    end
    previous_state=true
  else
    #if the phone was here before but isn't now, it's just left
    if !previous_state
      #we only want to pause/restart it if it's playing when we leave, however if we use banshee --query-current-state when banshee isn't running we'll open banshee
      if `ps -e | grep banshee` !='' && `banshee --query-current-state`=='current-state: playing'+"\n"
        system('banshee --pause')
        paused=true
      end
    end
    previous_state=false
  end
end
