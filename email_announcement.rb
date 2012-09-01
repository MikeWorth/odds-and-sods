#You can enter as many or as few IMAP accounts as you like:
ACCOUNTS=[
  {
    'name'=>'personal',
    'server'=>'',
    'user'=>'',
    'pass'=>''
  },
  {
    'name'=>'uni',
    'server'=>'',
    'user'=>'',
    'pass'=>''
  },
  {
    'name'=>'tutoring',
    'server'=>'',
    'user'=>'',
    'pass'=>''
  }
]

#You`ll have to look this up manually by using the hcitool command
BLUETOOTH_ADDRESS='00:26:5F:C6:30:A3'
GREETING='Hello Mike.'
VOICE='en-uk'

require 'rubygems'
require 'espeak-ruby'
include ESpeak
require 'net/imap'

def isPresent(address)
  if (`hcitool name #{address}`=='')
    return false
  else
    return true
  end
end

def newemails(account)
  begin
    imap = Net::IMAP.new(account['server'], 993, true)
    imap.login(account['user'],account['pass'])
    imap.select('INBOX')
    mailcount= imap.search(['NOT','SEEN']).count
    imap.logout
    imap.disconnect
    return mailcount
  rescue SocketError
    puts 'Couldn\'t connect to server: '+account['server']
  rescue Net::IMAP::NoResponseError
    puts 'Login failed for user '+account['user']
  rescue
    puts 'Unknown error while checking '+account['name']
  end
  #If something went wrong, report no new emails
  return 0
end


previous_state=true
while true
  if isPresent(BLUETOOTH_ADDRESS)
    #if the phone wasn't here before but is now, it's just arrived back
    if !previous_state
      message=GREETING+' '
      ACCOUNTS.each do |account|
        mailcount=newemails(account)
        if mailcount==1
          message+='You have 1 new '+account['name']+' email. '
        elsif mailcount>1
          message+='You have '+mailcount.to_s+' new '+account['name']+' emails. '
        end
      end
      espeak('/tmp/message.mp3',:text=>message,:voice=>VOICE,:quiet=>true)
      system('mpg321 -q /tmp/message.mp3')
    end
    previous_state=true
  #double check it really is out of range
  elsif !isPresent(BLUETOOTH_ADDRESS)
    previous_state=false
  end
end

