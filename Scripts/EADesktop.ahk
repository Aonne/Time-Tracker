#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Retreive Path ========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, EAPath, %path%\user_options.ini, Path, EADesktop
    Temp = %Path%\Temp
 
; Retrive Files ========================================================================================
    FileCopy, %EAPath%\EADesktop.log, %Temp%\EADesktop.temp
    
; Clean ================================================================================================
    Loop, read, %Temp%\EADesktop.temp, %Temp%\EADesktop1.temp
    {
        if inStr(A_LoopReadLine, "Issuing launch")
        {
            YMD := SubStr(A_LoopReadLine, 9,10)
            HMS := SubStr(A_LoopReadLine, 20, 8)
            rest := SubStr(A_LoopReadLine, 70)
                if instr(YMD, "T")                  ; for some reason their launcher doesnt place correctly the n° of the line
                {
                    YMD := SubStr(A_LoopReadLine, 7,10)
                    HMS := SubStr(A_LoopReadLine, 18, 8)
                    rest := SubStr(A_LoopReadLine, 68)
                }
            For_stop = %rest%
            if (rest = "")
                continue  
            Fileappend, %YMD%`, %HMS%`, Started`, %rest%`n
        }

        if InStr(A_LoopReadLine, "Game process terminated")
        {
            YMD := SubStr(A_LoopReadLine, 9,10)
            HMS := SubStr(A_LoopReadLine, 20, 8)
            rest := SubStr(A_LoopReadLine, 70)
                if instr(YMD, "T")                  ; for some reason their launcher doesnt place correctly the n° of the line
                {
                    YMD := SubStr(A_LoopReadLine, 7,10)
                    HMS := SubStr(A_LoopReadLine, 18, 8)
                    rest := SubStr(A_LoopReadLine, 68)
                }
            if (rest = "")
                continue  
            Fileappend, %YMD%`, %HMS%`, Stopped`, %For_stop%`n
        }
    }

; Replace ==============================================================================================
    FileRead, Clean, %Temp%\EADesktop1.temp

    StringReplace, Clean, Clean,`(, , All
    StringReplace, Clean, Clean,`), , All

    StringReplace, Clean, Clean, ::components::gameLocalServices::ProcessCoordinator::FsmHost::doProcessActiveGames	Game process terminated, , All
    StringReplace, Clean, Clean, ::components::clientLibrary::ClientLauncher::requestLicenseAndLaunch	Issuing launch: workingDirectory, , All


FileAppend, %Clean%, %Temp%\EADesktop.log

; Sort =================================================================================================
    FileRead, Clean, %Temp%\EADesktop.log
    Sort, Clean, u

    FileDelete, %Temp%\EADesktop.log
    FileAppend, %Clean%, %Temp%\EADesktop.log
; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp
