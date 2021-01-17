[General]
SyntaxVersion=2
BeginHotkey=117
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=2ccdc108-88a5-4b01-b30d-173231dfa93f
Description=«õÄ_
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

Delay 200

FindPic 3113,616,3131,634,"C:\Users\Lee\Desktop\QMC\PWpic\dig.bmp",0.9,intX,intY
If intX > 0 And intY > 0 Then 
	TracePrint "Yes"
	KeyPress "R", 1
	Delay 100
	KeyPress "R", 1
Else
End If