#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Temp = %A_ScriptDir%\Temp
Temp01 = %A_ScriptDir%\Temp01

FileCreateDir, %Temp01%

;reformat to follow yyyy-mm-dd, HH:MM:ss,
;=
    ;FileCopy, %Temp01%, %A_ScriptDir%\Temp02
FileCreateDir, %Temp01%

;=
Gui, Add, Progress, w400 h30 vMyProgress Range0-6,0
Gui, Add, Text, w200 vName,
GuiControl,, MyProgress, 0

Gui, Show,, Progress

GuiControl,, Name, Battlenet
    ; Battlenet
    FileDelete, %Temp01%\Battlenet.txt
        Loop, read, %Temp%\Battlenet.txt
        {
            str = %A_LoopReadLine%
            StringLeft, virgulel, str, 10
            StringLen, lengv, str
            lengv -= 10
            StringRight, virguler, str, %lengv%
            Virgule = %virgulel%,%virguler%

            StringLeft, microsecondesl, virgule, 20
            StringLen, lengm, virgule
            lengm -= 27
            StringRight, microsecondesr, virgule, %lengm%

            Content = %microsecondesl%%microsecondesr%

            FileAppend, %content%`n, %Temp01%\Battlenet.log   
        }
GuiControl,, Name, GOG
GuiControl,, MyProgress, +1
    ; GOG_Galaxy
    FileDelete, %Temp01%\GOG_Galaxy.txt
    Loop, read, %Temp%\GOG_Galaxy.log
    {

        str = %A_LoopReadLine%
        StringLeft, virgulel, str, 10
        StringLen, lengv, str
        lengv -= 10
        StringRight, virguler, str, %lengv%
        Virgule = %virgulel%,%virguler%

        StringLeft, microsecondesl, virgule, 20
        StringLen, lengm, virgule
        lengm -= 24
        StringRight, microsecondesr, virgule, %lengm%

        Content = %microsecondesl%%microsecondesr%

        FileAppend, %content%`n, %Temp01%\GOG_Galaxy.log        

    }
GuiControl,, Name, Nvidia
GuiControl,, MyProgress, +1
    ; Nvidia
    FileDelete, %Temp01%\Nvidia.txt
    Loop, read, %Temp%\Nvidia.log
    {

        str = %A_LoopReadLine%
        StringLeft, virgulel, str, 10
        StringLen, lengv, str
        lengv -= 10
        StringRight, virguler, str, %lengv%
        Virgule = %virgulel%,%virguler%

        StringLeft, microsecondesl, virgule, 20
        StringLen, lengm, virgule
        lengm -= 24
        StringRight, microsecondesr, virgule, %lengm%

        Content = %microsecondesl%%microsecondesr%

        FileAppend, %content%`n, %Temp01%\Nvidia.log        

    }
GuiControl,, Name, Riot
GuiControl,, MyProgress, +1
    ; Riot
    FileDelete, %Temp01%\Riot.txt
    Loop, read, %Temp%\Riot.log
    {

        str = %A_LoopReadLine%
        StringLeft, virgulel, str, 10
        StringLen, lengv, str
        lengv -= 10
        StringRight, virguler, str, %lengv%
        Content = %virgulel%,%virguler%

        FileAppend, %content%`n, %Temp01%\Riot.log        

    }
GuiControl,, Name, Steam
GuiControl,, MyProgress, +1
    ; Steam
    FileDelete, %Temp01%\Steam.txt
    Loop, read, %Temp%\Steam.txt
    {

        str = %A_LoopReadLine%
        StringLeft, virgulel, str, 10
        StringLen, lengv, str
        lengv -= 10
        StringRight, virguler, str, %lengv%
        Content = %virgulel%,%virguler%

        FileAppend, %content%`n, %Temp01%\Steam.log        

    }
GuiControl,, Name, Minecraft
GuiControl,, MyProgress, +1
    ; Minecraft
    FileDelete, %Temp01%\Minecraft.txt
    FileCopy, %Temp%\Minecraft.*, %Temp01%\Minecraft.log

GuiControl,, MyProgress, 100
Progress, off

Msgbox, done
GuiClose:
ExitApp