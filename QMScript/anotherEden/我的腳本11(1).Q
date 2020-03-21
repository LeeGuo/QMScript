[General]
SyntaxVersion=2
BeginHotkey=113
BeginHotkeyMod=0
PauseHotkey=122
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=453f1264-a935-4ed0-82cc-52c4e92b7ae4
Description=fishing
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
/*********************************************************************************************
 *                                definition & static setting                                *
 *********************************************************************************************/
UserVar scriptMode=DropList{"manual":1|"auto":2|"one round":3}=1 "mode"

UserVar stopBossFight=DropList{"X":0|"O":1}=0 "Boss Alarm"
Dim isBoss

Dim pointColor, x, y, i, thisColor
pointColor = Array(0, 0, 0, 0, 0, 0)
// x = Array(957, 995, 1025, 1059, 1115, 1147)
// y = Array(126, 126, 126, 126, 126, 126)
// x = Array(1290, 1295, 1275, 1299, 1313, 1326)
// y = Array(126, 126, 88, 77, 108, 90)
x = Array(1397, 1397, 1397, 1330, 1362, 1339)
y = Array(70, 100, 118, 52, 52, 93)

UserVar totalFishPoint=5 "¨Ï¥Î³½ÂI"
Dim emptyFishPoint, emptyFishPointCnt, fishPoint, nowFishPoint, fishLocation, numOfFish
numOfFish = 0
emptyFishPoint = Array(false, false, false, false, false)
fishPoint = Array("F", "G", "H", "J", "K")

UserVar nowLocation=DropList{"0¦¸¤¸¯UÁ_":0|"1½æ³½":1|"2¤Ú¾|¶ø©_":2|"3¸£¸ô­J":3|"4Às®c":4|"5¤ô³£":5|"6©_©Ô":6|"7Á{­}":7|"8¤õ¤s":8|"9¤ÑÁC´ò":9|"10¥d¹p§JÀã­ì":10|"11¯I¥Ë":11|"12Â÷®q":12|"13ªh¿A":13|"14¯ó­ì":14|"15¦¸¤¸´ò":15|"16¨Fºz":16|"17¾÷³õ":17|"18®ü©¤":18|"19Às®c1":19|"20Às®c2":20|"21Às®c3":21|"22Às®c4":22}=2 "²{¦b¦ì¸m"
UserVar minLocation=DropList{"0¦¸¤¸¯UÁ_":0|"1½æ³½":1|"2¤Ú¾|¶ø©_":2|"3¸£¸ô­J":3|"4Às®c":4|"5¤ô³£":5|"6©_©Ô":6|"7Á{­}":7|"8¤õ¤s":8|"9¤ÑÁC´ò":9|"10¥d¹p§JÀã­ì":10|"11¯I¥Ë":11|"12Â÷®q":12|"13ªh¿A":13|"14¯ó­ì":14|"15¦¸¤¸´ò":15|"16¨Fºz":16|"17¾÷³õ":17|"18®ü©¤":18|"19Às®c1":19|"20Às®c2":20|"21Às®c3":21|"22Às®c4":22}=2 "³Ì¤p¦ì¸m"
UserVar maxLocation=DropList{"0¦¸¤¸¯UÁ_":0|"1½æ³½":1|"2¤Ú¾|¶ø©_":2|"3¸£¸ô­J":3|"4Às®c":4|"5¤ô³£":5|"6©_©Ô":6|"7Á{­}":7|"8¤õ¤s":8|"9¤ÑÁC´ò":9|"10¥d¹p§JÀã­ì":10|"11¯I¥Ë":11|"12Â÷®q":12|"13ªh¿A":13|"14¯ó­ì":14|"15¦¸¤¸´ò":15|"16¨Fºz":16|"17¾÷³õ":17|"18®ü©¤":18|"19Às®c1":19|"20Às®c2":20|"21Às®c3":21|"22Às®c4":22}=2 "³Ì¤j¦ì¸m"
Dim mapAreaX, mapAreaY, inMapMove, localtionX, localtionY, fishIconX, fishIconY, fishIconV, fishIconVTime, skipLocation, locationName
Dim maxBaitLevelByLocation, minBaitLevelByLocation, bossBaitLevelByLocation
// ==== map area
// 362, 142 ascient 337 (-25) ~ 387 (+25)
// 481, 145 modern 456 (-25) ~ 506 (+25)
// 602, 136 future 577 (-25) ~ 627 (+25)
// 723, 129 time gap 698 (-25) ~ 748 (+25)
// ==== localtions
// 0: home
// 1: fish shop
// 2: barukiou
// 3: barukiou left
// 4: ryukuu jou
// 5: water city
// 6: beside the old man
// 7: harbor
// 8: volcano
// 9: tenlin lake
// 10: karlenu swan
// 11: sky island 
// 12: farest island
mapAreaX = Array(723, 362, 481, 481, 362, 362, 362, 481, 362, 362, 481, 602, 602, 362, 362, 723, 481, 602, 481, 362, 362, 362, 362)
mapAreaY = Array(129, 142, 145, 145, 142, 142, 142, 145, 142, 142, 145, 136, 136, 142, 142, 129, 145, 136, 145, 142, 142, 142, 142)
inMapMove = Array(false, false, false, false, "O", false, false, false, false, false, false, false, false, false, "i", false, false, false, false, "O", "O", "O", "O")
localtionX = Array(851, 635, 919, 919, 683, 824, 635, 1447, 1357, 824, 919, 294, 1521, 824, 1039, 851, 1447, 826, 1447, 683, 683, 683, 683)
localtionY = Array(424, 253, 387, 387, 471, 568, 253, 183, 185, 568, 387, 331, 218, 568, 104, 424, 183, 495, 183, 471, 471, 471, 471)
subLocatX = Array(-1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,1250, 1250,1250,1250)
subLocatY = Array(-1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,380, 380,380,380)
fishIconX = Array(0, 1111, 799, 843, 609, 1033, 1115, 990, 812, 821, 733, 1061, 789, 818, 897, 576, 826, 1015, 863, 829, 720, 740, 740)
fishIconY = Array(0, 256, 300, 356, 322, 298, 215, 299, 351, 357, 357, 324, 229, 184, 365, 284, 334, 359, 358, 327, 327, 328, 328)
// fish icon vibration range
fishIconV     = Array(0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0)
fishIconVTime = Array(0,  2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  4,  4, 0, 0, 0, 0, 0, 0, 0, 0, 0)
If stopBossFight = 1 Then 
	// boss
	skipLocation = Array(1,1,1,1,1, 0,1,1,1,1, 1,1,1,1,1, 1,0,0,0,1, 1,1,1)
