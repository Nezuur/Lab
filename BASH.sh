#!/bin/bash
#This scripts creates new user and group with checking their availableness
#it also creates users directory and add permissions

echo -n "Enter the username for the new user:"                                  
read username                                                                   
                                                                            
getent passwd $username >> /dev/null  #To prevent output on the screen                                          
                                                                                
while [ $? -eq 0 ]   #this contruction will work while getent wont return 1 - as a error code, it would means that user isn't exist.                                                         
  do                                                                            
    echo -n "User already created\n"                                            
    echo -n "Please enter another username: "                                   
    read username                                                               
    getent passwd $username >> /dev/null                                        
  done                                                                          
                                                                                
echo -n "Enter a group name: \n"                                                
read groupname                                                                  
                                                                                
getent group $groupname >> /dev/null                                            
                                                                                
while [ $? -eq 0 ]                                                              
  do                                                                            
   echo -e "Group already exists\n"                                             
   echo -e "Please enter another group name: \n"                                
   read groupname                                 
   getent group $groupname >> /dev/null                                         
  done                                                                 
                                                                                
groupadd $groupname                                                             
useradd -m -s /bin/bash -g $groupname $username 
passwd $username                              
                                                                                
echo -n "User $username has been created\n"                                                       
                                                                                
mkdir /$username                                                                
chown $username.$groupname /$username                                           
chmod 1770 /$username

echo -n "Script has worked successfully\n"

sleep 5 #Wait 5 sec before exit

