# Cho_Rpc
RPC endpoint update script

Simple script to update an existing plugin node installation rpc & wss endpoints that were configured using chori86 github repositories.


## What does this script do?

The script is designed to find the three files in the main `$HOME` folder that hold the WSS & RPC strings. 

It then updates the strings to use the selected RPC & WS endpoints from the options list. As part of this process the script also attempts to find the correct filenames that need to be updated.


The filenames used in both the official GoPlugin & chori86 repositories are as follows;
      
       sample.vars
       plinode_YOUSER_NAME.vars
       config.toml
       
Once the correct filenames are located the string values are updated.


## How to run the script

```
 cd $HOME
 git clone https://github.com/chori86/Cho_Rpc.git
 cd Cho_Rpc
 chmod +x *.sh
 
 ./Choripli_rpc.sh

 ```


## Refreshing your local repo

As the code is updated it will be necessary to update your local repo from time to time. To do this you have two options;


1. Force git to update the local repo by overwriting the local changes, which in this case are the file permission changes. Copy and paste the following code;
        
        cd ~/Cho_Rpc
        git fetch
        git reset --hard HEAD
        git merge '@{u}'
        chmod +x *.sh
