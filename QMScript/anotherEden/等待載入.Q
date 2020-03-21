[General]
SyntaxVersion=2
BeginHotkey=118
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=c224173a-bd98-43eb-ad1d-6b00df82afa4
Description=µ¥«Ý¸ü¤J
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
Rem waitLoading
IfColor 419, 712, "B1A59A", 1 Then
	Goto waitLoading
Else 
	Delay 1000
End If

Rem waitLoadeed
IfColor 419, 712, "B1A59A", 0 Then
	Goto waitLoadeed
Else 
	Delay 1000
End If

KeyPress "Space", 1

While inField() = false
	Delay 1000
Wend

Call Plugin.Media.Beep(523, 200)
Call Plugin.Media.Beep(523, 200)
Call Plugin.Media.Beep(523, 200)

Function inField()
	FindPic 313,664,382,737,"C:\Users\Lee\Desktop\«öÁäºëÆF\inFieldZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inField = true
	Else 
		inField = false
	End If
End Function