Else 
	// non boss
	skipLocation = Array(1,1,1,1,1, 1,1,1,1,1, 0,0,1,0,0, 1,1,1,1,1, 1,1,1)
End If
// maxBaitLevelByLocation  = Array(-1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1) // specific bait
// minBaitLevelByLocation  = Array(-1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1,-1,-1) // specific bait
maxBaitLevelByLocation  = Array(-1,-1,-1,-1,-1, -1,-1, 3, 3, 3,  2,-1, 6, 4, 4,  4, 4, 4, 4, 1,  1, 1, 1)
minBaitLevelByLocation  = Array(-1,-1,-1,-1,-1, -1,-1,-1,-1,-1, -1,-1, 5, 2,-1, -1,-1,-1,-1,-1, -1,-1,-1)
bossBaitLevelByLocation = Array(-1,-1, 4,-1,-1,  4,-1,-1, 3,-1, -1,-1, 6,-1,-1,  4, 4, 4, 4,-1, -1,-1,-1) // space niddle required
locationName = Array("¦¸¤¸¯UÁ_", "½æ³½", "¤Ú¾|¶ø©_", "¸£¸ô­J", "Às®c", "¤ô³£", "©_©Ô", "Á{­}", "¤õ¤s", "¤ÑÁC´ò", "¥d¹p§JÀã­ì", "¯I¥Ë", "Â÷®q", "ªh¿A", "¯ó­ì", "¦¸¤¸´ò", "¨Fºz", "¾÷³õ", "®ü©¤", "Às®c1", "Às®c2", "Às®c3", "Às®c4")
UserVar skipLocationBySpecify=DropList{"§_":0|"¬O":1}=0 "¨Ï¥Î¤Uªí"
UserVar skipLocation2=DropList{"X":1|"O":0}=0 "¤Ú¾|¶ø©_"
UserVar skipLocation3=DropList{"X":1|"O":0}=0 "¸£¸ô­J"
UserVar skipLocation4=DropList{"X":1|"O":0}=0 "Às®c"
UserVar skipLocation5=DropList{"X":1|"O":0}=0 "¤ô³£"
UserVar skipLocation6=DropList{"X":1|"O":0}=0 "©_©Ô"
UserVar skipLocation7=DropList{"X":1|"O":0}=0 "Á{­}"
UserVar skipLocation8=DropList{"X":1|"O":0}=0 "¤õ¤s"
UserVar skipLocation9=DropList{"X":1|"O":0}=0 "¤ÑÁC´ò"
UserVar skipLocation10=DropList{"X":1|"O":0}=0 "¥d¹p§JÀã­ì"
UserVar skipLocation11=DropList{"X":1|"O":0}=0 "¯I¥Ë"
UserVar skipLocation12=DropList{"X":1|"O":0}=0 "Â÷®q"
UserVar skipLocation13=DropList{"X":1|"O":0}=0 "ªh¿A"
UserVar skipLocation14=DropList{"X":1|"O":0}=0 "¯ó­ì"
UserVar skipLocation15=DropList{"X":1|"O":0}=0 "¦¸¤¸´ò"
UserVar skipLocation16=DropList{"X":1|"O":0}=0 "¨Fºz"
UserVar skipLocation17=DropList{"X":1|"O":0}=0 "¾÷³õ"
UserVar skipLocation18=DropList{"X":1|"O":0}=0 "®ü©¤"
UserVar skipLocation19=DropList{"X":1|"O":0}=0 "Às®c1"
UserVar skipLocation20=DropList{"X":1|"O":0}=0 "Às®c2"
UserVar skipLocation21=DropList{"X":1|"O":0}=0 "Às®c3"
UserVar skipLocation22=DropList{"X":1|"O":0}=0 "Às®c4"

