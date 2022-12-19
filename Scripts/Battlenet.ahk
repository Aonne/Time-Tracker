#Singleinstance, Force

; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "Battlenet")
                Battlenet_Path = %A_LoopReadLine%             
        }

    Battlenet_Path := StrReplace(Battlenet_Path, "Battlenet = ", "")
    Temp = %Path%\Temp


; Retreive Files =========================================================================================
    FileCreateDir, %Temp%

    Loop, %Battlenet_Path%\*.log
    {
        FileRead, aFileContents, %A_LoopFileFullPath%
        FileAppend, %aFileContents%, %Temp%\Battlenet_temp.txt
    }

; Clean ==================================================================================================
    Loop, read, %Temp%\Battlenet_temp.txt,                             %Temp%\Battlenet.txt
    {
        if InStr(A_LoopReadLine, "[InstallManager] {Main} Launched ")
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "[InstallManager] {Main} Game finished")
            Fileappend, %A_LoopReadLine%`n
    }
;Replace  ================================================================================================
    FileRead, Clean,                                                            %Temp%\Battlenet.txt

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

FileDelete,                                                                     %Temp%\Battlenet.txt
FileAppend, %Clean%,                                                            %Temp%\Battlenet.txt

;Sort====================================================================================================
    FileRead, Clean,                                                            %Temp%\Battlenet.txt
    Sort, Clean, u

    FileDelete,                                                                 %Temp%\Battlenet.txt
    FileAppend, %Clean%,                                                        %Temp%\Battlenet.txt

;Delete ==================================================================================================
    FileDelete, %Temp%\Battlenet_temp.txt