#SingleInstance, Force

Loop, read, %A_ScriptDir%\options.ini 
{
    if InStr(A_LoopReadLine, "version")
    codeversion = %A_LoopReadLine%
}
codeversion := StrReplace(codeversion, "version = ", "")
Gui, destroy

; Path ============================================================================================
    StartupFolder =  C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    Scripts =   %A_ScriptDir%\Scripts
    UI = %A_ScriptDir%\UI


Gui, Add, Button, x50 y9 w80 h30, Logs
Gui, Add, Button, x150 y9 w80 h30, DoStuff                                                              ; WIP
Gui, Add, CheckBox, x250 y9 w130 h30 vstartupvar gStartup, Launch at start up

; Featured =========================================================================================
    Gui, Add, Text, x102 y306 w390 h20 vNvidiaPath,
    Gui, Add, Button, x12 y300 w80 h30 , Nvidia
    Gui, Add, GroupBox, x2 y288 w500 h50

    Gui, Add, Text, x102 y356 w390 h20 vSteamPath, Please provide path
    Gui, Add, Button, x12 y350 w80 h30 , Steam
    Gui, Add, GroupBox, x2 y338 w500 h50

    Gui, Add, Text, x102 y406 w390 h20 vEpicPath,
    Gui, Add, Button, x12 y400 w80 h30 , Epic
    Gui, Add, GroupBox, x2 y388 w500 h50

    Gui, Add, Text, x102 y506 w390 h20 vRiotPath,
    Gui, Add, Button, x12 y500 w80 h30 , Riot
    Gui, Add, GroupBox, x2 y488 w500 h50

    Gui, Add, Text, x102 y556 w390 h20 vMinecraftPath,
    Gui, Add, Button, x12 y550 w80 h30 , Minecraft
    Gui, Add, GroupBox, x2 y538 w500 h50

    Gui, Add, Text, x102 y606 w390 h20 vBattlenetPath,
    Gui, Add, Button, x12 y600 w80 h30 , Battlenet
    Gui, Add, GroupBox, x2 y588 w500 h50


; Retreive User Options ============================================================================
    UserOptions = %A_ScriptDir%\user_options.ini

    ; Startup
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Startup = 1")
            {
                GuiControl,, Startupvar, 1
                Startupis = 1
            }
            if InStr(A_LoopReadLine, "Startup = 0")
            {
                GuiControl,, Startupvar, 0
                Startupis = 0
            }            
        }




    ; Nvidia       
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Nvidia")
            Nvidia = %A_LoopReadLine%
        }
        Nvidia := StrReplace(Nvidia, "Nvidia = ", "")
        GuiControl,, NvidiaPath, %Nvidia%

    ; Steam       
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Steam")
            Steam = %A_LoopReadLine%
        }
        Steam := StrReplace(Steam, "Steam = ", "")
        GuiControl,, SteamPath, %Steam%

    ; Epic
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Epic")
            Epic = %A_LoopReadLine%
        }
        Epic := StrReplace(Epic, "Epic = ", "")
        GuiControl,, EpicPath, %Epic%

    ; Minecraft
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Minecraft")
            Minecraft = %A_LoopReadLine%
        }
        Minecraft := StrReplace(Minecraft, "Minecraft = ", "")
        GuiControl,, MinecraftPath, WIP         %Minecraft%

    ; Riot
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Riot")
            Riot = %A_LoopReadLine%
        }
        Riot := StrReplace(Riot, "Riot = ", "")
        GuiControl,, RiotPath, %Riot%

    ; Battlenet
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Battlenet")
            Battlenet = %A_LoopReadLine%
        }
        Battlenet := StrReplace(Battlenet, "Battlenet = ", "")
        GuiControl,, BattlenetPath, %Battlenet%

Gui, Show,, Time Tracker by Aonne. v%codeversion%
Return


; What Things Do =================================================================================

    ButtonLogs:
        Run, %A_ScriptDir%\Temp
    return

    ButtonDoStuff:
        {
            Run, %A_ScriptDir%\Time Tracker.ahk
            Loop %Scripts%\*.ahk
            Run %A_LoopFileFullPath%
            Msgbox, Done!
        }
        
        

    Startup:
        Gui, Submit, NoHide
        ifEqual %startupvar% ; Checked
        {
            FileCreateShortcut, %A_ScriptDir%\Time Tracker.ahk, %StartupFolder%\Time Tracker by Aonne.lnk
            Startupis = 1
        }
        ifNotEqual %startupvar% ; Unchecked
        {
            FileDelete, %StartupFolder%\Time Tracker by Aonne.lnk
            Startupis = 0
        }
        return




    ButtonSteam:
        FileSelectFile, SteamPath, 3, , Open a file, Text Documents (Steam.exe)
        SteamPath := StrReplace(SteamPath, "steam.exe", "logs")
        GuiControl,, SteamPath, %SteamPath%
        Steam = %SteamPath%
    return

    ButtonRiot:
        FileSelectFile, RiotPath, 3, , Open a file, Text Documents (RiotClientServices.exe)
        RiotPath := StrReplace(RiotPath, "RiotClientServices.exe", "")
        GuiControl,, RiotPath, %RiotPath%
        Riot = %RiotPath%
    return

    ButtonEpic:
    Msgbox, %EpicPath%
    return

    ButtonMinecraft:
    return

; Save User Options ===============================================================================

GuiClose:
; Launchers
    Steam =     `nSteam = %Steam%
    Epic =      `nEpic = %Epic%
    GOG =       `nGOG = %GOG%
    Minecraft = `nMinecraft = %Minecraft%
    Nvidia =    `nNvidia = %Nvidia%                                                             ; WIP
    Battlenet = `nBattlenet = %Battlenet%
    Ryujinx =   `nRyujinx = %Ryujinx%
    Riot =      `nRiot = %Riot%

; Options
    Startup = `nStartup = %Startupis%


Featured = %Steam%%Epic%%GOG%%Minecraft%%Nvidia%%Battlenet%%Ryujinx%%Riot%

Content = [Path]%Featured%`n`n[Options]%Startup%

FileDelete, %UserOptions%
FileAppend, %Content%, %UserOptions%






; End ===========================================================================================
ExitApp
return