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

Dim priorityLv1, priorityLv2, priorityLv3
priorityLv1 = Array("to-1-based", 0, 0, 0, 0, 0, 0, 0, 0, 0)
priorityLv2 = Array("to-1-based", 0, 0, 0, 0, 0, 0, 0, 0, 0)
priorityLv3 = Array("to-1-based", 0, 0, 0, 0, 0, 0, 0, 0, 0)

Dim matchingSet
matchingSet = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
matchingSet(0) = Array(1, 1, 1)
matchingSet(1) = Array(1, 2, 3)
matchingSet(2) = Array(2, 2, 2)
matchingSet(3) = Array(2, 3, 4)
matchingSet(4) = Array(3, 3, 3)
matchingSet(5) = Array(3, 4, 5)
matchingSet(6) = Array(4, 4, 4)
matchingSet(7) = Array(4, 5, 6)
matchingSet(8) = Array(5, 5, 5)
matchingSet(9) = Array(5, 6, 7)
matchingSet(10) = Array(6, 6, 6)
matchingSet(11) = Array(6, 7, 8)
matchingSet(12) = Array(7, 7, 7)
matchingSet(13) = Array(7, 8, 9)
matchingSet(14) = Array(8, 8, 8)
matchingSet(15) = Array(9, 9, 9)

// ======================== variables above ===========================

For i = 1 To 9
	priorityLV2(i) = i
Next
TracePrint Join(priorityLV2)

Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (none)"

lv3Nums(1) = 5
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (5)"

lv3Nums(1) = 8
lv3Nums(2) = 9
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (89)"

lv3Nums(1) = 1
lv3Nums(2) = 2
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (12)"

lv3Nums(1) = 4
lv3Nums(2) = 6
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (46)"

lv3Nums(1) = 1
lv3Nums(2) = 1
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (11)"

lv3Nums(1) = 5
lv3Nums(2) = 8
Call checkLV3RequirementStatus
TracePrint Join(priorityLV2) & " (58)"

// ======================== functions below ===========================

Sub checkFreeNums
	For i = 1 To UBound(freeNums)
		freeNums(i) = _checkPositionNum(i)
	Next
	TracePrint Join(freeNums)
End Sub

Function _checkPositionNum(position)
	For j = 1 To 9
		If __checkNum(startX + (position * spaceX), startY, j, 0.9) Then 
			_checkPositionNum = j
			Exit Function
		End If
	Next
	_checkPositionNum = 0
End Function

Function __checkNum(thisx, thisy, targetNum, accuracy)
	found = false
	For k = 0 To Ubound(numPic(targetNum))
		FindPic thisx,thisy,thisx+105,thisy+105,"C:\Users\Lee\Desktop\QMC\PWpic\" & numPic(targetNum)(k),accuracy,intX,intY
		If intX > 0 And intY > 0 Then 
			found = true
			Exit For
		End If
	Next
	__checkNum = found
End Function

Function _isInputOneOfMatchingSetNo(thisInput, thisMatchingSetNo)
	If matchingSet(thisMatchingSetNo)(0) <= thisInput OR thisInput <= matchingSet(thisMatchingSetNo)(2) Then 
		_isInputOneOfMatchingSetNo = true
	Else 
		_isInputOneOfMatchingSetNo = false
	End If
End Function

Function checkLV3RequirementStatus
	// initial priority, accept all with equal priority
	For i = 1 To 9
		priorityLV2(i) = 0
	Next

	If lv3Nums(1) = 0 Then 
		// empty, priority by occurances in matching sets
		For i = 0 To Ubound(matchingSet)
			priorityLV2(matchingSet(i)(0)) = priorityLV2(matchingSet(i)(0)) + 1
			priorityLV2(matchingSet(i)(1)) = priorityLV2(matchingSet(i)(1)) + 1
			priorityLV2(matchingSet(i)(2)) = priorityLV2(matchingSet(i)(2)) + 1
		Next
	ElseIf lv3Nums(2) = 0 Then
		// 1 record, avoid the case that may cause a matching set with the current one
		For i = 0 To Ubound(matchingSet)
			If matchingSet(i)(1) <> lv3Nums(1) Then 
				priorityLV2(matchingSet(i)(0)) = priorityLV2(matchingSet(i)(0)) + 1
				priorityLV2(matchingSet(i)(1)) = priorityLV2(matchingSet(i)(1)) + 1
				priorityLV2(matchingSet(i)(2)) = priorityLV2(matchingSet(i)(2)) + 1
			End If
		Next
	ElseIf lv3Nums(3) = 0 Then
		// 2 record, remove avoided one(s) by if-elses
		temp = lv3Nums(2) - lv3Nums(1)
		If temp = 0 Then 
			// 2 same numbers in a row, avoid the same number
			priorityLV2(lv3Nums(2)) = -1
		ElseIf temp = 1 Then
			// 2 adjacent numbers, avoid the prev/next adjacent one
			If lv3Nums(1) > 1 Then 
				priorityLV2(lv3Nums(1) - 1) = -1
			End If
			If lv3Nums(2) < 9 Then 
				priorityLV2(lv3Nums(2) + 1) = -1
			End If
		ElseIf temp = 2 Then
			// e.g. 5 & 7, avoid the middle one
			priorityLV2(lv3Nums(1) + 1) = -1
		Else 
			// gap >= 3, any number is acceptable, so do nothing
		End If
	Else 
		// 3 LV3, claim it
	End If
End Function

Function checkLV2RequirementStatus
	// initial priority, deny all (negative priority means the number should be avoided)
	For i = 1 To 9
		priorityLV1(i) = -1
	Next

	If lv2Nums(1) = 0 Then 
		// empty, priority by occurances in matching sets
		For i = 0 To Ubound(matchingSet)
			lv2Weight = priorityLV2(matchingSet(i)(1)) * 10
			If lv2Weight >= 0 Then 
				priorityLV1(matchingSet(i)(0)) = priorityLV1(matchingSet(i)(0)) + 1 + lv2Weight
				priorityLV1(matchingSet(i)(1)) = priorityLV1(matchingSet(i)(1)) + 1 + lv2Weight
				priorityLV1(matchingSet(i)(2)) = priorityLV1(matchingSet(i)(2)) + 1 + lv2Weight
			End If
		Next
	ElseIf lv2Nums(2) = 0 Then
		// 1 record, enhance priority for only the possible-matching ones
		For i = 0 To Ubound(matchingSet)
			If matchingSet(i)(1) <= lv2Nums(1) AND (matchingSet(i)(1) + 2) >= lv2Nums(1) Then 
				lv2Weight = priorityLV2(matchingSet(i)(1)) * 10
				If lv2Weight >= 0 Then 
					priorityLV1(matchingSet(i)(0)) = priorityLV1(matchingSet(i)(0)) + 1 + lv2Weight
					priorityLV1(matchingSet(i)(1)) = priorityLV1(matchingSet(i)(1)) + 1 + lv2Weight
					priorityLV1(matchingSet(i)(2)) = priorityLV1(matchingSet(i)(2)) + 1 + lv2Weight
				End If
			End If
		Next
	ElseIf lv2Nums(3) = 0 Then
		// 2 record

		temp = lv2Nums(2) - lv2Nums(1)
		If temp = 0 Then 
			// 2 same numbers in a row, require for the same number
			requiredNumbers = Array(lv2Nums(1))
		ElseIf temp = 1 Then
			// 2 adjacent numbers, require for the prev/next adjacent one
			requiredNumbers = Array(-1, -1)
			If lv2Nums(1) > 1 Then 
				requiredNumbers(0) = lv2Nums(1) - 1
			End If
			If lv2Nums(2) < 9 Then 
				requiredNumbers(1) = lv2Nums(2) + 1
			End If
		ElseIf temp = 2 Then
			// e.g. 5 & 7, require for the middle one
			requiredNumbers = Array(lv2Nums(1) + 1)
		End If
	Else 
		// 3 LV3, claim it
	End If
End Function