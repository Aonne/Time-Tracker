; Retreive Path ==========================================================================================
;return
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, GOG_path, %path%\user_options.ini, Path, GOG
    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    Loop, %GOG_path%\GalaxyClient*.*
{
    FileRead, acontent, %A_LoopFileFullPath%
    Fileappend, %acontent%, %Temp%\galaxy.temp
} 

; Clean ================================================================================================
    Loop, read, %Temp%\galaxy.temp,                             %Temp%\GOG_Galaxy1.temp
    {
        if InStr(A_LoopReadLine, "Launching process. Command")
        {
            line = %A_LoopReadLine%
            if inStr(line, "GalaxyUpdater.exe")
                line := ""
            if inStr(line, "Renderer.exe")
                line := ""
            if inStr(line, "SubSystem installer thread ")
                line := ""
            if inStr(line, "unins000.exe")
                line := ""

            if (line = "")
                continue

            YMD := SubStr(line, 1,10)
            HMS := SubStr(line, 12,8)
            rest := SubStr(line, 101)

            Fileappend, %YMD%`, %HMS%`, %rest%`n  
        }

        if InStr(A_LoopReadLine, " is closed")
        {
            line = %A_LoopReadLine%
            if inStr(line, "GalaxyUpdater.exe")
                line := ""
            if inStr(line, "Renderer.exe")
                line := ""
            if inStr(line, "SubSystem installer thread ")
                line := ""

            if (line = "")
                continue

            YMD := SubStr(line, 1,10)
            HMS := SubStr(line, 12,8)
            rest := SubStr(line, 72)

            Fileappend, %YMD%`, %HMS%`, %rest%`n  
        }    
    }

; Replace  ============================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy1.temp


    ;to do


FileAppend, %Clean%, %Temp%\GOG_Galaxy.log

;Sort===================================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy.log
    Sort, Clean, u

    FileDelete, %Temp%\GOG_Galaxy.log
    FileAppend, %Clean%, %Temp%\GOG_Galaxy.log

;Delete ================================================================================================
    FileDelete, %Temp%\*.temp
