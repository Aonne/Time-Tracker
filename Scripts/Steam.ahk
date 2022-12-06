; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")
    
    Loop, read, %Path%\user_options.ini
    {
        if InStr(A_LoopReadLine, "Steam")
        Steam_Path = %A_LoopReadLine%
    }
    Steam_Path := StrReplace(Steam_Path, "Steam = ", "")

    Temp = %Path%\Temp
    
; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    FileCopy,       %Steam_Path%\content_log.txt,           %Temp%\steam_start.txt
    FileCopy,       %Steam_Path%\shader_log.txt,            %Temp%\steam_end.txt

    FileRead,       Start,                                  %Temp%\steam_start.txt
    FileRead,       End,                                    %Temp%\steam_end.txt

    FileAppend,     %Start% `n%End%,                        %Temp%\Steam_temp.txt

; Clean ================================================================================================
    Loop, read, %Temp%\Steam_temp.txt,                             %Temp%\Steam.txt
    {
        if InStr(A_LoopReadLine, "exited.")
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "App Running")
            Fileappend, %A_LoopReadLine%`n            
    }

; Keep ================================================================================================
    FileRead, Keep,                                                 %Temp%\Steam.txt
        i=0
        e:=""
        ToDelete=Update Queued    ;- skip this and next line


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

    FileDelete, %Temp%\Steam.txt
    FileAppend, %e%, %Temp%\Steam.txt

; Replace  ============================================================================================
    FileRead, Clean,                                                %Temp%\Steam.txt

    Clean := StrReplace(Clean, " exited.", ", Ended")
    Clean := StrReplace(Clean, " state changed : Fully Installed,App Running,", ", Started")
    Clean := StrReplace(Clean, " AppID ", ", ")
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", "")

FileDelete,                                                         %Temp%\Steam.txt
FileAppend,     %Clean%,                                            %Temp%\Steam.txt

;Sort==================================================================================================
    FileRead,  Clean,                                           %Temp%\Steam.txt
    Sort, Clean, u

    FileDelete,                                                 %Temp%\Steam.txt
    Fileappend, %Clean%,                                        %Temp%\Steam.txt

;Delete ===============================================================================================
    FileDelete, %Temp%\steam_end.txt
    FileDelete, %Temp%\steam_start.txt
    FileDelete, %Temp%\Steam_temp.txt

;  ====================================================================================================