#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, NvidiaPath, %path%\user_options.ini, Path, Nvidia
    Temp = %Path%\Temp

; Retrive Files =========================================================================================
    FileCopy, %NvidiaPath%\console.log,             %Temp%\nvidia_actual.temp
    Filecopy, %NvidiaPath%\console.log.bak,         %Temp%\nvidia_previous.temp

    FileRead, Actual, %Temp%\nvidia_actual.temp
    FileRead, Previous, %Temp%\nvidia_previous.temp

    FileAppend, %Previous%`n%Actual%, %Temp%\nvidia.temp


; Clean ================================================================================================
    Loop, read, %Temp%\Nvidia.temp, %Temp%\Nvidia1.temp
    {
        if inStr(A_LoopReadLine, "loadSlot for game")
            {
                YMD := SubStr(A_LoopReadLine, 1,10)
                HMS := SubStr(A_LoopreadLine, 12,8)
                rest := SubStr(A_LoopReadLine, 24)
 
                Fileappend, %YMD%`, %HMS%%rest%`n   
            }

        ;if instr(A_LoopreadLine, "Current Game app exited") ; for some reason it was that when i installed geforce so idk
        ;    Fileappend, %A_LoopReadLine%`n

        if instr(A_LoopreadLine, "onGameAppExit") ;temp
            {
                YMD := SubStr(A_LoopReadLine, 1,10)
                HMS := SubStr(A_LoopreadLine, 12,8)
                rest := SubStr(A_LoopReadLine, 24)

                Fileappend, %YMD%`, %HMS%%rest%`n   
            }
    }

; Replace  ============================================================================================
    FileRead,  Clean, %Temp%\Nvidia1.temp

    StringReplace, Clean, Clean,`", , All
    Clean := StrReplace(Clean, "  INFO  osc/nvCameraService- loadSlot for game: ", ", Started,")
    Clean := StrReplace(Clean, "  INFO  osc/nvCameraService- onGameAppExit invoked. UIRunning = false ,app proc ID", ", Exited,")
    Clean := StrReplace(Clean, "\\", "")

    ; Exceptions
    Clean := StrReplace(Clean, "SteamLibrary", "")
    Clean := StrReplace(Clean, "_retail_", "")
    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, "steamappscommon", "")
    Clean := StrReplace(Clean, ".x64", "")

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

FileAppend, %Clean%, %Temp%\Nvidia.log

;Sort==================================================================================================
    FileRead,  Clean, %Temp%\Nvidia.log
    Sort, Clean, u

    FileDelete, %Temp%\Nvidia.log
    Fileappend, %Clean%, %Temp%\Nvidia.log

; Delete =========================================================================================
    FileDelete, %Temp%\*.temp