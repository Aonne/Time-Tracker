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

    FileCopy, %GOG_Path%\GalaxyClientService.log, %Temp%\galaxy_temp.txt, 1

; Clean ================================================================================================
    Loop, read, %Temp%\galaxy_temp.txt,                             %Temp%\galaxy_temp2.txt
    {
        if InStr(A_LoopReadLine, "Service starting")
            Fileappend, %A_LoopReadLine%`n
        
        if InStr(A_LoopReadLine, "Service stopped")
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "Created elevated process")
            Fileappend, %A_LoopReadLine%`n
    }

; Keep ================================================================================================
    FileRead, Keep,                                                 %Temp%\galaxy_temp2.txt
    ;GalaxyUpdater
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

    FileAppend, %e%, %Temp%\galaxy_temp3.txt
    FileRead, bouille, %Temp%\galaxy_temp3.txt

    ;GOG Galaxy\Dependencies
        i=0
        e:=""
        ToDelete=GOG Galaxy\Dependencies    ;- skip this and next line


        ;-------------------
        Loop,parse,bouille,`n,`r
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

    FileAppend, %e%, %Temp%\GOG_Galaxy.txt



;Replace  =============================================================================================
    FileRead, Clean, %Temp%\GOG_Galaxy.txt

    StringReplace, Clean, Clean,`", , All

    Clean := StrReplace(Clean, " [Information][ (0)] [TID ", ", ")
    Clean := StrReplace(Clean, " [Information][#1 (1)] [TID ", ", ")
    Clean := StrReplace(Clean, "][galaxy_service]: Service starting", ", Started")
    Clean := StrReplace(Clean, "][galaxy_service]: Service stopped", ", Ended")
    Clean := StrReplace(Clean, "][galaxy_service]: Created elevated process (", ", ")
    Clean := StrReplace(Clean, "id:", "")
    Clean := StrReplace(Clean, ") as user. Process path: ", "")
    Clean := StrReplace(Clean, " command line ", "")
    Clean := StrReplace(Clean, "  , working directory: ", "")

    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, ".", ":")
    Clean := StrReplace(Clean, "\", ", ")
    Clean := StrReplace(Clean, "_", " ")

; Disks ===========================================================================
        Clean := StrReplace(Clean, "A:", "")
        Clean := StrReplace(Clean, "B:", "")
        Clean := StrReplace(Clean, "C:", "")
        Clean := StrReplace(Clean, "D:", "")
        Clean := StrReplace(Clean, "E:", "")
        Clean := StrReplace(Clean, "F:", "")
        Clean := StrReplace(Clean, "G:", "")
        Clean := StrReplace(Clean, "H:", "")
        Clean := StrReplace(Clean, "I:", "")
        Clean := StrReplace(Clean, "J:", "")
        Clean := StrReplace(Clean, "K:", "")
        Clean := StrReplace(Clean, "L:", "")
        Clean := StrReplace(Clean, "M:", "")
        Clean := StrReplace(Clean, "N:", "")
        Clean := StrReplace(Clean, "O:", "")
        Clean := StrReplace(Clean, "P:", "")
        Clean := StrReplace(Clean, "Q:", "")
        Clean := StrReplace(Clean, "R:", "")
        Clean := StrReplace(Clean, "S:", "")
        Clean := StrReplace(Clean, "T:", "")
        Clean := StrReplace(Clean, "U:", "")
        Clean := StrReplace(Clean, "V:", "")
        Clean := StrReplace(Clean, "W:", "")
        Clean := StrReplace(Clean, "X:", "")
        Clean := StrReplace(Clean, "Y:", "")
        Clean := StrReplace(Clean, "Z:", "")




FileDelete,                                                     %Temp%\GOG_Galaxy.txt
Fileappend,    %Clean%,                                         %Temp%\GOG_Galaxy.txt

;Sort==================================================================================================
    FileRead,  Clean,                                           %Temp%\GOG_Galaxy.txt
    Sort, Clean, u

    FileDelete,                                                 %Temp%\GOG_Galaxy.txt
    Fileappend, %Clean%,                                        %Temp%\GOG_Galaxy.txt

;Delete ===============================================================================================

FileDelete, %Temp%\galaxy_temp.txt
FileDelete, %Temp%\galaxy_temp2.txt
FileDelete, %Temp%\galaxy_temp3.txt

