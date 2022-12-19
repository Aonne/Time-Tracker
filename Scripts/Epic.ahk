; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "Epic")
                Epic_Path = %A_LoopReadLine%              
        }

    Epic_Path := StrReplace(Epic_Path, "Epic = ", "")
    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    Loop, %Epic_Path%\*.log
    {
    FileRead, aFileContents, %A_LoopFileFullPath% 

    FileAppend, %aFileContents%, %Temp%\Epic_temp.txt
    }

; Clean ================================================================================================
    Loop, read, %Temp%\Epic_temp.txt,                             %Temp%\Epic.txt
    {
        if InStr(A_LoopReadLine, "Launching app")
        {
            trim := SubStr(A_LoopReadLine, 1, InStr(A_LoopReadLine,"commandline") - 1)
            Fileappend, %trim%`n
        }

        if InStr(A_LoopReadLine, "moved from foreground to dead")
        {
            Fileappend, %A_LoopReadLine%`n
        }    
    }

;Replace  =============================================================================================
    FileRead, Clean, %Temp%\Epic.txt
    
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", ", ")
    Clean := StrReplace(Clean, "FCommunityPortalLaunchAppTask: Launching app '", "")
    Clean := StrReplace(Clean, "LogRunningAppService: Display: App ", "")
    Clean := StrReplace(Clean, "/Epic Games/", "")
    Clean := StrReplace(Clean, "\Epic Games\", "")
    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, "' with ", ", Started")
    Clean := StrReplace(Clean, " moved from foreground to dead", ", Ended")
    Clean := StrReplace(Clean, "-", " ")
    Clean := StrReplace(Clean, ".", "-")

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
   

FileDelete, %Temp%\Epic.txt
FileAppend, %Clean%, %Temp%\Epic.txt




;Sort==================================================================================================
    FileRead,  Clean,                                           %Temp%\Epic.txt
    Sort, Clean, u

    FileDelete,                                                 %Temp%\Epic.txt
    Fileappend, %Clean%,                                        %Temp%\Epic.txt

; Delete ==============================================================================================

    FileDelete, %Temp%\Epic_temp.txt