If skipLocationBySpecify = 1 Then 
	skipLocation(0) = 1
	skipLocation(1) = 1
	skipLocation(2) = skipLocation2
	skipLocation(3) = skipLocation3
	skipLocation(4) = skipLocation4
	skipLocation(5) = skipLocation5
	skipLocation(6) = skipLocation6
	skipLocation(7) = skipLocation7
	skipLocation(8) = skipLocation8
	skipLocation(9) = skipLocation9
	skipLocation(10) = skipLocation10
	skipLocation(11) = skipLocation11
	skipLocation(12) = skipLocation12
	skipLocation(13) = skipLocation13
	skipLocation(14) = skipLocation14
	skipLocation(15) = skipLocation15
	skipLocation(16) = skipLocation16
	skipLocation(17) = skipLocation17
	skipLocation(18) = skipLocation18
	skipLocation(19) = skipLocation19
	skipLocation(20) = skipLocation20
	skipLocation(21) = skipLocation21
	skipLocation(22) = skipLocation22
End If

UserVar minBaitLevel=DropList{"0³L°C":0|"1µð¥J1P":1|"2¿ÀÃÉ4P":2|"3Ä¯ÂÎ8P":3|"4Åý¥L»¡10P":4|"5³½¿|":5|"6°ª¯Å³½¿|":6}=0 "³Ì¤p³½»ç"
UserVar maxBaitLevel=DropList{"0³L°C":0|"1µð¥J1P":1|"2¿ÀÃÉ4P":2|"3Ä¯ÂÎ8P":3|"4Åý¥L»¡10P":4|"5³½¿|":5|"6°ª¯Å³½¿|":6}=0 "³Ì¤j³½»ç"
Dim baitX, baitY, baitCost, buyBaitAt, baitIconX, baitIconY, buyMax, baitName
Dim baitLevel, baitNumToDragDown, baitIconNumToDragDown
If stopBossFight = 1 Then 
	// use 30P
	baitNumToDragDown = 5
	baitX = Array(910, 910, 910, 910, 910, 910, 910)
	baitY = Array(226, 319, 405, 496, 640, 517, 609)
	// baitY = Array(226, 319, 405, 496, 579, 517, 609)
Else 
	baitNumToDragDown = 5
	baitX = Array(910, 910, 910, 910, 910, 910, 910)
	baitY = Array(226, 319, 405, 496, 579, 517, 609)
End If
baitCost = Array(0, 0, 0, 0, 0, 0, 0)
buyBaitAt = Array(335, 480, 50, 50, 50, 50, 50)
baitIconNumToDragDown = 3
If stopBossFight = 1 Then 
	// use 30P
	baitIconX = Array(1176, 1171, 1182, 1180, 1180, 1180, 1180)
	baitIconY = Array(271, 492, 701, 117, 440, 552, 668)
	// baitIconY = Array(271, 492, 701, 117, 323, 552, 668)
Else 
	baitIconX = Array(1176, 1171, 1182, 1180, 1180, 1180, 1180)
	baitIconY = Array(271, 492, 701, 117, 323, 552, 668)
End If
buyMax = Array(true, true, false, false, false, false, false)
baitName = Array("³L°C", "µð¥J", "¿ÀÃÉ", "Ä¯ÂÎ", "Åý¥L»¡", "³½¿|", "°ª¯Å³½¿|")

// ============ test zone ===============
// Call changeBait(4)
// fishLocation = 22
// Call toNextFishSpot()
// nowLocation = 15
// Call changeLocation(19)
// nowLocation = 17
// Call afterChangeLocation(21)
// afterChangeLocation (7)
/* If clickFishIconByGraph(12) = false Then 
	MessageBox "something wrong"
Else 
	MessageBox "clicked"
End If */

/* baitCost(1) = 496
Call buyBait(1)
baitCost(2) = 70
Call buyBait(2) */
/* For 2
	KeyPress "9", 1
	Delay 1000
Next */
/* baitCost(3) = 70
Call buyBait(3)
baitCost(4) = 40
Call buyBait(4)
baitCost(5) = 1
Call buyBait(5)
baitCost(6) = 60
Call buyBait(6) */
// ======================================

