#SingleInstance, Force

; Retreive Path ========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Playnite_Path, %path%user_options.ini, Path, Playnite
    Temp = %Path%\Temp


; Retrive Files ========================================================================================
    Filecopy, %Playnite_Path%\playnite.log, %Temp%\*.temp

; Clean ================================================================================================
    Loop, read, %Temp%\playnite.temp, %Temp%\playnite1.temp
    {
        if inStr(A_LoopReadLine, "INFO |GamesEditor:Started")
        {
            FileGetTime, LatestTime, %A_LoopFileFullPath%, M
            Formattime, LatestTime, %LatestTime%, yyyy
            Fileappend, %LatestTime%-%A_LoopReadLine%`n            
        }

        if inStr(A_LoopReadLine, "stopped after")
        {
            FileGetTime, LatestTime, %A_LoopFileFullPath%, M
            Formattime, LatestTime, %LatestTime%, yyyy
            FileAppend, %LatestTime%-%A_LoopReadLine%`n            
        }

    }

; Replace ==============================================================================================
    FileRead, Clean, %Temp%\playnite1.temp

    Clean := StrReplace(Clean, "|INFO |GamesEditor:Started", ",")
    Clean := StrReplace(Clean, " game.", ", Started")
    Clean := StrReplace(Clean, " stopped ", ", Stopped, ")
    Clean := StrReplace(Clean, "|INFO |GamesEditor:Game", ",")

FileAppend, %Clean%, %Temp%\Playnite.log

; Sort =================================================================================================
    FileRead, Clean, %Temp%\Playnite.log
    Sort, Clean, u

    FileDelete, %Temp%\Playnite.log
    FileAppend, %Clean%, %Temp%\Playnite.log

; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp