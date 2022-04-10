agma solidity ^0.4.6;  

contract toffender{

    struct offrecoder{
string offName;
string offdob;
uint nationalid;
uint height;
uint victim_age;
string type_offence;
string  status;
uint lastUpdated;
    }
    
    mapping (uint => offrecoder) private dataBase9;
    uint [] private dbindex;
//Event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs.
    event logNewoff(string offName,string offdob,uint nationalid,uint height,uint victim_age,string type_offence,string status, uint offid,uint lastUpdated);
    event logDeleteOff(string offName, uint nationalid);
event logupdateStatus(string nationalid,string status);
     function isOff(uint offIDck)
public 
constant 
returns(bool isIndeed)
{
    if(dbindex.length == 0) return false;
    return (dbindex[dataBase9[offIDck].nationalid] == offIDck);
}

function insertoff(
    string offName,
    string offdob,
    uint offid,
    uint height,
   uint victim_age,
   string type_offence,
   string status,
uint lastUpdated 


)
public {
    if(isOff(offid))revert ('duplicate');
    dataBase9[offid].offName=offName;
    dataBase9[offid].offdob=offdob;
    dataBase9[offid].height=height;
    dataBase9[offid].victim_age=victim_age;
    dataBase9[offid].type_offence=type_offence;
    dataBase9[offid].status=status;
    dataBase9[offid].lastUpdated=lastUpdated;
    dataBase9[offid].nationalid=dbindex.push(offid)-1;
    //
    emit logNewoff(
        dataBase9[offid].offName,
        dataBase9[offid].offdob,
        dataBase9[offid].nationalid,
        dataBase9[offid].height,
        dataBase9[offid].victim_age,
        dataBase9[offid].type_offence,
        dataBase9[offid].status,
        dataBase9[offid].lastUpdated,
        
        offid);
}
function getOffData(uint offIDck)

public
constant
returns (string offName,uint victim_age)
{
     if(!isOff(offIDck)) return ('not found',0); 
    return(
        dataBase9[offIDck].offName,
        // dataBase9[offIDck].offdob
        // dataBase9[offIDck].type_offence,
        //  dataBase9[offIDck].height,
         dataBase9[offIDck].victim_age
        );
        
}
function getOffCount() 
    public
    constant
    returns(uint count, string retString)
  {
    return (dbindex.length,'Hello Prithwis - v1.0 ');
  }
  function getAgePercentage()
  public constant 
  returns (uint victim_age)
  {
   uint countage;
   do {

countage++;
   } while (victim_age<=18);
 return (countage); 
    
    
   
  }
//
  function deleteOff(uint offid) 
    public
  {
    if(!isOff(offid)) revert('not found'); 
    string storage offNameToDelete = dataBase9[offid].offName;
    uint rowToDelete = dataBase9[offid].nationalid;
    uint keyToMove = dbindex[dbindex.length-1];
    dbindex[rowToDelete] = keyToMove;
    dataBase9[keyToMove].nationalid = rowToDelete; 
    dbindex.length--;
    emit logDeleteOff(
      offNameToDelete, 
      rowToDelete);
  }


 function updateStatus(uint offid, string status) 
    public
    returns(bool success) 
  {
    if(!isOff(offid)) revert('not found'); 
    dataBase9[offid].status = status;
    emit logupdateStatus(
      dataBase9[offid].offName,
      dataBase9[offid].status);
    return true;
 }
}

