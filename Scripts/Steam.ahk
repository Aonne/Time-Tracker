; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")
    
    IniRead, Steam_Path, %path%\user_options.ini, Path, Steam
    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    FileCopy,       %Steam_Path%\content_log.txt,                   %Temp%\steam_start.temp
    FileCopy,       %Steam_Path%\content_log.previous.txt,          %Temp%\steam_start_previous.temp
    FileCopy,       %Steam_Path%\shader_log.txt,                    %Temp%\steam_end.temp
    FileCopy,       %Steam_Path%\shader_log.previous.txt,           %Temp%\steam_end.temp

    FileRead,       Start,                                  %Temp%\steam_start.temp
    FileRead,       StartPrevious,                          %Temp%\steam_start_previous.temp
    FileRead,       End,                                    %Temp%\steam_end.temp
    FileRead,       EndPrevious,                            %Temp%\steam_end_previous.temp

    FileAppend,     %Start% `n%End%,                        %Temp%\Steam_temp.temp
 
; Clean ================================================================================================
    Loop, read, %Temp%\Steam_temp.temp, %Temp%\Steam1.temp
    {
        if InStr(A_LoopReadLine, "exited.")
        {
            line = %A_LoopReadLine%
            if inStr(line, "Update Queued")
                line := ""

            YMD := SubStr(line, 1,11)
            HMS := SubStr(line, 12,9)
            rest := SubStr(line, 21)

            Fileappend, %YMD%`,%HMS%%rest%`n 
        }

        if InStr(A_LoopReadLine, "App Running")
        {
            line = %A_LoopReadLine%
            if inStr(line, "Update Queued")
                line := ""

            YMD := SubStr(line, 1,11)
            HMS := SubStr(line, 12,9)
            rest := SubStr(line, 21)

            Fileappend, %YMD%`,%HMS%%rest%`n 
        }

    }

; Replace  ============================================================================================
    FileRead, Clean, %Temp%\Steam1.temp

    Clean := StrReplace(Clean, " exited.", ", Ended")
    Clean := StrReplace(Clean, " state changed : Fully Installed,App Running,", ", Started")
    Clean := StrReplace(Clean, " AppID ", ", ")
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", "")

FileAppend, %Clean%, %Temp%\Steam.log

;Sort==================================================================================================
    FileRead,  Clean, %Temp%\Steam.log
    Sort, Clean, u

    FileDelete, %Temp%\Steam.log
    Fileappend, %Clean%, %Temp%\Steam.log

;Delete ===============================================================================================
    FileDelete, %Temp%\*.temp

