[General]
MacroID=37ebbdc3-cb85-4149-a6c2-7d2abffd9906
SyntaxVersion=2
BeginHotkey=113
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=³¨³½
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
While true
	MoveTo 1102, 602
	LeftClick 1
	Delay 1000

	Rem fishing
	IfColor 1102, 602, "9CD2F2", 0 Then
		MoveTo 1102, 602
		LeftClick 1
		Delay 1000
	Else 
		Goto fishing
		Delay 1000
	End If
Wend