[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=122
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=720cd3e6-6ec9-42b8-918b-37aa19011e19
Description=收資源
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
UserVar times=8 "次數"

LockMouse 

While 1 = 1
	i = 0
	For times
		MoveTo 1509, 225 + (i * 56)
		LeftClick 1
		Delay 500
		i = i + 1
	Next
	
	Delay 3000
	MoveTo 107, 565
	LeftClick 1
	Delay 5000
	KeyPress "Esc", 1
	Delay 10000
Wend