/*********************************************************************************************
 *                                    main program below                                     *
 *********************************************************************************************/

If scriptMode = 1 Then 
	Call changeColorPoint()
	Call getBaselineColors()
	While isSameColor() = true
		Delay 1
	Wend
	KeyPress "Space", 1
	EndScript
End If
If scriptMode = 3 Then 
	GetCursorPos nowX, nowY
	fishIconX(nowLocation) = nowX
	fishIconY(nowLocation) = nowY
End If

// ========= wait for fish window to be loaded =========
Rem waitForFishWindowToBeLoaded
// open fish window
If nowLocation = 12 OR nowLocation = 13 Then 
	While clickFishIconByGraph(nowLocation) = false
		Delay 1000
	Wend
Else 
	whileRnd = 0
	While inField() = true
		MoveTo fishIconX(nowLocation) - (fishIconV(nowLocation)*fishIconVTime(nowLocation)) + ((whileRnd Mod ((fishIconVTime(nowLocation)*2)+1)) * fishIconV(nowLocation)), fishIconY(nowLocation)
		LeftClick 1
		Delay 1000
		whileRnd = whileRnd + 1
	Wend
End If
// and wait
While isReadyToFish() = false
	If inField() = true Then 
		TracePrint "something wrong, open fish window failed"
		goto waitForFishWindowToBeLoaded
	End If
	Delay 500
Wend
Delay 1000

// record now fish location
fishLocation = nowLocation
// initial variables
Call initFishPoint()
// get baseline color
Call getBaselineColors()
// bait usage initialization at FISRT time only
If numOfFish = 0 Then 
	If minBaitLevelByLocation(fishLocation) > - 1  Then 
		Call changeBait(minBaitLevelByLocation(fishLocation))
	Else 
		Call changeBait(minBaitLevel)
	End If
End If

// ========= ready to fish ==========
Rem waitForFishReady
While isReadyToFish() = false
	KeyPress "Space", 1
	Delay 500
	If inField() = true Then 
		TracePrint "something wrong"
		goto waitForFishWindowToBeLoaded
	End If
Wend
Call waitForReadyToFish(true)

// =========  go fish!!! ==========
Rem goFishing
While isReadyToFish() = true
	KeyPress fishPoint(nowFishPoint), 1
	Delay 500
	
	// no more fish ?
	If isSameColor() = false Then 
		Goto ending
	End If
Wend
Delay 1000

// ========= wait for fish to eat the bait ==========
While true
	If isSameColor() = false Then 
		// pull it!
		KeyPress "Space", 1
		Delay 500
		KeyPress "Space", 1
		
		// this fish point has no more fish ?
		Delay 1500
		If isReadyToFish() = true Then 
			emptyFishPoint(nowFishPoint) = true
			emptyFishPointCnt = emptyFishPointCnt + 1
			Call nextFishPoint()
		End If
		
		numOfFish = numOfFish + 1
		baitCost(baitLevel) = baitCost(baitLevel) + 1
		
		isBoss = false
		Goto pullingFish
	End If
	
	If isReadyToFish() = true Then 
		goto goFishing
	End If
Wend

// ========= pulling fish ==========
Rem pullingFish
While true
	If isReadyToFish() = true Then 
		Call nextFishPoint()
	End If
	
	// had fight, back to main window
	If inField() = true Then 
		Delay 1000
		Goto waitForFishWindowToBeLoaded
	End If
	
	// boss fight, alarm
	If stopBossFight = 1 AND bossBaitLevelByLocation(fishLocation) > - 1  AND baitLevel = bossBaitLevelByLocation(fishLocation) AND inBattle() Then 
		If isBoss = true Then 
			TracePrint "Boss fight !!"
			MessageBox "Boss fight !!"
		Else 
			While inBattle() = true
				KeyPress "Space", 1
				Delay 500
			Wend
			isBoss = true
		End If
	End If

	KeyPress "Space", 1
	Delay 200
	Goto pullingFish
Wend

// ========= ending ==========
Rem ending
// single fish pool mode
If scriptMode = 3 Then 
	Call bye()
End If
MoveTo 1419, 704 // close fish window
LeftClick 1
Call waitInField(false)

If numOfFish > 0 Then 
	TracePrint "³L°C" & baitCost(0) & ", µð¥J" & baitCost(1) & " ¿ÀÃÉ" & baitCost(2) & " Ä¯ÂÎ" & baitCost(3) & " Åý¥L»¡" & baitCost(4) & " ³½¿|" & baitCost(5) & " °ª³½¿|" & baitCost(6) & " @ " & locationName(fishLocation) & ", ¦@" & numOfFish & " °¦ - " & Plugin.GetSysInfo.GetDateTime
	Call changeLocation(1)
	Call toNextFishSpot()
Else 
 	// wait for fish to be respawn
	Delay 1000 * 60
	Goto waitForFishWindowToBeLoaded
End If

/*********************************************************************************************
 *                                      Functions below                                      *
 *********************************************************************************************/

// ------------- functions: get fish pool color --------------
Function changeColorPoint()
	// special points for time gap
	If nowLocation = 15 Then 
		x = Array(1397, 1397, 1397, 1330, 1362, 1339)
		y = Array(70, 100, 118, 52, 52, 93)
	Else 
		x = Array(957, 995, 1025, 1059, 1115, 1147)
		y = Array(126, 126, 126, 126, 126, 126)
	End If
End Function

Function getBaselineColors()
	Call changeColorPoint()
	i = 0
	While i < 6
		pointColor(i) = GetPixelColor(x(i), y(i))
		i = i + 1
	Wend
End Function

Function isSameColor
	i = 0
	break = false
	sameColor = true
	While break = false and i < 6
		thisColor = GetPixelColor(x(i), y(i))
		If thisColor <> pointColor(i) Then 
			break = true
			sameColor = false
		End If
		i = i + 1
	Wend
	isSameColor = sameColor
End Function

Function isReadyToFish()
	FindPic 288,561,333,613,"C:\Users\Lee\Desktop\«öÁäºëÆF\readyToFish2.bmp",1.0,intX,intY
	//FindPic 885,670,962,737,"C:\Users\Lee\Desktop\«öÁäºëÆF\readyToFish.bmp",0.6,intX,intY
	If intX > 0 And intY > 0 Then 
		isReadyToFish = true
	Else 
		isReadyToFish = false
	End If
End Function

Function clickFishIconByGraph(locationNO)
	If inField() = false Then 
		clickFishIconByGraph = false
		Exit Function
	End If

	// get icon
	If locationNO = 12 Then 
		FindPic 309,152,1546,304,"C:\Users\Lee\Desktop\«öÁäºëÆF\fishIcon12.bmp",0.9,graphFishX,graphFishY
	ElseIf locationNO = 13 Then
		FindPic 303,122,1539,238,"C:\Users\Lee\Desktop\«öÁäºëÆF\fishIcon13.bmp",0.9,graphFishX,graphFishY
	End If
	If graphFishX > 0 And graphFishY > 0 Then 
		graphFishX = graphFishX + 30
		graphFishY = graphFishY + 13
	Else 
		// icon not found, error
		clickFishIconByGraph = false
		Exit Function
	End If
	
	While inField() = true
		MoveTo graphFishX, graphFishY
		LeftClick 1
		Delay 1000
	Wend
	clickFishIconByGraph = true
End Function

Function waitForReadyToFish(shouldClick)
	While isReadyToFish() = false
		If shouldClick = true Then 
			KeyPress "Space", 1
		End If
		Delay 500
	Wend
End Function

Function inBattle()
	FindPic 874,41,931,98,"C:\Users\Lee\Desktop\«öÁäºëÆF\inBattleZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inBattle = true
	Else 
		inBattle = false
	End If
End Function

Function inField()
	FindPic 313,664,382,737,"C:\Users\Lee\Desktop\«öÁäºëÆF\inFieldZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inField = true
	Else 
		inField = false
	End If
End Function

Function waitInField(shouldClick)
	While inField() = false
		If shouldClick = true Then 
			KeyPress "Space", 1
		End If
		Delay 500
	Wend
End Function

// ------------- functions: map operation checking --------------
Function inMap()
	FindPic 1484,23,1577,85,"C:\Users\Lee\Desktop\«öÁäºëÆF\inMapZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inMap = true
	Else 
		inMap = false
	End If
End Function

Function isMapCursorReady(locationNO)
	FindPic mapAreaX(locationNO)-25,75,mapAreaX(locationNO)+25,100,"C:\Users\Lee\Desktop\«öÁäºëÆF\mapAreaCursor.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isMapCursorReady = true
	Else 
		isMapCursorReady = false
	End If
End Function

Function openMap(localtionNO)
	KeyPress "W", 1

	Rem mapOpening
	If inMap() = false Then 
		Delay 500
		goto mapOpening
	End If
	Delay 500

	// check map ready
	While isMapCursorReady(localtionNO) = false
		Delay 500
	Wend
End Function

Function changeMapArea(localtionNO)
	whileRnd = 0
	While isMapCursorReady(localtionNO) = false
		If whileRnd Mod 10 = 0 Then 
			MoveTo mapAreaX(localtionNO), mapAreaY(localtionNO)
			LeftClick 1
		End If
		whileRnd = whileRnd + 1
		Delay 500
	Wend
End Function

