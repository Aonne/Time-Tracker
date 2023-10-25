#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

    Temp = %A_ScriptDir%\Temp
    Temp := StrReplace(Temp, "Scripts", "")
    Temp01 = %Temp%01
    Temp02 = %Temp%02

; gne
    FileDelete, %Temp02%\GOG_Galaxy.txt
    application := ".*\\([^\\]+)\.exe"
    gog_id := "'gog_(\d+)'"
    Loop, read, %Temp01%\GOG_galaxy.txt, %Temp02%\GOG_Galaxy.txt
    {
        if (Mod(A_Index, 2) = 1)
        {
            firstdate := SubStr(A_LoopReadLine, 1, 20)
            firstdate := StrReplace(firstdate, ", ", "")
            firstdate := StrReplace(firstdate, ":", "")
            firstdate := StrReplace(firstdate, "-", "")
            FormatTime, daydate, %firstdate%, yyyy-MM-dd

            if RegExMatch(A_LoopReadLine, application, match)
                applicationmatch := match1
        }

        if (Mod(A_Index, 2) = 0)
        {
            seconddate := SubStr(A_LoopReadLine, 1, 20)
            seconddate := StrReplace(seconddate, ", ", "")
            seconddate := StrReplace(seconddate, ":", "")
            seconddate := StrReplace(seconddate, "-", "")

            if RegExMatch(A_LoopReadLine, gog_id, match)
                gog_idmatch := match1

            EnvSub, seconddate, %firstdate%, minutes
            if seconddate > 0
            {
                content = %daydate%, %seconddate%, %applicationmatch% (%gog_idmatch%)
                Fileappend, %content%`n                
            }
        }
    }    


