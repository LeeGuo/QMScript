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
MacroID=145ce40a-84af-4cd4-bfaf-1cfd4181d7df
Description=¨ê°Ó«~
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

// right-bottom corner
// MoveTo 3313, 549

// 0: 20*29
// 1: 15*30
// 2: 20*29
// 3: 19*29
// 4: 19*29
// 5: 18*30
// 6: 19*30
// 7: 19*29
// 8: 19*29
// 9: 20*29

Dim accuracy
accuracy = 0.9

Dim rightMostX, nowRight, nowLeft
rightMostX = 3315 - 1920
nowRight = rightMostX

Dim thinNumber, fatNumber
thinNumber = Array()
fatNumber = Array(0, 3, 4, 5, 6, 7, 8, 9, 1, 2)

Dim numbers, idx
numbers = ""
idx = 0


Rem checkNum
accuracy = 0.9
// check 1
nowLeft = nowRight - 20
For i = 0 To UBound(thinNumber)
	FindPic nowLeft,510,nowRight,550,"C:\Users\Lee\Desktop\QMC\PWpic\goods" & CStr(thinNumber(i)) & ".bmp",accuracy,intX,intY
	If intX > 0 And intY > 0 Then 
		nowRight = intX + 3
		numbers = CStr(thinNumber(i)) & numbers
		// skip comma
		idx = idx + 1
		If idx = 3 OR idx = 6 Then 
			nowRight = nowRight - 6
		End If
		TracePrint "get " & CStr(thinNumber(i)) & " @ [0.9], nowRight changed to " & CStr(nowRight)
		Goto checkNum
	End If
Next

// check 0, 2~9
nowLeft = nowRight - 27
For i = 0 To UBound(fatNumber)
	FindPic nowLeft,510,nowRight,550,"C:\Users\Lee\Desktop\QMC\PWpic\goods" & CStr(fatNumber(i)) & ".bmp",accuracy,intX,intY
	If intX > 0 And intY > 0 Then 
		nowRight = intX + 3
		numbers = CStr(fatNumber(i)) & numbers
		// skip comma
		idx = idx + 1
		If idx = 3 OR idx = 6 Then 
			nowRight = nowRight - 6
		End If
		TracePrint "get " & CStr(fatNumber(i)) & " @ [0.9], nowRight changed to " & CStr(nowRight)
		Goto checkNum
	End If
Next

accuracy = 0.8
// check 1
nowLeft = nowRight - 20
For i = 0 To UBound(thinNumber)
	FindPic nowLeft,510,nowRight,550,"C:\Users\Lee\Desktop\QMC\PWpic\goods" & CStr(thinNumber(i)) & ".bmp",accuracy,intX,intY
	If intX > 0 And intY > 0 Then 
		nowRight = intX + 3
		numbers = CStr(thinNumber(i)) & numbers
		// skip comma
		idx = idx + 1
		If idx = 3 OR idx = 6 Then 
			nowRight = nowRight - 6
		End If
		TracePrint "get " & CStr(thinNumber(i)) & " @ [0.8], nowRight changed to " & CStr(nowRight)
		Goto checkNum
	End If
Next

// check 0, 2~9
nowLeft = nowRight - 27
For i = 0 To UBound(fatNumber)
	FindPic nowLeft,510,nowRight,550,"C:\Users\Lee\Desktop\QMC\PWpic\goods" & CStr(fatNumber(i)) & ".bmp",accuracy,intX,intY
	If intX > 0 And intY > 0 Then 
		nowRight = intX + 3
		numbers = CStr(fatNumber(i)) & numbers
		// skip comma
		idx = idx + 1
		If idx = 3 OR idx = 6 Then 
			nowRight = nowRight - 6
		End If
		TracePrint "get " & CStr(fatNumber(i)) & " @ [0.8], nowRight changed to " & CStr(nowRight)
		Goto checkNum
	End If
Next

MessageBox numbers