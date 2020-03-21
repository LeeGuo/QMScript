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
MacroID=ecc32f5d-b324-418d-b578-0d2e404a30ea
Description=¶]¥P·ù¥ô°È
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
While 1 = 1
	If submitEqpQuest() = true Then 
		Delay 2000
		MoveTo 592, 391
		LeftClick 1
		Delay 1000
		MoveTo 579, 627
		LeftClick 1
	End If
	Delay 5000
Wend


Function submitEqpQuest
	FindPic 515,591,650,658,"C:\Users\Lee\Desktop\«öÁäºëÆF\eqpSubmit.bmp",0.7,intX,intY
	If intX > 0 And intY > 0 Then 
		submitEqpQuest = true
	Else 
		submitEqpQuest = false
	End If
End Function