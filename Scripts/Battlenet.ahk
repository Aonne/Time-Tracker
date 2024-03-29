#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Battlenet_Path, %path%\user_options.ini, Path, Battlenet
    Temp = %Path%\Temp

; Retreive Files =========================================================================================
    FileCreateDir, %Temp%

    Loop, %Battlenet_Path%\*.log
    {
        FileRead, aFileContents, %A_LoopFileFullPath%
        FileAppend, %aFileContents%, %Temp%\Battlenet.temp
    }

; Clean ==================================================================================================
    Loop, read, %Temp%\Battlenet.temp, %Temp%\Battlenet1.temp
    {
        if InStr(A_LoopReadLine, "{Main} Game is running: ")
        {
            YMD := SubStr(A_LoopReadLine, 3, 10)
            HMS := SubStr(A_LoopReadLine, 14, 8)
            rest := SubStr(A_LoopReadLine, 71)
            if (rest = "")
                continue
            Fileappend,  %YMD%`, %HMS%`, Started`, %rest%`n   
        }

        if InStr(A_LoopReadLine, "{Main} Game is no longer running: ")
        {
            YMD := SubStr(A_LoopReadLine, 3, 10)
            HMS := SubStr(A_LoopReadLine, 14, 8)
            rest := SubStr(A_LoopReadLine, 81)
            if (rest = "")
                continue
            Fileappend,  %YMD%`, %HMS%`, Stopped`, %rest%`n  
        }
    }

; Replace  ============================================================================================
    FileRead,  Clean, %Temp%\Battlenet1.temp

    Clean := StrReplace(Clean, "prometheus", "Overwatch 2") ; why overwatch why

    Fileappend, %Clean%, %Temp%\Battlenet.log

;Sort==================================================================================================
    FileRead,  Clean, %Temp%\Battlenet.log
    Sort, Clean, u

    FileDelete, %Temp%\Battlenet.log
    Fileappend, %Clean%, %Temp%\Battlenet.log

; Delete =========================================================================================
    FileDelete, %Temp%\*.temp
