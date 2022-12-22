#Singleinstance, Force
; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "Riot")
            Riot_Path = %A_LoopReadLine%             
        }
    Riot_Path := StrReplace(Riot_Path, "Riot = ", "")

    LOL_Path := StrReplace(Riot_Path, "Riot Client\", "League of Legends\Logs\LeagueClient Logs")
    VAL_Path = C:\Users\%A_UserName%\AppData\Local\VALORANT\Saved\Logs

    Temp = %Path%\Temp

; ========================================================================================================
    FileCreateDir, %Temp%

    ; Valorant
        Loop, %VAL_Path%\*.log
        {
            if InStr(A_LoopFileName, "ShooterGame")
            {
                FileGetTime, Creation,     %A_LoopFileFullPath%, C
                FormatTime,  Creation,     %Creation%, yyyy-MM-dd HH:mm:ss
                FileGetTime, Modification, %A_LoopFileFullPath%, M
                FormatTime,  Modification, %Modification%, yyyy-MM-dd HH:mm:ss
                
                Content = %Creation%, Started, Valorant`n%Modification%, Ended, Valorant`n
                FileAppend, %Content%, %Temp%\Riot.log

            }
        }

    ; League of Legends
        Loop, %LOL_Path%\*.log
        {
            if InStr(A_LoopFileName, "Ux")
            {
                FileGetTime, Creation,     %A_LoopFileFullPath%, C
                FormatTime,  Creation,     %Creation%, yyyy-MM-dd HH:mm:ss
                FileGetTime, Modification, %A_LoopFileFullPath%, M
                FormatTime,  Modification, %Modification%, yyyy-MM-dd HH:mm:ss
                
                Content = %Creation%, Started, League of Legends`n%Modification%, Ended, League of Legends`n
                FileAppend, %Content%, %Temp%\Riot.log

            }
        }

; ========================================================================================================
    FileRead, Clean, %Temp%\Riot.log
    Sort, Clean, u

    FileDelete, %Temp%\Riot.log
    Fileappend, %Temp%\Riot.log
    FileAppend, %Clean%, %Temp%\Riot.log