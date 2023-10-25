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
            Fileappend, %A_LoopReadLine%`n
        }

        if InStr(A_LoopReadLine, "Launching process. Command")
        {
            Fileappend, %A_LoopReadLine%`n
        }

        if InStr(A_LoopReadLine, " is closed")
        {
            Fileappend, %A_LoopReadLine%`n
        }    
    }
; Keep ================================================================================================
    FileRead, Keep,                                                 %Temp%\GOG_Galaxy1.temp
        i=0
        e:=""
        ToDelete=GalaxyUpdater.exe    ;- skip this and next line


        ;-------------------
        Loop,parse,Keep,`n,`r
        {
        x:=a_loopfield
        if (x="")
        continue
        if (i=1)
        {
        i=0
        continue
        } 
        if x contains %ToDelete%
        {
        i=1
        continue
        }

        e .= x . "`r`n"
        }
    
    FileAppend, %e%, %Temp%\GOG_Galaxy2.temp

    FileRead, Keep,                                                 %Temp%\GOG_Galaxy2.temp
        i=0
        e:=""
        ToDelete=Renderer.exe    ;- skip this and next line


        ;-------------------
        Loop,parse,Keep,`n,`r
        {
        x:=a_loopfield
        if (x="")
        continue
        if (i=1)
        {
        i=0
        continue
        } 
        if x contains %ToDelete%
        {
        i=1
        continue
        }

        e .= x . "`r`n"
        }
    
    FileAppend, %e%, %Temp%\GOG_Galaxy3.temp

    FileRead, Keep,                                                 %Temp%\GOG_Galaxy3.temp
        i=0
        e:=""
        ToDelete=SubSystem installer thread    ;- skip this and next line


        ;-------------------
        Loop,parse,Keep,`n,`r
        {
        x:=a_loopfield
        if (x="")
        continue
        if (i=1)
        {
        i=0
        continue
        } 
        if x contains %ToDelete%
        {
        i=1
        continue
        }

        e .= x . "`r`n"
        }
    
    FileAppend, %e%, %Temp%\GOG_Galaxy4.temp
; Replace  ============================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy4.temp

    Clean := StrReplace(Clean, "Information", "")
    Clean := StrReplace(Clean, "galaxy_client", "")
    Clean := StrReplace(Clean, "Asynchronous Process Thread", "")
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", "")
    Clean := StrReplace(Clean, "  (", ", ")
    Clean := StrReplace(Clean, ")", "")
    Clean := StrReplace(Clean, "{", "")
    Clean := StrReplace(Clean, "}", "")
    Clean := StrReplace(Clean, "\", "")

    Clean := StrReplace(Clean, ": Launching process. Command: F:Cyberpunk 2077binx64Cyberpunk2077.exe, Initial Directory: F:Cyberpunk 2077, Elevation Mode: DontChange, Arguments:   , Success Range: Zero.", "Cyberpunk, Started")
    Clean := StrReplace(Clean, ": The game 'gog_1423049311' is closed.", ", Cyberpunk, Ended")
    ;Clean := StrReplace(Clean, " Asynchronous", ", Asynchronous")



FileAppend, %Clean%, %Temp%\GOG_Galaxy.log

;Sort===================================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy.log
    Sort, Clean, u

    FileDelete, %Temp%\GOG_Galaxy.log
    FileAppend, %Clean%, %Temp%\GOG_Galaxy.log

;Delete ================================================================================================
    FileDelete, %Temp%\*.temp