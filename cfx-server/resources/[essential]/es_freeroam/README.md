# es_freeroam v0.1.3
<a href="https://discord.gg/eNJraMf"><img alt="Discord Status" src="https://discordapp.com/api/guilds/285462938691567627/widget.png"></a>

es_freeroam is a FiveM game mode with a money system.  
The player can receive jobs, survivals, buy buildings, drugs and many more.

 **Note: This project is at an early development stage and we will only continue if other developers contribute to it.   
 you can find the current changelog [here](CHANGELOG.MD)**

## Requirements
- [Essentialmode](https://forum.fivem.net/t/release-essentialmode-base/3665)

## Installation
1. [Download](https://github.com/FiveM-Scripts/Essential_Freeroam/archive/master.zip)
2. Extract the folder and rename it to es_freeroam
3. Place the folder in your resources/[essential] folder
4. Change **resource_type 'map' { gameTypes = { fivem = true } }**   
to    
**resource_type 'map' { gameTypes = { essentialmode = true } }**  
in your fivem-map-skater or fivem-map-hipster resource.lua file.
5. Add - es_freeroam to your AutoStartResources in citmp-server.yml
6. Open **resources/[essential]/config.lua** and change your database settings.
7. Restart your server

## Upgrade
Since the last upgrade we integrated the vehicle shop directly in es_freeroam.   
For that reason you need to remove es_vehshop from your citmp-server.yml.   
After that Open **resources/[essential]/config.lua** and change your database settings.   

## Contribute
if you are a developer and  would like to contribute any help is welcome!   
The contribution guide can be found [here](CONTRIBUTING.MD).
