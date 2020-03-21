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
MacroID=c6ae9aeb-ec05-42fa-8938-2637f76024a7
Description=∏ı√∑
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
Dim cnt, side, lock, lockCnt
cnt = 0
side = 1
lock = true

Dim l0x, l0y, l0c, l1x, l1y, l1c, l2x, l2y, l2c, l3x, l3y, l3c, r0x, r0y, r0c, r1x, r1y, r1c, r2x, r2y, r2c, r3x, r3y, r3c
Dim p1x, p1y, p1c, p2x, p2y, p2c
l0x = 663
l0y = 522
l0c = "3F6468"
l1x = 663
l1y = 536
l1c = "4C6E6E"
l2x = 664
l2y = 526//528
l2c = "3F626B"//"375763"
l3x = 666
l3y = 540
l3c = "4D6E6D"
r0x = 1170
r0y = 514
r0c = "587371"
r1x = 1170
r1y = 525
r1c = "A8E3DD"
r2x = 1174
r2y = 522//524
r2c = "A8E3DE"//"A8E3DD"
r3x = 1173
r3y = 532
r3c = "B0E5E1"

p1x = r0x
p1y = r0y
p1c = r0c
p2x = r1x
p2y = r1y
p2c = r1c

Rem jump

// fire mountain
/* IfColor 382,519,"3472A2",1 Then
	KeyPress "Space", 1
	Delay 300
End If */

While lock
	IfColor p1x,p1y,p1c,0 Then
		lock = false
	End If
Wend

IfColor p1x,p1y,p1c,1 Then
	lock = true
	While lock
		IfColor p2x,p2y,p2c,1 Then
			lock = false
		Else 
			MoveTo 372, 338
			LeftClick 1
		End If
	Wend
	
	cnt = cnt + 1
	If cnt = 4 Then 
		cnt = 0
		If side = 0 Then 
			side = 1
			p1x = r0x
			p1y = r0y
			p1c = r0c
			p2x = r1x
			p2y = r1y
			p2c = r1c
		Else 
			side = 0
			p1x = l0x
			p1y = l0y
			p1c = l0c
			p2x = l1x
			p2y = l1y
			p2c = l1c
		End If
	End If
	lock = true
End If

// green villege
/* If side = 0 Then 
	While lock
		IfColor l1x,l1y,l1c,0 Then
			lock = false
		End If
	Wend

	IfColor l0x,l0y,l0c,1 Then
		lock = true
		cnt = cnt + 1
		If cnt = 4 Then 
			cnt = 0
			side = 1
		End If

		While lock
			IfColor l1x,l1y,l1c,1 Then
				lock = false
			Else 
				MoveTo 372, 338
				LeftClick 1
			End If
		Wend
		lock = true
	End If
ElseIf side = 1 Then
	While lock
		IfColor r1x,r1y,r1c,0 Then
			lock = false
		End If
	Wend

	IfColor r0x,r0y,r0c,1 Then
		lock = true
		cnt = cnt + 1
		If cnt = 4 Then 
			cnt = 0
			side = 0
		End If
		
		While lock
			IfColor r1x,r1y,r1c,1 Then
				lock = false
			Else 
				MoveTo 1005, 339
				LeftClick 1
			End If
		Wend
		lock = true
	End If
End If */

Goto jump