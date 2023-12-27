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
            day := SubStr(A_LoopReadLine, 1,2)
            month := SubStr(A_LoopReadLine, 4,2)
            Htime := SubStr(A_LoopreadLine, 7, 8)
            rest := SubStr(A_LoopReadLine, 19)
            if (rest = "")
                continue

            FileGetTime, year, %A_LoopFileFullPath%, M
            Formattime, year, %year%, yyyy
            Fileappend, %year%-%month%-%day%`, %Htime%`, Started`, %rest%`n              
        }

        if inStr(A_LoopReadLine, "stopped after")
        {
            day := SubStr(A_LoopReadLine, 1,2)
            month := SubStr(A_LoopReadLine, 4,2)
            Htime := SubStr(A_LoopreadLine, 7, 8)
            rest := SubStr(A_LoopReadLine, 19)
            if (rest = "")
                continue
            
            FileGetTime, year, %A_LoopFileFullPath%, M
            Formattime, year, %year%, yyyy
            Fileappend, %year%-%month%-%day%`, %Htime%`, Stopped`, %rest%`n             
        }

    }

; Replace ==============================================================================================
    FileRead, Clean, %Temp%\playnite1.temp

    Clean := StrReplace(Clean, "|INFO |GamesEditor:Started ", "")
    Clean := StrReplace(Clean, " game.", "")
    Clean := StrReplace(Clean, " stopped ", ", ")
    Clean := StrReplace(Clean, "|INFO |GamesEditor:Game ", "")

FileAppend, %Clean%, %Temp%\Playnite.log

; Sort =================================================================================================
    FileRead, Clean, %Temp%\Playnite.log
    Sort, Clean, u

    FileDelete, %Temp%\Playnite.log
    FileAppend, %Clean%, %Temp%\Playnite.log

; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp
