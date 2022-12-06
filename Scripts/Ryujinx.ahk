; TEST
ExitApp









; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Ryujinx_Path = E:\Jeux vidéo indirect\Ryujinx\publish\Logs\ftyt
    Run, %Ryujinx_Path%

    Temp = %Path%\Temp\Ryujinx                                                                                      ; TEST

; Retrive Files =========================================================================================
    FileCreateDir,  %Temp%

    ;Loop, %Ryujinx_Path%\*.log
    ;    FileCopy, %Ryujinx_Path%\%A_LoopFileName%, %Temp%\%A_LoopFileName%

    Loop, %Ryujinx_Path%\*.log
    {
    FileRead, aFileContents, %A_LoopFileFullPath% 

    FileAppend, `n`nTEST`n%aFileContents%, %Temp%\Ryujinx_temp.txt
    }        
; Clean ================================================================================================
    Loop, read, %Temp%\Ryujinx_temp.txt,                            %Temp%\Ryujinx.txt
    {
        if InStr(A_LoopReadLine, "TEST")                                                                            ;TEST
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "Application Loaded")
            Fileappend, %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "GUI.WindowThread")
            Fileappend, %A_LoopReadLine%`n
    }

; Replace  ============================================================================================
    FileRead, Clean,                                                %Temp%\Ryujinx.txt

    Clean := StrReplace(Clean, " |I| Loader LoadNca: Application Loaded:", ",")
    Clean := StrReplace(Clean, "[64-bit]", ", Started")
    Clean := StrReplace(Clean, "[32-bit]", ", Started")
    Clean := StrReplace(Clean, " |I| GUI.WindowThread AudioRenderer ReleaseSessionId: Unregistered output ", ", Ended")
    Clean := StrReplace(Clean, "(1)", "")

FileDelete,                                                         %Temp%\Ryujinx.txt
FileAppend,     %Clean%,                                            %Temp%\Ryujinx.txt

; Keep ================================================================================================
    FileRead, Keep,                                                 %Temp%\Ryujinx.txt
        i=0
        e:=""
        ToDelete=Thread    ;- skip this and next line


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

    FileDelete, %Temp%\Ryujinx.txt
    FormatTime, LogTime,, yyyy-MM-dd_HH-mm-ss                                                                          ; TEST
    FileAppend, %e%, %Temp%\Ryujinx_%Logtime%.txt

;Sort==================================================================================================
; Changer TEST to date

;Delete ===============================================================================================
    ;FileDelete, %Temp%\Ryujinx_temp.txt