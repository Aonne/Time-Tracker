#Singleinstance, Force
; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    Loop, read, %Path%\user_options.ini,
        {
            if InStr(A_LoopReadLine, "Minecraft")
                Minecraft_Path = %A_LoopReadLine%             
        }

    Minecraft_Path := StrReplace(Minecraft_Path, "Minecraft = ", "")
    Temp = %Path%\Temp

; Retrive Files =========================================================================================
    FileCreateDir, %Temp%

    FileCopy, %Minecraft_Path%\latest.log,                               %Temp%\Minecraft_latest.txt
    FileGetTime, datetime, %Minecraft_Path%\latest.log, M ; modification time
    FormatTime, datetime, %datetime%, yyyy-MM-dd

; Clean ================================================================================================
    Loop, read, %Temp%\Minecraft_latest.txt,                             %Temp%\Minecraft.txt
    {
        if InStr(A_LoopReadLine, "Stopping!")
            Fileappend, %datetime% %A_LoopReadLine%`n

        if InStr(A_LoopReadLine, "Loading Minecraft")
            Fileappend, %datetime% %A_LoopReadLine%`n
 
    }

; Replace  ============================================================================================
    FileRead, Clean,                                                    %Temp%\Minecraft.txt

    Clean := StrReplace(Clean, " [main/INFO]: Loading ", ", ")
    Clean := StrReplace(Clean, " with ", ", Started, ")
    Clean := StrReplace(Clean, " [Render thread/INFO]: Stopping!", ", Ended")
    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", "")

FileDelete,                                                             %Temp%\Minecraft.txt
FileAppend, %Clean%,                                                    %Temp%\Minecraft.txt

;Sort==================================================================================================
    FileRead, Clean,                                                    %Temp%\Minecraft.txt
    Sort, Clean, u

    FileDelete,                                                         %Temp%\Minecraft.txt
    FileAppend, %Clean%,                                                %Temp%\Minecraft.txt

;Delete ===============================================================================================
    FileDelete, %Temp%\Minecraft_latest.txt