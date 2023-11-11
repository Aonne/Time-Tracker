#SingleInstance, Force


IniRead, codeversion, %A_ScriptDir%\options.ini, Options, version
Gui, destroy

; Path ============================================================================================
    StartupFolder =  C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    Scripts =   %A_ScriptDir%\Scripts
    UI = %A_ScriptDir%\UI


Gui, Add, Button, x50 y9 w80 h30, Logs
Gui, Add, Button, x150 y9 w80 h30, DoStuff                                                              ; WIP
Gui, Add, CheckBox, x250 y9 w130 h30 vstartupvar gStartup, Launch at start up

; Featured =========================================================================================
    Gui, Add, Text, x102 y56 w390 h20 vNvidiaPath,
    Gui, Add, Button, x12 y50 w80 h30 , Nvidia
    Gui, Add, GroupBox, x2 y38 w500 h50

    Gui, Add, Text, x102 y106 w390 h20 vSteamPath,
    Gui, Add, Button, x12 y100 w80 h30 , Steam
    Gui, Add, GroupBox, x2 y88 w500 h50

    Gui, Add, Text, x102 y156 w390 h20 vEpicPath,
    Gui, Add, Button, x12 y150 w80 h30 , Epic
    Gui, Add, GroupBox, x2 y138 w500 h50

    Gui, Add, Text, x102 y206 w390 h20 vGOGPath,
    Gui, Add, Button, x12 y200 w80 h30 , GOG
    Gui, Add, GroupBox, x2 y188 w500 h50

    Gui, Add, Text, x102 y256 w390 h20 vRiotPath,
    Gui, Add, Button, x12 y250 w80 h30 , Riot
    Gui, Add, GroupBox, x2 y238 w500 h50

    Gui, Add, Text, x102 y306 w390 h20 vMinecraftPath,
    Gui, Add, Button, x12 y300 w80 h30 , Minecraft
    Gui, Add, GroupBox, x2 y288 w500 h50

    Gui, Add, Text, x102 y356 w390 h20 vBattlenetPath,
    Gui, Add, Button, x12 y350 w80 h30 , Battlenet
    Gui, Add, GroupBox, x2 y338 w500 h50

    Gui, Add, Text, x102 y406 w390 h20 vEADesktopPath,
    Gui, Add, Button, x12 y400 w80 h30 , EADesktop
    Gui, Add, GroupBox, x2 y388 w500 h50

    Gui, Add, Text, x102 y456 w390 h20 vMultiMCPath,
    Gui, Add, Button, x12 y450 w80 h30 , MultiMC
    Gui, Add, GroupBox, x2 y438 w500 h50

    Gui, Add, Text, x102 y506 w390 h20 vPrismPath,
    Gui, Add, Button, x12 y500 w80 h30 , Prism
    Gui, Add, GroupBox, x2 y488 w500 h50

    Gui, Add, Text, x102 y556 w390 h20 vPlaynitePath,
    Gui, Add, Button, x12 y550 w80 h30 , Playnite
    Gui, Add, GroupBox, x2 y538 w500 h50
/*
    Gui, Add, Text, x102 y606 w390 h20 vHumbleAppPath,
    Gui, Add, Button, x12 y600 w80 h30 , HumbleApp
    Gui, Add, GroupBox, x2 y588 w500 h50
*/
    Gui, Add, Text, x102 y606 w390 h20 vUbisoftPath,
    Gui, Add, Button, x12 y600 w80 h30 , Ubisoft
    Gui, Add, GroupBox, x2 y588 w500 h50

; Retreive User Options ============================================================================
    UserOptions = %A_ScriptDir%\user_options.ini

    ; Startup
        IniRead, IsStartupOn, %UserOptions%, Options, Startup
        if IsStartupOn = 1
        {
            GuiControl,, Startupvar, 1
            Startupis = 1
        }
        else
        {
            GuiControl,, Startupvar, 0
            Startupis = 0            
        }

    ; Nvidia       
        IniRead, Nvidia, %UserOptions%, Path, Nvidia
        GuiControl,, NvidiaPath, %Nvidia%
        if not FileExist(Nvidia)
            Guicontrol,, NvidiaPath, NOT FOUND

    ; Steam       
        IniRead, Steam, %UserOptions%, Path, Steam
        GuiControl,, SteamPath, %Steam%
        if not FileExist(Steam)
            Guicontrol,, SteamPath, NOT FOUND

    ; Epic
        IniRead, Epic, %UserOptions%, Path, Epic
        GuiControl,, EpicPath, %Epic%

    ; GOG
        IniRead, GOG, %UserOptions%, Path, GOG
        GuiControl,, GOGPath, %GOG%
        if not FileExist(GOG)
            Guicontrol,, GOGPath, NOT FOUND

    ; Minecraft
        IniRead, Minecraft, %UserOptions%, Path, Minecraft
        GuiControl,, MinecraftPath, %Minecraft%
        if not FileExist(Minecraft)
            Guicontrol,, MinecraftPath, NOT FOUND

    ; Riot
        IniRead, Riot, %UserOptions%, Path, Riot
        GuiControl,, RiotPath, %Riot%
        if not FileExist(Riot)
            Guicontrol,, RiotPath, NOT FOUND

    ; Battlenet
        IniRead, Battlenet, %UserOptions%, Path, Battlenet
        GuiControl,, BattlenetPath, %Battlenet%
        if not FileExist(Battlenet)
            Guicontrol,, BattlenetPath, NOT FOUND

    ; EADesktop
        IniRead, EADesktop, %UserOptions%, Path, EADesktop
        GuiControl,, EADesktopPath, %EADesktop%
        if not FileExist(EADesktop)
            Guicontrol,, EADesktopPath, NOT FOUND        

    ; MultiMc
        IniRead, MultiMC, %UserOptions%, Path, MultiMC
        GuiControl,, MultiMCPath, %MultiMC%
        if not FileExist(MultiMC)
            Guicontrol,, MultiMCPath, NOT FOUND

    ; Prism (minecraft)
        IniRead, Prism, %UserOptions%, Path, Prism
        GuiControl,, PrismPath, %Prism%
        if not FileExist(Prism)
            Guicontrol,, PrismPath, NOT FOUND

    ; Playnite
        IniRead, Playnite, %UserOptions%, Path, Playnite
        GuiControl,, PlaynitePath, %Playnite%
        if not FileExist(Playnite)
            Guicontrol,, PlaynitePath, NOT FOUND
/*
    ; HumbleApp
        IniRead, HumbleApp, %UserOptions%, Path, HumbleApp
        GuiControl,, HumbleAppPath, %HumbleApp%
        if not FileExist(HumbleApp)
            Guicontrol,, HumbleAppPath, NOT FOUND
*/
    ; Ubisoft
        IniRead, Ubisoft, %UserOptions%, Path, Ubisoft
        GuiControl,, UbisoftPath, %Ubisoft%
        if not FileExist(Ubisoft)
            Guicontrol,, UbisoftPath, NOT FOUND


    ; first time user
        eh = %A_ScriptDir%\Temp
        if not fileExist(eh)
            GuiControl, Disable, DoStuff

Gui, Show,, Time Tracker by Aonne. v%codeversion%
Return


; What Things Do =================================================================================

    ButtonLogs:
        Run, %A_ScriptDir%\Temp
    return

    ButtonDoStuff:
        RunWait, %A_ScriptDir%\loader.ahk
        Msgbox, Done!
    return
        

    Startup:
        Gui, Submit, NoHide
        ifEqual %startupvar% ; Checked
        {
            FileCreateShortcut, %A_ScriptDir%\loader.ahk, %StartupFolder%\Time Tracker by Aonne.lnk
            Startupis = 1
        }
        ifNotEqual %startupvar% ; Unchecked
        {
            FileDelete, %StartupFolder%\Time Tracker by Aonne.lnk
            Startupis = 0
        }
        return

    ButtonSteam:
        FileSelectFile, SteamPath, 3, , Steam.exe
        if FileExist(SteamPath)
        {
            SteamPath := StrReplace(SteamPath, "steam.exe", "logs")
            GuiControl,, SteamPath, %SteamPath%
            Steam = %SteamPath%      
            iniWrite, %Steam%, %UserOptions%, Path, Steam                    
        }
    return

    ButtonRiot:
        FileSelectFile, RiotPath, 3, , Open a file, RiotClientServices.exe
        if FileExist(RiotPath)
        {
            RiotPath := StrReplace(RiotPath, "RiotClientServices.exe", "")
            GuiControl,, RiotPath, %RiotPath%
            Riot = %RiotPath%      
            iniWrite, %Riot%, %UserOptions%, Path, Riot      
        }
    return

    ButtonNvidia:
        Run, %Nvidia%
    return

    ButtonEpic:
        Run, %Epic%
    return

    ButtonGOG:
        Run, %GOG%
    return

    ButtonBattlenet:
        FileSelectFile, BattlenetPath, 3, , Open a file, Battlenet.exe
        if FileExist(BattlenetPath)
        {
            Guicontrol,, BattlenetPath, %BattlenetPath%
            Battlenet = %BattlenetPath%       
            iniWrite, %Battlenet%, %UserOptions%, Path, Battlenet       
        }
    return

    ButtonMinecraft:
        Run, %Minecraft%
    return

    ButtonEADesktop:
        Run, %EADesktop%
    return

    ButtonMultiMC:
        FileSelectFile, MultiMCPath, 3, , Open a file, MultiMC.exe
        IF FileExist(MultiMCPath)
        {
            MultiMCPath := StrReplace(MultiMCPath, "MultiMC.exe", "instances")
            GuiControl,, MultiMCPath, %MultiMCPath%
            MultiMC = %MultiMCPath%            
        }
    return

    ButtonPrism:
        FileSelectFile, PrismPath, 3, , Open a file, prismlauncher.exe
        if FileExist(PrismPath)
        {
            PrismPath := StrReplace(PrismPath, "prismlauncher.exe", "instances")
            GuiControl,, PrismPath, %PrismPath%
            Prism = %PrismPath%            
        }
    return

    ButtonPlaynite:
        FileSelectFile, PlaynitePath, 3, , Open a file, Playnite.DesktopApp.exe
        IF FileExist(PlaynitePath)
        {
            PlaynitePath := StrReplace(PlaynitePath, "\Playnite.DesktopApp.exe", "")
            GuiControl,, PlaynitePath, %PlaynitePath%
            Playnite = %PlaynitePath%            
        }
    return

    ButtonUbisoft:
        FileSelectFile, UbisoftPath, 3, , Open a file, UbisoftConnect.exe
        if FileExist(UbisoftPath)
        {
            UbisoftPath := StrReplace(UbisoftPath, "\UbisoftConnect.exe", "\logs")
            GuiControl,, UbisoftPath, %UbisoftPath%
            Ubisoft = %UbisoftPath%        
            iniWrite, %Ubisoft%, %UserOptions%, Path, Ubisoft
        }
    return
/*
    ButtonHumbleApp:
        Run, %HumbleApp%
    return
*/

; End ===========================================================================================
GuiClose:
    iniWrite, %Startupis%, %UserOptions%, Options, Startup
ExitApp
return