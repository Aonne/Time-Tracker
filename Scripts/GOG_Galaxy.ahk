; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "GOG")
                GOG_Path = %A_LoopReadLine%             
        }

    GOG_Path := StrReplace(GOG_Path, "GOG = ", "")
    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%
    FileCopy, %GOG_Path%\GalaxyClient.log, %Temp%\galaxy_temp.txt, 1

; Clean ================================================================================================
    Loop, read, %Temp%\galaxy_temp.txt,                             %Temp%\GOG_Galaxy.txt
    {
        if InStr(A_LoopReadLine, "Launching process. Command")
        {
            Fileappend, %A_LoopReadLine%`n
        }

        if InStr(A_LoopReadLine, "Tracking game session for")
        {
            Fileappend, %A_LoopReadLine%`n
        }    
    }
; Keep ================================================================================================
    FileRead, Keep,                                                 %Temp%\GOG_Galaxy.txt
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
    
    FileDelete, %Temp%\GOG_Galaxy.txt
    FileAppend, %e%, %Temp%\GOG_Galaxy.txt

    FileRead, Keep,                                                 %Temp%\GOG_Galaxy.txt
        i=0
        e:=""
        ToDelete=Dependencies    ;- skip this and next line


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
    
    FileDelete, %Temp%\GOG_Galaxy.txt
    FileAppend, %e%, %Temp%\GOG_Galaxy.txt

    FileRead, Keep,                                                 %Temp%\GOG_Galaxy.txt
        i=0
        e:=""
        ToDelete=CrashReporter.exe    ;- skip this and next line


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
    
    FileDelete, %Temp%\GOG_Galaxy.txt
    FileAppend, %e%, %Temp%\GOG_Galaxy.txt

    FileRead, Keep,                                                 %Temp%\GOG_Galaxy.txt
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
    
    FileDelete, %Temp%\GOG_Galaxy.txt
    FileAppend, %e%, %Temp%\GOG_Galaxy.txt
; Replace  ============================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy.txt

    Clean := StrReplace(Clean, "Information", "")
    Clean := StrReplace(Clean, "galaxy_client", "")
    Clean := StrReplace(Clean, ": Tracking game session for '", "")
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", "")
    Clean := StrReplace(Clean, "  (", ", ")
    Clean := StrReplace(Clean, ")", "")
    Clean := StrReplace(Clean, " Asynchronous", ", Asynchronous")


FileDelete, %Temp%\GOG_galaxy.txt
FileAppend, %Clean%, %Temp%\GOG_galaxy.txt

;Sort===================================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy.txt
    Sort, Clean, u

    FileDelete, %Temp%\GOG_Galaxy.txt
    FileAppend, %Clean%, %Temp%\GOG_Galaxy.txt

;Delete ================================================================================================
    FileDelete, %Temp%\galaxy_temp.txt