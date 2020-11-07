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
startX = 863 + screenNo * 1920 //left: 863, right: 2783
startY = 294
spaceX = 143

Dim freeNums, maxFreeNum, lv1Nums, lv2Nums, lv3Nums
maxFreeNum = 6
freeNums = Array("empty", "empty", "empty", "empty", "empty", "empty")
lv1Nums = Array(- 1 , - 1 , - 1 )
lv1Nums = Array(- 1 , - 1 , - 1 )
lv1Nums = Array(- 1 , - 1 , - 1 )

Dim numPic
numPic = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
numPic(1) = Array("num1.bmp") // done
numPic(2) = Array("num2.bmp", "num22.bmp") // done
numPic(3) = Array("num3.bmp", "num32.bmp") // done
numPic(4) = Array("num4.bmp", "num42.bmp") // done
numPic(5) = Array("num5.bmp", "num52.bmp") // done
numPic(6) = Array("num6.bmp", "num62.bmp") // done
numPic(7) = Array("num7.bmp", "num72.bmp") // done
numPic(8) = Array("num8.bmp") // done
numPic(9) = Array("num9.bmp") // done

Call getFreeNums

Sub getFreeNums
	For i = 0 To (maxFreeNum - 1)
		freeNums(i) = 0 // initiation
		For j = 1 To 9
			If checkNum(startX + (i * spaceX), startY, j, 0.9) Then 
				freeNums(i) = j
				Exit For
			End If
		Next
	Next
	TracePrint Join(freeNums)
End Sub

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