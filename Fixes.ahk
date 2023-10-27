#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;=
Gui, Add, Text, , Change Battlenet
Gui, Add, Button, x72 y169 w90 h40 gpart1, Part 1
Gui, Add, Button, x172 y169 w90 h40 gpart2, Part 2
Gui, Add, Button, x272 y169 w90 h40 gpart3, Part 3
Gui, Add, Button, x132 y229 w90 h40 , debug
Gui, Add, Button, x232 y229 w90 h40 , Reset

Guicontrol, Disable, Part 2
Guicontrol, Disable, Part 3


Gui, Show, x1145 y356 h379 w479, Time Tracking - Fixes
Return

part1:
    FileRemoveDir, %A_ScriptDir%\fixes\Temp, 1
    FileCopyDir, %A_ScriptDir%\Temp, %A_ScriptDir%\fixes\Temp
    Sleep, 500
    Runwait, %A_ScriptDir%\fixes\Part1.ahk
    Guicontrol, Enable, Part 2
    return

part2:
    Runwait, %A_ScriptDir%\fixes\Part2.ahk
    GuiControl, Enable, Part 3
    return



part3:
    RunWait, %A_ScriptDir%\fixes\Part3.ahk
    Msgbox, done
    return

ButtonReset:
    FileRemovedir, %A_ScriptDir%\fixes\Temp, 1
    FileRemovedir, %A_ScriptDir%\fixes\Temp01, 1
    GuiControl, Disable, Part 2
    GuiControl, Disable, Part 3
    Msgbox, 4,, Deleting the Logs file?
    IfMsgBox, Yes
        FileDelete, %A_ScriptDir%\fixes\Logs.log
    Msgbox, Temp folder reset
    return

buttondebug:
    GuiControl, Enable, Part 2
    GuiControl, Enable, Part 3
    return

GuiClose:
exitapp
