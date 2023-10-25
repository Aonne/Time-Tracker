#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;flag missing lines, 
;thx chatgpt i really did nothing on this one

Temp = %A_ScriptDir%\Temp
Temp01 = %A_ScriptDir%\Temp01

Progress, 0, Steam

; Set the path to your log file
logFilePath = %Temp01%\Steam.log

; Read the log file
FileRead, fileContents, %logFilePath%

; Split the file contents into an array of lines
lines := StrSplit(fileContents, "`n")

; Initialize a variable to store the modified lines
modifiedLines := ""

; Initialize a variable to keep track of the previous event
previousEvent := ""

; Loop through each line in the log file
for index, line in lines {
    ; Remove leading and trailing spaces
    line := Trim(line)
    
    ; Split the line into its components (assuming they are comma-separated)
    parts := StrSplit(line, ",")
    
    ; Check if the last part of the line matches the previous event
    if (parts.Length() >= 4) {
        currentEvent := Trim(parts[4])
        if (currentEvent = previousEvent) {
            ; Add "TOCHANGE" next to this line and append to modifiedLines
            modifiedLines .= line . ", TOCHANGE`n"
        } else {
            ; Update the previous event and append the line to modifiedLines
            previousEvent := currentEvent
            modifiedLines .= line . "`n"
        }
    }
}

; Write the modified lines back to the log file
FileDelete, %logFilePath%
FileAppend, %modifiedLines%, %logFilePath%

; Notify when the script has finished processing the file
Progress, 50, Nvidia

; Set the path to your log file
logFilePath = %Temp01%\Nvidia.log

; Read the log file
FileRead, fileContents, %logFilePath%

; Split the file contents into an array of lines
lines := StrSplit(fileContents, "`n")

; Initialize a variable to store the modified lines
modifiedLines := ""

; Initialize a variable to keep track of the previous event
previousEvent := ""

; Loop through each line in the log file
for index, line in lines {
    ; Remove leading and trailing spaces
    line := Trim(line)
    
    ; Split the line into its components (assuming they are comma-separated)
    parts := StrSplit(line, ",")
    
    ; Check if the last part of the line matches the previous event
    if (parts.Length() >= 4) {
        currentEvent := Trim(parts[4])
        if (currentEvent = previousEvent) {
            ; Add "TOCHANGE" next to this line and append to modifiedLines
            modifiedLines .= line . ", TOCHANGE`n"
        } else {
            ; Update the previous event and append the line to modifiedLines
            previousEvent := currentEvent
            modifiedLines .= line . "`n"
        }
    }
}

; Write the modified lines back to the log file
FileDelete, %logFilePath%
FileAppend, %modifiedLines%, %logFilePath%

; Notify when the script has finished processing the file
Progress, 90

;Create final file
Progress, off

Msgbox, done
GuiClose:
ExitApp
