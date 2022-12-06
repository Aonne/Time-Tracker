; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "Nvidia")
                NVIDIA_Path = %A_LoopReadLine%             
        }

    NVIDIA_Path := StrReplace(NVIDIA_Path, "Nvidia = ", "")
    Temp = %Path%\Temp
    

; Retreive Files =========================================================================================
    FileCreateDir,  %Temp%

    FileCopy,       %NVIDIA_Path%\console.log.bak,                  %Temp%\previous.log
    FileCopy,       %NVIDIA_Path%\console.log,                      %Temp%\actual.log

    FileRead,       Previous,                                       %Temp%\previous.log
    FileRead,       Actual,                                         %Temp%\actual.log

    Fileappend,     %Previous% `n%Actual%,                          %Temp%\Nvidia_temp.log

; Clean ================================================================================================
    Loop, read, %Temp%\Nvidia_temp.log,                             %Temp%\Nvidia.txt
    {
        if InStr(A_LoopReadLine, "onAppStarted")
            Fileappend, %A_LoopReadLine%`n
        
        if InStr(A_LoopReadLine, "loadSlot for game")
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "app exited")
           Fileappend, %A_LoopReadLine%`n
    }
    
;Replace  =============================================================================================
    FileRead,           Clean,                                  %Temp%\Nvidia.txt
    StringReplace, Clean, Clean,`", , All
    StringReplace, Clean, Clean,`{, , All

    Clean := StrReplace(Clean, ": ", "")
    Clean := StrReplace(Clean, "  ", "")
    Clean := StrReplace(Clean, "\", "")

    Clean := StrReplace(Clean, "INFOosc/octoolService- onAppStarted ", ", Started")    
    Clean := StrReplace(Clean, "INFOosc/nvCameraService- loadSlot for game ", "")
    Clean := StrReplace(Clean, "INFOosc/octoolService- Current Game app exited ", ", Ended, ")
    Clean := StrReplace(Clean, ".x64", "")
    Clean := StrReplace(Clean, ".exe", "")
    Clean := StrReplace(Clean, ".", ":")

; Exceptions =============================================================================================
    Clean := StrReplace(Clean, "_retail_", ", ")                                            ; Battlenet
    Clean := StrReplace(Clean, "Steamsteamappscommon", "")                                  ; Steam
    Clean := StrReplace(Clean, "BinariesWin64", ", ")                                       ; Binaries
    Clean := StrReplace(Clean, "Cya", "")                                                   ; Cthulhu
    Clean := StrReplace(Clean, "TSCGame", "")                                               ; TSCGame
    Clean := StrReplace(Clean, "-Win64-Shipping", "")                                       ; TSCGame

; Disks ===========================================================================
        Clean := StrReplace(Clean, "A:", ", ")
        Clean := StrReplace(Clean, "B:", ", ")
        Clean := StrReplace(Clean, "C:", ", ")
        Clean := StrReplace(Clean, "D:", ", ")
        Clean := StrReplace(Clean, "E:", ", ")
        Clean := StrReplace(Clean, "F:", ", ")
        Clean := StrReplace(Clean, "G:", ", ")
        Clean := StrReplace(Clean, "H:", ", ")
        Clean := StrReplace(Clean, "I:", ", ")
        Clean := StrReplace(Clean, "J:", ", ")
        Clean := StrReplace(Clean, "K:", ", ")
        Clean := StrReplace(Clean, "L:", ", ")
        Clean := StrReplace(Clean, "M:", ", ")
        Clean := StrReplace(Clean, "N:", ", ")
        Clean := StrReplace(Clean, "O:", ", ")
        Clean := StrReplace(Clean, "P:", ", ")
        Clean := StrReplace(Clean, "Q:", ", ")
        Clean := StrReplace(Clean, "R:", ", ")
        Clean := StrReplace(Clean, "S:", ", ")
        Clean := StrReplace(Clean, "T:", ", ")
        Clean := StrReplace(Clean, "U:", ", ")
        Clean := StrReplace(Clean, "V:", ", ")
        Clean := StrReplace(Clean, "W:", ", ")
        Clean := StrReplace(Clean, "X:", ", ")
        Clean := StrReplace(Clean, "Y:", ", ")
        Clean := StrReplace(Clean, "Z:", ", ")
   
FileDelete,                                                     %Temp%\Nvidia.txt
Fileappend,    %Clean%,                                         %Temp%\Nvidia.txt

;Sort==================================================================================================
    FileRead,  Clean,                                           %Temp%\Nvidia.txt
    Sort, Clean, u

    FileDelete,                                                 %Temp%\Nvidia.txt
    Fileappend, %Clean%,                                        %Temp%\Nvidia.txt

;Delete ===============================================================================================

    FileDelete, %Temp%\actual.log
    FileDelete, %Temp%\previous.log
    FileDelete, %Temp%\Nvidia_temp.log
    
;  ====================================================================================================

;Clean := StrReplace(Clean, "", "")
