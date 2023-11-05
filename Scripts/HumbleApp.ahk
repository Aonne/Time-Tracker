#SingleInstance, Force

; Retreive Path ========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Humble_Path, %path%user_options.ini, Path, HumbleApp
    Temp = %Path%\Temp


; Retrive Files ========================================================================================
    Filecopy, %Humble_Path%\main.log, %Temp%\humble.temp

; Clean ================================================================================================
    Loop, read, %Temp%\humble.temp, %Temp%\HumbleApp.log
    {
        if inStr(A_LoopReadLine, "[info]  network request")
        {
            Fileappend, %A_LoopReadLine%`n            
        }
    }

; Replace ==============================================================================================
/*
    FileRead, Clean, %Temp%\playnite1.temp

    Clean := StrReplace(Clean, "|INFO |GamesEditor:Started", ",")
    Clean := StrReplace(Clean, " game.", ", Started")
    Clean := StrReplace(Clean, " stopped ", ", Stopped, ")
    Clean := StrReplace(Clean, "|INFO |GamesEditor:Game", ",")

FileAppend, %Clean%, %Temp%\Playnite.log
*/
; Sort =================================================================================================
    FileRead, Clean, %Temp%\HumbleApp.log
    Sort, Clean, u

    FileDelete, %Temp%\HumnleApp.log
    FileAppend, %Clean%, %Temp%\HumbleApp.log

; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp