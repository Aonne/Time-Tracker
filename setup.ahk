#SingleInstance, Force

Loop, read, %A_ScriptDir%\options.ini 
{
    if InStr(A_LoopReadLine, "version")
    codeversion = %A_LoopReadLine%
}
codeversion := StrReplace(codeversion, "version = ", "")
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
Gui, destroy

; Path ============================================================================================
    StartupFolder =  C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    Scripts =   %A_ScriptDir%\Scripts
    UI = %A_ScriptDir%\UI

;Gui, Add, Picture, x0 y0 w1000 h1000 , %UI%\Background.jpg

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

    Gui, Add, Text, x102 y456 w390 h20 vGOGPath,
    Gui, Add, Button, x12 y450 w80 h30 , GOG
    Gui, Add, GroupBox, x2 y438 w500 h50

    Gui, Add, Text, x102 y506 w390 h20 vRiotPath,
    Gui, Add, Button, x12 y500 w80 h30 , Riot
    Gui, Add, GroupBox, x2 y488 w500 h50

    Gui, Add, Text, x102 y556 w390 h20 vMinecraftPath,
    Gui, Add, Button, x12 y550 w80 h30 , Minecraft
    Gui, Add, GroupBox, x2 y538 w500 h50

    Gui, Add, Text, x102 y606 w390 h20 vBattlenetPath,
    Gui, Add, Button, x12 y600 w80 h30 , Battlenet
    Gui, Add, GroupBox, x2 y588 w500 h50

    Gui, Add, Text, x102 y656 w390 h20 vOriginPath,
    Gui, Add, Button, x12 y650 w80 h30 , Origin
    Gui, Add, GroupBox, x2 y638 w500 h50

    Gui, Add, Text, x102 y706 w390 h20 vRyujinxPath, Please provide path
    Gui, Add, Button, x12 y700 w80 h30 , Ryujinx
    Gui, Add, GroupBox, x2 y688 w500 h50

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

    ; GOG
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "GOG")
            GOG = %A_LoopReadLine%
        }
        GOG := StrReplace(GOG, "GOG = ", "")
        GuiControl,, GOGPath, %GOG%

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

    ; Origin
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Origin")
            Origin = %A_LoopReadLine%
        }
        Origin := StrReplace(Origin, "Origin = ", "")
        GuiControl,, OriginPath, WIP         %Origin%                                                         ; WIP

    ; Ryujinx
        Loop, read, %UserOptions% 
        {
            if InStr(A_LoopReadLine, "Ryujinx")
            Ryujinx = %A_LoopReadLine%
        }
        Ryujinx := StrReplace(Ryujinx, "Ryujinx = ", "")
        GuiControl,, RyujinxPath, WIP         %Ryujinx%                                                        ; WIP




Gui, Show,, Time Tracker by Aonne. v%codeversion%
; x1396 y282 h634 w525
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

    ButtonRyujinx:
        FileSelectFile, RyujinxPath, 3, , Open a file, Text Documents (Ryujinx.exe)
        RyujinxPath := StrReplace(RyujinxPath, "Ryujinx.exe", "Logs")
        GuiControl,, RyujinxPath, WIP         %Ryujinx%                                                        ; WIP
        Loop, read, %UserOptions%
        {
            InStr(A_LoopReadLine, "Ryujinx")
            Ryujinx = %RyujinxPath%
        }
    return    

    ButtonEpic:
    Msgbox, %EpicPath%
    return

    ButtonGOG:
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