Temp = %A_ScriptDir%\Temp
Temp01 = %A_ScriptDir%\Temp01
Temp02 = %A_ScriptDir%\Temp02


;Create final file
FileAppend, %Clean%, %A_ScriptDir%\Logs.log

FileRead, steam, %Temp01%\Steam.log
FileRead, gog, %Temp01%\GOG_Galaxy.log
;FileRead, battlenet, %Temp01%\Battlenet.log
FileRead, minecraft, %Temp01%\Minecraft.log
FileRead, playnite, %Temp01%\Playnite.log
a = 0000-00-00, 00:00:00, C'EST LES GROS LOG SA MERE ;supposed to be temporary 
b = 2023-00-00, 00:00:00, NEW YEAR
FileAppend, %a%`n%steam%`n%gog%`n%battlenet%`n%minecraft%, %A_ScriptDir%\Logs.log
FileRead, Clean, %A_ScriptDir%\Logs.log
Sort, Clean, u
FileDelete, %A_ScriptDir%\Logs.log
FileAppend, %Clean%, %A_ScriptDir%\Logs.log




exitapp