; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Epic_Path, %path%\user_options.ini, Path, Epic
    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    Loop, %Epic_Path%\*.log
    {
    FileRead, aFileContents, %A_LoopFileFullPath% 

    FileAppend, %aFileContents%, %Temp%\Epic.temp
    }

; Clean ================================================================================================
    Loop, read, %Temp%\Epic.temp,                             %Temp%\Epic1.temp
    {
        if InStr(A_LoopReadLine, "Launching app")
        {
            trim := SubStr(A_LoopReadLine, 1, InStr(A_LoopReadLine,"commandline") - 1)

            Year := SubStr(trim, 2, 4)
            Month := SubStr(trim, 7, 2)
            Day := SubStr(trim, 10, 2)
            Hour := SubStr(trim, 13, 2)
            Min := SubStr(trim, 16, 2)
            Sec := SubStr(trim, 19, 2)
            rest := SubStr(trim, 75)

            Fileappend, %Year%-%Month%-%Day%`, %Hour%:%Min%:%Sec%`, Started`, %rest%`n
        }

        if InStr(A_LoopReadLine, "moved from foreground to dead")
        {
            trim = %A_LoopReadLine%

            Year := SubStr(trim, 2, 4)
            Month := SubStr(trim, 7, 2)
            Day := SubStr(trim, 10, 2)
            Hour := SubStr(trim, 13, 2)
            Min := SubStr(trim, 16, 2)
            Sec := SubStr(trim, 19, 2)
            rest := SubStr(trim, 65)

            Fileappend, %Year%-%Month%-%Day%`, %Hour%:%Min%:%Sec%`, Stopped`, %rest%`n
        }    
    }



;Replace  =============================================================================================
    FileRead, Clean, %Temp%\Epic1.temp

    Clean := StrReplace(Clean, "/", "")
    Clean := StrReplace(Clean, "\", "")

    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", ", ")
    Clean := StrReplace(Clean, "FCommunityPortalLaunchAppTask: Launching app '", "")
    Clean := StrReplace(Clean, "LogRunningAppService: Display: App ", "")
    Clean := StrReplace(Clean, "/Epic Games/", "")
    Clean := StrReplace(Clean, "\Epic Games\", "")
    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, "' with ", "")
    Clean := StrReplace(Clean, " moved from foreground to dead", "")
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
   


FileAppend, %Clean%, %Temp%\Epic.log

;Sort==================================================================================================
    FileRead,  Clean, %Temp%\Epic.log
    Sort, Clean, u

    FileDelete, %Temp%\Epic.log
    Fileappend, %Clean%, %Temp%\Epic.log

; Delete ==============================================================================================
    FileDelete, %Temp%\*.temp