Function gotoLocation(localtionNO)
	whileRnd = 0
	While inMap() = true
		If whileRnd Mod 2 = 0 Then 
			MoveTo localtionX(localtionNO), localtionY(localtionNO)
			LeftClick 1
			If subLocatX(localtionNO) > - 1  Then 
				Delay 1000
				MoveTo subLocatX(localtionNO), subLocatY(localtionNO)
				LeftClick 1
			End If
		End If
		whileRnd = whileRnd + 1
		Delay 500
	Wend
	While inField() = false
		KeyPress "Enter", 1
		Delay 1000
	Wend
	// wait for transportation delay
	Delay 1000
	// location changed
	nowLocation = localtionNO
End Function

// ------------- functions: walking --------------
Function walk(dir)
	KeyPress dir, 1
	While inField() = true
		Delay 100
	Wend
	While inField() = false
		If inBattle() = true Then 
			While inField() = false
				KeyPress "Space", 1
				Delay 500
			Wend
			Delay 1000
			walk = false
			Exit Function
		End If
		Delay 500
	Wend
	walk = true
End Function

Function walking(dir, duration)
	durationUnit = 100
	durationNum = Round((duration / durationUnit), 0)
	For durationNum
		KeyDown dir, 1
		Delay durationUnit
	Next
	KeyUp dir, 1
	While inField() = false
		If inBattle() = true Then 
			While inField() = false
				KeyPress "Space", 1
				Delay 500
			Wend
			Delay 1000
			walking = false
			Exit Function
		End If
		Delay 500
	Wend
	/* Delay 1000
	If inField() = false AND inBattle() = true Then 
		While inField() = false
			KeyPress "Space", 1
			Delay 500
		Wend
		Delay 1000
		walking = false
		Exit Function
	End If */
	walking = true
End Function

Function walkToEnd(dir)
	KeyDown dir, 1
	While inField() = true
		KeyDown dir, 1
		Delay 100
	Wend
	While inField() = false
		KeyDown dir, 1
		Delay 500
	Wend
	KeyUp dir, 1
End Function

Function walkToEndWithFight(dir)
	KeyDown dir, 1
	While inField() = true
		KeyDown dir, 1
		Delay 100
	Wend
	While inField() = false
		KeyDown dir, 1
		If inBattle() = true Then 
			KeyUp dir, 1
			While inField() = false
				KeyPress "Space", 1
				Delay 500
			Wend
			KeyDown dir, 1
			Delay 1000
		End If
		Delay 500
	Wend
	KeyUp dir, 1
End Function

Function wakeMonsterAndToEnd(dir)
	While inBattle() = false
		KeyDown "I", 1
		Delay 700
		KeyUp "I", 1
		Delay 200
		KeyDown "P", 1
		Delay 700
		KeyUp "P", 1
		Delay 200
	Wend
	While inField() = false
		KeyPress "Space", 1
		Delay 500
	Wend
	Delay 1000
	Call walkToEndWithFight(dir)
End Function

// ------------- functions: change location --------------
Function changeLocation(localtionNO)
	// to time gap
	If mapAreaX(nowLocation) = mapAreaX(localtionNO) Then 
		Call openMap(nowLocation)
		// change area
		Call changeMapArea(0)
		// choose location
		Call gotoLocation(0)
	End If
	Call openMap(nowLocation)
	// change area
	Call changeMapArea(localtionNO)
	// in-map drag
	If inMapMove(localtionNO) <> false Then 
		Delay 1000
		KeyPress inMapMove(localtionNO), 1
		Delay 1000
	End If
	// choose location
	Call gotoLocation(localtionNO)

	Call afterChangeLocation(localtionNO)
End Function

