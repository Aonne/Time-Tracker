#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;https://github.com/Haoose/UPLAY_GAME_ID

; Retrieve Path ========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Ubisoft_Path, %Path%\user_options.ini, Path, Ubisoft
    Temp = %Path%\Temp
 
; Retrieve Files ========================================================================================
    FileCopy, %Ubisoft_Path%\launcher_log.txt, %Temp%\ubisoft.temp

; Clean ================================================================================================
    Loop, read, %Temp%\ubisoft.temp, %Temp%\ubisoft1.temp
    {
        if inStr(A_LoopReadLine, "has been started with product id")
        {
            line := SubStr(A_LoopReadLine, 1, InStr(A_LoopReadLine,"(branch:") - 1)

            YMD := SubStr(line, 10,10)
            HMS := SubStr(line, 21,8)
            rest := SubStr(line, 168)
            for_Stop = %rest% ; need to find ubisoft game ids cause huh
            if (rest = "")
                continue

            Fileappend, %YMD%`, %HMS%`, Started`, %rest%`n 
        }

        if inStr(A_LoopReadLine, "disconnected")
        {
            if inStr(A_LoopReadLine, "ApiProcessConnection")
            {
                line = %A_LoopReadLine%
                if (line = "")
                    continue

                YMD := SubStr(line, 10,10)
                HMS := SubStr(line, 21,8)

                Fileappend, %YMD%`, %HMS%`, Stopped`, %for_stop%`n 
            }         
        }
    }

; Replace ==============================================================================================
    FileRead, Clean, %Temp%\ubisoft1.temp
/*
    Clean := StrReplace(Clean, "INFO       ApiProcessConnection.cpp (299)                   Game with process id ", "")
    Clean := StrReplace(Clean, "INFO       ApiProcessConnection.cpp (136)                   Game with process id ", "")
    Clean := StrReplace(Clean, " has been started with product id ", ", Game = ")
    Clean := StrReplace(Clean, " (branch: 'default').", "")
    Clean := StrReplace(Clean, "disconnected.", "")
*/
FileAppend, %Clean%, %Temp%\Ubisoft.log

; Sort =================================================================================================
    FileRead, Clean, %Temp%\Ubisoft.log
    Sort, Clean, u

    FileDelete, %Temp%\Ubisoft.log
    Fileappend, %Clean%, %Temp%\Ubisoft.log

; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp
