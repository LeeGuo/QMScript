[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=7094fb84-1e41-45ee-94c0-3ac4956f4bb9
Description=«õ¹Ï
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
UserVar screenNo=DropList{"left":0|"right":1}=0 "Screen"


Dim startX, startY, spaceX
spaceX = 143
// left: 863, right: 2783
startX = 863 + screenNo * 1920 - spaceX // -spaceX is for position to be 1-based
startY = 294

Dim freeNums, lv1Nums, lv2Nums, lv3Nums
freeNums = Array("to-1-based", "empty", "empty", "empty", "empty", "empty", "empty")
lv1Nums = Array("to-1-based", 0, 0, 0)
lv2Nums = Array("to-1-based", 0, 0, 0)
lv3Nums = Array("to-1-based", 0, 0, 0)

Dim numPic
numPic = Array("to-1-based", 0, 0, 0, 0, 0, 0, 0, 0, 0)
numPic(1) = Array("num1.bmp") // done
numPic(2) = Array("num2.bmp", "num22.bmp") // done
numPic(3) = Array("num3.bmp", "num32.bmp") // done
numPic(4) = Array("num4.bmp", "num42.bmp") // done
numPic(5) = Array("num5.bmp", "num52.bmp") // done
numPic(6) = Array("num6.bmp", "num62.bmp") // done
numPic(7) = Array("num7.bmp", "num72.bmp") // done
numPic(8) = Array("num8.bmp") // done
numPic(9) = Array("num9.bmp") // done

// ======================== variables above ===========================

Call getFreeNums

// ======================== functions below ===========================

Sub getFreeNums
	For i = 1 To UBound(freeNums)
		freeNums(i) = getPositionNum(i)
	Next
	TracePrint Join(freeNums)
End Sub

Function getPositionNum(position)
	For j = 1 To 9
		If checkNum(startX + (position * spaceX), startY, j, 0.9) Then 
			getPositionNum = j
			Exit Function
		End If
	Next
	getPositionNum = 0
End Function

Function checkNum(thisx, thisy, targetNum, accuracy)
	found = false
	For k = 0 To Ubound(numPic(targetNum))
		FindPic thisx,thisy,thisx+105,thisy+105,"C:\Users\Lee\Desktop\QMC\PWpic\" & numPic(targetNum)(k),accuracy,intX,intY
		If intX > 0 And intY > 0 Then 
			found = true
			Exit For
		End If
	Next
	checkNum = found
End Function