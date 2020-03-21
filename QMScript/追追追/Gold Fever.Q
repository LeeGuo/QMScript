[General]
SyntaxVersion=2
BeginHotkey=115
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d40b9f48-a87a-4d1c-a58e-dea1ceee1b06
Description=Gold Fever
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
UserVar clickBack=DropList{"no":0|"yes":1}=0 "click back"

Dim dx

dx = 0
If shopAvailable() = false Then 
    dx = 1920
    If shopAvailable() = false Then 
        MessageBox "Game window not detected at both screen"
        ExitScript
    End If
End If

LockMouse 
GetCursorPos x, y // save cursor position

MoveTo 926 + dx, 413
For 12
    LeftClick 1
	LockMouse
    Delay 50
Next

MoveTo x, y // retrieve cursor position
If clickBack = 1 Then 
	LeftClick 1
End If

Function shopAvailable
    FindPic 107+dx,873,194+dx,940,"C:\Users\Lee\Desktop\«öÁäºëÆF\shopAvailable.bmp",0.9,intX,intY	
    If intX > 0 And intY > 0 Then 
        shopAvailable = true
    Else 
        shopAvailable = false
    End If
End Function