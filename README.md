# PERP - X

Created for the purpose of preserving PERP. This version is derived from Voltage Gaming PERP 3.5 and has been heavily modified and cleaned up. The content and code has been rewritten and sorted to create the most optimally preserved PERP.


# Getting Started

## SQL
First, create a standard SQL server and run "perp.sql" to create a barebones sql server with no data.
Open mysql.lua inside "gamemode" and ONLY change the connection options in the first table to connect to the server. If the server is already active you can run the command "reconnectmysql" in the server console to retry a connection.

## aSoc Admin
aSocket admin is not available to public connnections currently as it is designed to read discord ranks. Soon you will be able to locally save ranks or connect your own discord connection.
If you are not creating this on an authorized account then you must hardcode all ranks. Location for this is within "gamemode/sv_modules/system_asoc.lua."
(If authorized and connection is failing, it must be authorized in the "PERP X" discord bot)
Ranks are polled every 10 seconds. The command "asoc" also polls for new rank changes.


## Other

The current workshop ID collection is **2324708478** and the server is currently operating at a 22 tickrate.
Hostname is within "gamemode/init.lua" as it constantly changes.

## Map Changes

The server will attempt to boot to the correct map whenever it starts the gamemode fully. This may cause the map to load twice when restarting during the night. If you want the midnight restart to work, configure an automatic restart at 4 AM.

# Submitting Changes
The no-no list:

 - No USMG.
 - No gmodstore please, custom is better.
 - No scrambled code. Add comments if neccessary and organize it.
 - Be mindful of exploits.


# Final Thoughts
Have fun. Theres some cool binds you should use as an admin.
"+asoc_qm" - opens admin menu.
"handsup" - puts your hands up.
"+giveitempanel" - opens the creative menu.

Some interesting and useful commands are:
"loadplayer" - quickly reloads selected player.
"chooseplayer" - opens player selection screen.
"loadallplayers" - quickly loads all players.
"perp_save_all" - quickly saves all players.'
"pong" - self explanitory.
