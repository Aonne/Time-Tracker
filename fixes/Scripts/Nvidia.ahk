#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Temp = %A_ScriptDir%\Temp
Temp := StrReplace(Temp, "Scripts", "")
Temp01 = %Temp%01
Temp02 = %Temp%02


;Nvidia
    FileDelete, %Temp02%\Nvidia.txt

    Loop, read, %Temp01%\Nvidia.txt, %Temp02%\Nvidia.txt
    {
        if (Mod(A_Index, 2) = 1)
        {
            firstdate := SubStr(A_LoopReadLine, 1, 20)
            firstdate := StrReplace(firstdate, ", ", "")
            firstdate := StrReplace(firstdate, ":", "")
            firstdate := StrReplace(firstdate, "-", "")
            FormatTime, daydate, %firstdate%, yyyy-MM-dd
        }

        if (Mod(A_Index, 2) = 0)
        {
            seconddate := SubStr(A_LoopReadLine, 1, 20)
            seconddate := StrReplace(seconddate, ", ", "")
            seconddate := StrReplace(seconddate, ":", "")
            seconddate := StrReplace(seconddate, "-", "")

            EnvSub, seconddate, %firstdate%, minutes
            if seconddate > 0
            {
                content = %daydate%, %seconddate%,
                Fileappend, %content%`n                
            }
        }
    }