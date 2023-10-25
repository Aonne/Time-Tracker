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
            trim := SubStr(A_LoopReadLine, 8)
            Fileappend, %trim%`n
        }

        if InStr(A_LoopReadLine, "Game process terminated")
        {
            trim := SubStr(A_LoopReadLine, 8)
            FileAppend, %trim%`n
        }

    }
; Replace ==============================================================================================
    FileRead, Clean, %Temp%\EADesktop1.temp

    StringReplace, Clean, Clean,`(, , All
    StringReplace, Clean, Clean,`), , All

    ;Clean := StrReplace(Clean, "	PID:  ", "")
    ;Clean := StrReplace(Clean, "	TID: ", "")
    Clean := StrReplace(Clean, "	INFO    	eax::components::clientLibrary::ClientLauncher::requestLicenseAndLaunch	Issuing launch: workingDirectory", ",Started, ")
    Clean := StrReplace(Clean, "	INFO    	eax::components::gameLocalServices::ProcessCoordinator::FsmHost::doProcessActiveGames	Game process terminated", ", Exited")

FileAppend, %Clean%, %Temp%\EADesktop.log
; Sort =================================================================================================
    FileRead, Clean, %Temp%\EADesktop.log
    Sort, Clean, u

    FileDelete, %Temp%\EADesktop.log
    FileAppend, %Clean%, %Temp%\EADesktop.log
; Delete ===============================================================================================
    FileDelete, %Temp%\*.temp
