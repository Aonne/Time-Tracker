; Path ==============================================================================================
    Scripts =   %A_ScriptDir%\Scripts
    Options =   %A_ScriptDir%\options.ini
    User =      %A_ScriptDir%\user_options.ini
    Startup =  C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    FileCreateDir,  %A_ScriptDir%\Temp

; Check first install ===============================================================================
    if !FileExist(User)
    {
        FileRead, UserOptions, %Options%
        StringReplace, UserOptions, UserOptions,`Username, %A_UserName%, All
        FileAppend, %UserOptions%, %User%
        Msgbox, Hey, looks like it's your first time using this program!`nPlease register the path of launchers that have their box's empty, dont mind the others.
        RunWait, %A_ScriptDir%\setup.ahk
        ;FileCreateShortcut, %A_ScriptDir%\Time Tracker.ahk, %Startup%\Time Tracker by Aonne.lnk
    }

IniRead, version, %Options%, Options, version
WinWaitClose, Time Tracker by Aonne %version% ; Let setup close first
            
; Run Scripts =======================================================================================
    Loop %Scripts%\*.ahk
    Run %A_LoopFileFullPath% 





ExitApp
return
