#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;=
Gui, Add, Text, , Change Battlenet
Gui, Add, Button, x72 y169 w90 h40 , Part1
Gui, Add, Button, x172 y169 w90 h40 , Part2
Gui, Add, Button, x272 y169 w90 h40 , Part3
;Gui, Add, Button, x132 y229 w90 h40 , Abort
Gui, Add, Button, x232 y229 w90 h40 , Reset

;Guicontrol, Hide, Part2
;Guicontrol, Hide, Part3

; Generated using SmartGUI Creator 4.0
Gui, Show, x1145 y356 h379 w479, Time Tracking - Fixes
Return

ButtonPart1:
    FileRemoveDir, %A_ScriptDir%\fixes\Temp
    FileCopyDir, %A_ScriptDir%\Temp, %A_ScriptDir%\fixes\Temp
    Sleep, 500
    Runwait, %A_ScriptDir%\fixes\Part1.ahk
    Guicontrol, Show, Part2
    return

ButtonPart2:
    Runwait, %A_ScriptDir%\fixes\Part2.ahk
    GuiControl, Show, Part3
    return

ButtonPart3:
    RunWait, %A_ScriptDir%\fixes\Part3.ahk
    Msgbox, done
    return

ButtonReset:
    FileRemovedir, %A_ScriptDir%\fixes\Temp, 1
    FileRemovedir, %A_ScriptDir%\fixes\Temp01, 1
    Msgbox, 4,, Deleting the Logs file?
    IfMsgBox, Yes
        FileDelete, %A_ScriptDir%\fixes\Logs.log
    Msgbox, Temp folder reset
    return

GuiClose:
exitapp