Function afterChangeLocation(localtionNO)
	If localtionNO = 1 Then 
		Call walking("I", 1500)
		// open shop
		whileRnd = 0
		While inField()
			MoveTo fishIconX(localtionNO) - (fishIconV(localtionNO)*fishIconVTime(localtionNO)) + ((whileRnd Mod ((fishIconVTime(localtionNO)*2)+1)) * fishIconV(localtionNO)), fishIconY(localtionNO)
			LeftClick 1
			Delay 500
			whileRnd = whileRnd + 1
		Wend
		Delay 1000
		// close shop
		While inField() = false
			KeyPress "Z", 1
			Delay 1500
		Wend
		Delay 1000
		numOfFish = 0 // fish sold
		
		needToBuyBait = false
		For i = 0 To UBound(baitCost)
			If baitCost(i) >= buyBaitAt(i) Then 
				needToBuyBait = true
				Exit For
			End If
		Next
		If needToBuyBait = true Then 
			// open shop
			whileRnd = 0
			While inField()
				MoveTo fishIconX(localtionNO) - (fishIconV(localtionNO)*fishIconVTime(localtionNO)) + ((whileRnd Mod ((fishIconVTime(localtionNO)*2)+1)) * fishIconV(localtionNO)), fishIconY(localtionNO)
				LeftClick 1
				Delay 500
				whileRnd = whileRnd + 1
			Wend
			Delay 1000
			// buying
			For i = 0 To UBound(baitCost)
				// for latter baits, drag the window to the bottom
				If i = baitIconNumToDragDown Then 
					For 2
						KeyPress "9", 1
						Delay 1000
					Next
				End If
				If baitCost(i) >= buyBaitAt(i) Then 
					TracePrint "buy bait " & baitName(i) & ": " & baitCost(i)
					Call buyBait(i)
				End If
			Next
			// close shop
			While inField() = false
				KeyPress "Z", 1
				Delay 1500
			Wend
			Delay 1000
		End If
	ElseIf localtionNO = 2 Then
		Call walking("I", 1100)
		Call walk("9")
		Call walkToEnd("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 3 Then
		Call walkToEnd("I")
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 4 Then
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 5 Then
		Call walking("I", 900)
		Call walk("9")
		Call walkToEnd("P")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 6 Then
		Call walking("I", 2200)
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 7 Then
		Call walking("P", 1200)
		Call walk("O")
		Call walkToEnd("P")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 8 Then
		Call walk("O")
		// in monster area
		Call walkToEndWithFight("P")
		If walking("I", 800) = false Then 
			Call changeLocation(localtionNO)
			Exit Function
		End If
		If walk("O") = false Then 
			Call changeLocation(localtionNO)
			Exit Function
		End If
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 9 Then
		Call walkToEnd("P")
		Call walk("9")
		// in monster area
		Call walkToEndWithFight("P")
		If walking("I", 900) = false Then 
			Call changeLocation(localtionNO)
			Exit Function
		End If
		Call walk("O")
		Call walkToEndWithFight("P")
		Call walk("9")
		Call walkToEndWithFight("P")
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 10 Then
		// in monster area
		Call walkToEndWithFight("P")
		While walking("I", 900) = false
			Call walkToEndWithFight("P")
		Wend
		Call walk("9")
		Call walkToEndWithFight("I")
		While walking("P", 300) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("9")
		Call walkToEndWithFight("P")
		While walking("I", 2000) = false
			Call walkToEndWithFight("P")
		Wend
		Call walk("9")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 11 Then
		Call walk("I")
		Call walk("O")
		Call walkToEnd("P")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 12 Then
		Call walking("I", 800)
		Call walk("9")
		Call walking("P", 900)
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 13 Then
		Call walking("I", 900)
		Call walk("9")
		Call walkToEnd("I")
		MoveTo 1044, 197
		// take boat
		While inField() = true
			LeftClick 1
			Delay 500
		Wend
		Call waitInField(true)
		Call walkToEnd("P")
		Call walk("9")
		Call walkToEnd("I")
		Call walk("9")
		// in monster area
		If walking("P", 3200) = false Then 
			Call changeLocation(localtionNO)
			Exit Function
		End If
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 14 Then
		Call walking("I", 1700)
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 15 Then
		Call walking("I", 1600)
		Call walk("9")
		Call walkToEnd("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 16 Then
		// goto time gap first
		Call openMap(nowLocation)
		Call changeMapArea(0)
		Call gotoLocation(0)
		// take space ship
		Call openMap(0)
		While inMap() = true
			MoveTo 1178, 537
			LeftClick 1
			Delay 1000
		Wend
		While inField() = false
			KeyPress "Enter", 1
			Delay 1000
		Wend
		While inField() = true
			MoveTo 774, 362
			LeftClick 1
			Delay 1000
		Wend
		While inField() = false
			MoveTo 934, 229
			LeftClick 1
			Delay 1000
		Wend
		// arrive dessert area
		nowLocation = 16
		// in monster area
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 17 Then
		Call walking("P", 700)
		whileRnd = 0
		While inField() = true
			MoveTo 799 - 90 + ((whileRnd Mod 7) * 30), 236
			LeftClick 1
			Delay 500
			whileRnd = whileRnd + 1
		Wend
		While inField() = false
			MoveTo 920, 407
			LeftClick 1
			Delay 500
		Wend
		// in monster area
		Call walkToEndWithFight("P")
		Call walk("9")
		Call walkToEndWithFight("P")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 18 Then
		Call walkToEndWithFight("I")
		Call wakeMonsterAndToEnd("I")
		Call walking("P", 1400)
		Call walk("9")
		Call walking("I", 4300)
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 19 Then
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 20 Then
		Call walkToEndWithFight("I")
		// something
		While inField() = true
			MoveTo 669, 328
			LeftClick 1
			Delay 500
		Wend
		While inField() = false
			MoveTo 1055, 422
			LeftClick 1
			Delay 500
		Wend
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 21 Then
		Call walkToEndWithFight("I")
		While walking("P", 1900) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		While walking("P", 1300) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		While walking("P", 1900) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O") // change map
		Call walkToEndWithFight("I")
		While walking("P", 800) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	ElseIf localtionNO = 22 Then
		Call walkToEndWithFight("I")
		// something
		While inField() = true
			MoveTo 669, 328
			LeftClick 1
			Delay 500
		Wend
		While inField() = false
			MoveTo 1055, 422
			LeftClick 1
			Delay 500
		Wend
		While walking("P", 1900) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		While walking("P", 1100) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		While walking("P", 1900) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O") // change map
		Call walkToEndWithFight("I")
		While walking("P", 800) = false
			Call walkToEndWithFight("I")
		Wend
		Call walk("O")
		Call walkToEndWithFight("I")
		Goto waitForFishWindowToBeLoaded // start fishing
	End If
End Function

// ------------- functions: fish point related --------------
Sub initFishPoint
	// fish point initialization
	nowFishPoint = 0
	emptyFishPointCnt = 0
	For i = 0 to (totalFishPoint - 1)
		emptyFishPoint(i) = false
	Next
End Sub

Sub nextFishPoint
	If emptyFishPointCnt = totalFishPoint Then 
		If bossBaitLevelByLocation(fishLocation) = -1 OR stopBossFight = 1 Then 
			If maxBaitLevelByLocation(fishLocation) = -1  Then 
				checkingBaitLevel = maxBaitLevel
			Else 
				checkingBaitLevel = maxBaitLevelByLocation(fishLocation)
			End If
		Else 
			checkingBaitLevel = bossBaitLevelByLocation(fishLocation) - 1
		End If
		If baitLevel < checkingBaitLevel Then 
			Call changeBait(baitLevel + 1)
		Else
			// next pool
			Goto ending
		End If
	End If
	nowFishPoint = (nowFishPoint + 1) Mod totalFishPoint
	While emptyFishPoint(nowFishPoint) = true
		nowFishPoint = (nowFishPoint + 1) Mod totalFishPoint
	Wend
	Goto waitForFishReady
End Sub

Sub toNextFishSpot
	newSpot = (fishLocation + 1) Mod (maxLocation + 1)
	While skipLocation(newSpot) = 1
		newSpot = (newSpot + 1) Mod (maxLocation + 1)
	Wend
	changeLocation(newSpot)
End Sub

// ------------- functions: bait related --------------
Function changeBait(lv)
	// open bait storage
	MoveTo 1175, 704
	LeftClick 1
	Delay 1000
	
	// need to drag window down to click 7th and after bait
	If lv >= baitNumToDragDown Then 
		KeyPress "9", 1
		Delay 1000
	End If
	
	// choose bait
	MoveTo baitX(lv), baitY(lv)
	LeftClick 1
	Delay 1000
	
	baitLevel = lv
	
	// initialize fish point
	Call initFishPoint()
End Function

Function isBaitPurchaseAvailable()
	FindPic 600,568,685,680,"C:\Users\Lee\Desktop\«öÁäºëÆF\canBuyBait.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isBaitPurchaseAvailable = true
	Else 
		isBaitPurchaseAvailable = false
	End If
End Function

Function buyBait(baitNo)
	// choose bait
	MoveTo baitIconX(baitNo), baitIconY(baitNo)
	LeftClick 1
	Delay 1000

	If buyMax(baitNo) = true OR baitCost(baitNo) > 99 Then 
		While isBaitPurchaseAvailable() = true
			// plusing
			MoveTo 641, 508
			LeftDown 1
			Delay 11000
			LeftUp 1
			// minus 1
			MoveTo 412, 510
			LeftClick 1
			// buy
			MoveTo 534, 648
			LeftClick 1
			Delay 500
			KeyPress "Enter", 1
			Delay 500
			MoveTo 925, 450
			LeftClick 1
			Delay 1000
		Wend
		baitCost(baitNo) = 0
	Else 
		// plusing
		For baitCost(baitNo) - 1
			MoveTo 641, 508
			LeftClick 1
			Delay 100
		Next
		
		If isBaitPurchaseAvailable() = true Then 
			// buy
			MoveTo 534, 648
			LeftClick 1
			Delay 500
			KeyPress "Enter", 1
			Delay 500
			MoveTo 925, 450
			LeftClick 1
			Delay 2000
			
			baitCost(baitNo) = 0
		End If
	End If
End Function

// ------------- functions: miscelleous --------------
Sub bye
	MessageBox "³L°C" & baitCost(1) & " µð¥J" & baitCost(2) & " ¿ÀÃÉ" & baitCost(3) & " Ä¯ÂÎ" & baitCost(4) & ", ¦@" & numOfFish & " °¦ - " & Plugin.GetSysInfo.GetDateTime
	EndScript
End Sub
