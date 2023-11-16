#Singleinstance, Force

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
        if InStr(A_LoopReadLine, "[InstallManager] {Main} Launched ")
            {
                YMD := SubStr(A_LoopReadLine, 1,10)
                HMS := SubStr(A_LoopreadLine, 12,8)
                rest := SubStr(A_LoopReadLine, 27)

                Fileappend, %YMD%`, %HMS%%rest%`n   
            }

        if InStr(A_LoopReadLine, "[InstallManager] {Main} Game finished")
        {
            YMD := SubStr(A_LoopReadLine, 1,10)
            HMS := SubStr(A_LoopreadLine, 12,8)
            rest := SubStr(A_LoopReadLine, 27)

            Fileappend, %YMD%`, %HMS%%rest%`n   
        }
    }
;Replace  ================================================================================================
    FileRead, Clean, %Temp%\Battlenet1.temp

    Clean := StrReplace(Clean, " [InstallManager] {Main} Game finished versioning prometheus", ", Ended")
    Clean := StrReplace(Clean, " [InstallManager] {Main} Launched", ", Started,")
    Clean := StrReplace(Clean, " [InstallManager] {Main} Game finished versioning battle.net", ", Battlenet launching probably")
    Clean := StrReplace(Clean, "I ", "")
    Clean := StrReplace(Clean, "D ", "")
    Clean := StrReplace(Clean, "/", "")
    Clean := StrReplace(Clean, "_retail_", ", ")
    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, " with args: -uiprometheus, pid: ", ", ")

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

FileAppend, %Clean%, %Temp%\Battlenet.log

;Sort====================================================================================================
    FileRead, Clean, %Temp%\Battlenet.log
    Sort, Clean, u

    FileDelete, %Temp%\Battlenet.log
    FileAppend, %Clean%, %Temp%\Battlenet.log

;Delete ==================================================================================================
    FileDelete, %Temp%\*.temp