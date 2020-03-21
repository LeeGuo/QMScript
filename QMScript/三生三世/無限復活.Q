[General]
SyntaxVersion=2
BeginHotkey=114
BeginHotkeyMod=0
PauseHotkey=115
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=d2ee9b56-a380-4496-9d52-834ea05b47ce
Description=µL­­´_¬¡
Enable=1
AutoRun=0
[Repeat]
Type=1
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
While 1 = 1
    FindPic 38,44,169,174,"C:\Users\Lee\Desktop\«öÁäºëÆF\revive.bmp",0.9,intX,intY
    If intX > 0 And intY > 0 Then 
        KeyPress "R", 1
    End If
    Delay 500
Wend
