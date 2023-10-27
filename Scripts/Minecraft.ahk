#Singleinstance, Force

; Retreive Path ==========================================================================================
    Path = %A_ScriptDir%
    Path := StrReplace(Path, "Scripts", "")

    IniRead, Minecraft_Path, %path%\user_options.ini, Path, Minecraft
    Temp = %Path%Temp
    CurseForge := StrReplace(Minecraft_Path, "AppData\Roaming\.minecraft\logs", "curseforge\minecraft\Instances")
    IniRead, MultiMC, %path%\user_options.ini, Path, MultiMC
    IniRead, Prism, %path%\user_options.ini, Path, Prism

    
; Retrive Files =========================================================================================
    FileCreateDir, %Temp%
    FileCreateDir, %Temp%\Minecraft


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Latest not working, idk
 ; it works? you know what, dont know dont care


    ;move .gz Prism
    Loop, %Prism%\*.* ,0,1
    {
        if A_LoopFileExt in gz
        {
            if not instr(A_LoopFileName, "debug")
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft      
        }
        if A_LoopfileExt in log
            if instr(A_LoopFileName, "latest")
            {
                FileGetTime, LatestTime, %A_LoopFileFullPath%, M
                FormatTime, LatestTime, %LatestTime%, yyyy-MM-dd
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft\%LatestTime%.log, 1
            }
    }

    ;move .gz MultiMC
    Loop, %MultiMC%\*.* ,0,1
    {
        if A_LoopFileExt in gz
        {
            if not instr(A_LoopFileName, "debug")
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft      
        }
        if A_LoopfileExt in log
            if instr(A_LoopFileName, "latest")
            {
                FileGetTime, LatestTime, %A_LoopFileFullPath%, M
                FormatTime, LatestTime, %LatestTime%, yyyy-MM-dd
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft\%LatestTime%.log, 1
            }
    }

    ;move .gz CurseForge
    Loop, %CurseForge%\*.* ,0,1
    {
        if A_LoopFileExt in gz
        {
            if not instr(A_LoopFileName, "debug")
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft      
        }
        if A_LoopfileExt in log
            if instr(A_LoopFileName, "latest")
            {
                FileGetTime, LatestTime, %A_LoopFileFullPath%, M
                FormatTime, LatestTime, %LatestTime%, yyyy-MM-dd
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft\%LatestTime%.log, 1
            }
    }

    ;move .gz .minecraft
    Loop, %Minecraft_Path%\*.* ,0,1
    {
        if A_LoopFileExt in gz
        {
            if not instr(A_LoopFileName, "debug")
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft      
        }
        if A_LoopfileExt in log
            if instr(A_LoopFileName, "latest")
            {
                FileGetTime, LatestTime, %A_LoopFileFullPath%, M
                FormatTime, LatestTime, %LatestTime%, yyyy-MM-dd
                FileCopy, %A_LoopFileFullPath%, %Temp%\Minecraft\%LatestTime%.log, 1
            }
    }


    ;extract .gz
    OutputTemp := """" . Temp . "\Minecraft\"""
    intputTemp := """" . Temp . "\Minecraft\"""
    RunWait, "C:\Program Files\7-Zip\7z.exe" x %intputTemp%\*.gz -o%OutputTemp%, , Hide
    StringReplace, OutputTemp, OutputTemp, `", , All

; thx chatgpt i have no idea how half of it works
Loop, %OutputTemp%\*.log
{
    ; Open the current file for reading
        DateTime = %A_LoopFileName%
        StringLeft, DateTime, DateTime, 10
    file := FileOpen(A_LoopFileFullPath, "r")
    
    ; Read the first line
    firstLine := file.ReadLine()
    
    ; Read the last line
    lastLine := ""
    while (!file.AtEOF())
    {
        currentLine := file.ReadLine()
        if (currentLine != "")
            lastLine := currentLine
    }
    
    ; Close the file
    file.Close()
    
    ; Write the first and last lines to a new file if they are not empty
    if (firstLine != "" || lastLine != "")
    {
        newFile := FileOpen(A_LoopFileFullPath ".new", "w")
        if (firstLine != "")
        {
            firstline = %DateTime%, %firstLine%
            newFile.WriteLine(firstLine)
        }
        if (lastLine != "")
        {
            lastLine = %DateTime%, %lastLine%
            newFile.WriteLine(lastLine)
        }
        newFile.Close()
    }
}
    Loop, %OutputTemp%\*.new
    {
        FileRead, afileContents, %A_LoopFileFullPath%
        Fileappend, %afileContents%, %Temp%\Minecraft.temp
    }

;Replace  ================================================================================================
    FileRead, Clean, %Temp%\Minecraft.temp

    Clean := StrReplace(Clean, "[", "")
    Clean := StrReplace(Clean, "]", ",")

    Fileappend, %Clean%, %Temp%\Minecraft.log

;Sort====================================================================================================
    FileRead, Clean, %Temp%\Minecraft.log
    Sort, Clean, u

    FileDelete, %Temp%\Minecraft.log
    FileAppend, %Clean%, %Temp%\Minecraft.log
    fileRemoveDir, %Temp%\Minecraft, 1

;Delete ===============================================================================================
    FileDelete, %Temp%\*.temp