[General]
SyntaxVersion=2
BeginHotkey=114
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=115
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=6a3d9f51-1d8d-4861-ac71-f259bdcf4f58
Description=刷boss之家
Enable=0
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
UserVar bossNo=DropList{"1":1|"2":2|"3":3|"4":4|"5":5}=0 "boss #"
UserVar bossDir=DropList{"Up":0|"Down":1}=0 "boss Direction"
Dim bossX1, bossY1, bossX2, bossY2, goX, goY

LockMouse

// determine boss coordination
bossX1 = 240
bossX2 = 350
goX = 300
If bossNo = 1 Then 
	bossY1 = 267
	bossY2 = 319
	goY = 295
ElseIf bossNo = 2 Then
	bossY1 = 314
	bossY2 = 369
	goY = 346
ElseIf bossNo = 3 Then
	bossY1 = 360
	bossY2 = 417
	goY = 393
ElseIf bossNo = 4 Then
	bossY1 = 414
	bossY2 = 465
	goY = 440
ElseIf bossNo = 5 Then
	bossY1 = 457
	bossY2 = 515
	goY = 486
End If

// ====================== main logic @ {
toTop
Delay 500

While isAttackMode = false
	switchMode
	Delay 1500
Wend

// scroll boss list
MoveTo 124, 239
LeftClick 1
Delay 500
If bossDir = 0 Then 
	KeyPress "J", 1
ElseIf bossDir = 1 Then
	KeyPress "K", 1
End If
Delay 2000

// infinity loop
While 1 = 1
	// wait for boss to be spawned
	While isBossSpawned = false
		Delay 3000
	Wend
	
	// attack !!
	MoveTo goX, goY
	LeftClick 1
	
	// wait for boss to be dead
	counter = 0
	While isBossSpawned = true
		counter = counter + 1
		If counter = 5 Then 
			counter = 0
			MoveTo goX, goY
			LeftClick 1
		End If
		Delay 1000
	Wend
	
	// stop attack
	MoveTo 1451, 482
	LeftClick 1
	Delay 10000
	
	// consume equipments
	consumeEqp
Wend
// ====================== main logic @ }

Sub toTop
	MoveTo 582, 21
	LeftClick 1
End Sub

Sub switchMode
	MoveTo 105, 798
	LeftClick 1
	Delay 1500
End Sub

Sub consumeEqp
	Call switchMode
	MoveTo 386, 796
	LeftClick 1
	Delay 1500
	MoveTo 1251, 762
	LeftClick 1
	Delay 1500
	MoveTo 461, 660
	LeftClick 1
	Delay 1500
	MoveTo 403, 406
	LeftClick 1
	Delay 1500
	MoveTo 765, 663
	LeftClick 1
	Delay 1500
	MoveTo 1147, 680
	LeftClick 1
	Delay 1500
	MoveTo 1343, 85
	LeftClick 1
	Delay 1500
	Call switchMode
End Sub

Function isAttackMode
	FindPic 1342,678,1463,794,"C:\Users\Lee\Desktop\按鍵精靈\attackBtn.bmp",0.8,intX,intY
	If intX > 0 And intY > 0 Then 
		isAttackMode = true
	Else 
		isAttackMode = false
	End If
End Function

Function isBossSpawned
	FindPic bossX1, bossY1, bossX2, bossY2, "C:\Users\Lee\Desktop\按鍵精靈\bossSpawned.bmp", 0.3, intX, intY
	If intX > 0 And intY > 0 Then 
		isBossSpawned = true
	Else 
		isBossSpawned = false
	End If
End Function
