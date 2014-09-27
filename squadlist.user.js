// ==UserScript==
// @name        squadlist
// @namespace   mike-worth.com
// @include     http://cambridge99.squadlist.co.uk/rowers_availability.php
// @version     1
// @grant       none
// ==/UserScript==

civilisedTime=8;
unusedOptions=[1,2,3,6,7,8];
displayClosedOutings=false;

outingsTable=document.getElementById('tblRowersAvailability');
row=outingsTable.firstChild.firstChild;//This contains the tile 'Mens squad outings'

row=row.nextSibling;//while this one has the proper column headers in it

while (row.nodeType!=1){row=row.nextSibling;}//this skips any non-element nodes (like text nodes from the new whitespace etc.)

//this removes whole rows if the outing is too early or already closed
while(row=row.nextSibling){
  if (row.firstChild!=null){//this skips any non-element nodes (like text nodes from the new whitespace etc.)
    
    
    firstCellContents=row.firstChild.innerHTML//if this a a proper row we get the outing time/date otherwise we get <hr>
    if(firstCellContents!='<hr>'){

      time = firstCellContents.trim().split(' ')[2];
      sillyOClock=(parseInt(time.split(':')[0])<civilisedTime);
      outingClosed=(row.innerHTML.indexOf("closed")!=-1);
      
      if(sillyOClock || (outingClosed && ! displayClosedOutings)){
        row.style.display='none';
        row.nextSibling.style.display='none';//this strips out the horizontal rules in interleaved rows
      }
    }
  }
}


//This bit removes the unused options from the selection lists

optionsToDelete=new Array();//we can't delete them as soon as we find them because it will mess up our array

allOptions=document.getElementsByTagName('option');
for(i=0;i<allOptions.length;i++){
  value=parseInt(allOptions[i].value);
  if(unusedOptions.indexOf(value)!=-1){
    optionsToDelete.push(allOptions[i]);
  }

}
for(i=0;i<optionsToDelete.length;i++){
  optionsToDelete[i].parentElement.removeChild(optionsToDelete[i]);
}

