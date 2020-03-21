[General]
SyntaxVersion=2
BeginHotkey=112
BeginHotkeyMod=0
PauseHotkey=122
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=27f9533d-6a72-4b15-95b1-8eaf2e2fe225
Description=play
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
UserVar delayMs=150 "間隔毫秒"
UserVar oriStartTeam=3 "開始隊伍"
UserVar oriEndTeam=3 "結束隊伍"
UserVar foodCount=1 "食物數量"
Dim direction, nowMP, nowCostMp, team, teamMp, teamCostMp, food, startTeam, endTeam
Dim endPointX, endPointY
Dim alreadyInTimeGap

// teamMp = Array(382, 17, 716, 17, 351, 0, 0, 0)
teamMp = Array(716, 656, 656, 656, 656, 656, 413, 0)
teamCostMp = Array(17, 17, 17, 17, 17, 17, 49, 0)

startTeam = oriStartTeam
endTeam = oriEndTeam
team = startTeam - 1

direction = 0
nowMP = teamMp(team)
nowCostMp = teamCostMp(team)

food = foodCount

endPointX = 169
endPointY = 811

alreadyInTimeGap = false

Call toBattlefield()

// =========== run!!! ===========
Rem run
If direction = 0 Then 
	// right to left
	KeyDown "I", 1
Else 
	// left to right
	KeyDown "P", 1
End If
Delay 1000

// =========== wait for battle ===========
Rem waitForBattle
If inField() Then 
	// change direction
	If direction = 0 Then 
		KeyUp "I", 1
		direction = 1
	Else 
		KeyUp "P", 1
		direction = 0
	End If
	Goto run
End If
If inBattle() = false Then 
	Delay delayMs
	If direction = 0 Then 
		// right to left
		KeyDown "I", 1
	Else 
		// left to right
		KeyDown "P", 1
	End If
	Goto waitForBattle
Else 
	If direction = 0 Then 
		KeyUp "I", 1
	Else 
		KeyUp "P", 1
	End If
End If

// =========== in battle, use skill ===========
Call useSkillByTeam()
KeyPress "Space", 1

// =========== wait for battle over ===========
Rem waitForOutOfBattle
If inField() = false Then 
	Delay delayMs
	KeyPress "Space", 1
	Goto waitForOutOfBattle
End If

If nowMP < nowCostMp Then 
	Call outOfMp()
End If
Goto run

// =========== end, trigger alarm ===========
Rem done
MoveTo endPointX, endPointY
LeftClick 1

/*********************************************************************************************
 *                                      Functions below                                      *
 *********************************************************************************************/
 
Sub toBattlefield
	Call openMap() // open map

	/* == monster dungeon == */
	/* MoveTo 483, 141
	LeftClick 1
	Delay 2000
	KeyPress "I", 1
	Delay 1000
	MoveTo 1096, 200
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == ryukujou == */
	/* MoveTo 361, 145
	LeftClick 1
	Delay 1000
	KeyPress "O", 1
	Delay 500
	MoveTo 685, 480
	LeftClick 1
	Delay 500
	MoveTo 1202, 390
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == mining villiage == */
	/* MoveTo 483, 141
	LeftClick 1
	Delay 1000
	MoveTo 324, 556
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == Snake Dream == */
	/* MoveTo 483, 141
	LeftClick 1
	Delay 1500
	MoveTo 1267, 490
	LeftClick 1
	Delay 1500
	// MoveTo 770, 271 // snake dream
	// MoveTo 1144, 563 // snake liver
	// MoveTo 769, 266 // snake head
	MoveTo 602, 590 // snake tail
	LeftClick 1
	Delay 1500
	KeyPress "Enter", 1 */
	/* == haunting castal == */
	/* MoveTo 605, 140
	LeftClick 1
	Delay 1000
	MoveTo 1230, 407
	LeftClick 1
	Delay 1000
	MoveTo 1205, 391
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == Museum == */
	/* MoveTo 605, 140
	LeftClick 1
	Delay 1000
	MoveTo 297, 330
	LeftClick 1
	Delay 1000
	MoveTo 1243, 385
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == Ancient Battlefield == */
	/* MoveTo 485, 142
	LeftClick 1
	Delay 2000
	KeyPress "I", 1
	Delay 1000
	MoveTo 1312, 586
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == IDA2 == */
	/* MoveTo 605, 140
	LeftClick 1
	Delay 1500
	MoveTo 908, 564
	LeftClick 1
	Delay 1000
	MoveTo 1171, 163
	LeftClick 1
	Delay 1000
	KeyPress "Enter", 1 */
	/* == Toto Playfield == */
	/* MoveTo 605, 140
	LeftClick 1
	Delay 1000
	MoveTo 1230, 407
	LeftClick 1
	Delay 1000
	MoveTo 1205, 391
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == Sand Towel == */
	/* MoveTo 482, 145
	LeftClick 1
	Delay 1500
	KeyPress "I", 1
	Delay 1000
	KeyPress "O", 1
	Delay 1000
	MoveTo 1425, 339
	LeftClick 1
	Delay 1000
	MoveTo 1258, 284
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1 */
	/* == Vega Forest == */
	MoveTo 361, 147
	LeftClick 1
	Delay 1500
	KeyPress "I", 1
	Delay 1000
	KeyPress "O", 1
	Delay 1000
	MoveTo 837, 341
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1
	
	Call waitInField() // wait transport
	
	Rem inFieldMove
	/* == monster dungeon == */
	/* KeyPress "9", 1
	Delay 500
	Call waitInField()
	KeyPress "9", 1
	Delay 500
	Call waitInField() */
	/* == mining villiage == */
	/* Call walking("I", 1100)
	Call walk("9")
	Call walking("I", 1100)
	Call walk("9")
	Call walking("I", 1100)
	Call walk("9")
	Call walking("P", 1100)
	Call walk("9")
	Call waitInField() */
	/* == snake head == */
	/* Call walk("I")
	Call walkToEnd("P")
	MoveTo 1049, 359
	LeftClick 1
	Call waitInField() */
	/* == snake tail == */
	/* Call walkToEnd("P")
	MoveTo 1432, 339
	LeftClick 1
	Call waitInField() */
	/* == haunting castal == */
	/* KeyPress "9", 1
	Delay 500
	Call waitInField() */
	/* == Museum == */
	/* KeyPress "9", 1
	Delay 500
	Call waitInField() */
	/* orge castal: no open map */
	/* alreadyInTimeGap = true
	Call walking("I", 1600)
	Call walk("9")
	Call walking("I", 2800)
	Call walk("9") // in memory room
	Call walk("9") // to mirror
	MoveTo 921, 246
	LeftClick 1
	Delay 2000
	MoveTo 830, 407
	LeftClick 1
	Call waitInField() // in mirror
	Call walk("9")
	KeyPress "9", 1 // open entrance selection
	Delay 2000
	// MoveTo 934, 317 // option 1
	// MoveTo 921, 406 // option 2
	MoveTo 922, 510 // option 3
	// MoveTo 915, 601 // option 4
	LeftClick 1
	Call waitInField()
	// Call walk("O") // for option 4
	Call walkToEnd("I") // for option 3
	MoveTo 624, 367 // for option 3
	LeftClick 1 // for option 3
	Call waitInField() // for option 3
	Call walk("I") // for option 3 */
	/* Sand Towel */
	/* Call walk("O") */
	
	Goto run // start the fight!
End Sub

Sub useSkillByTeam
	If team = 0 Then // 1
		Call useSkill("W", "2")
	ElseIf team = 1 Then // 2
		Call useSkill("W", "2")
	ElseIf team = 2 Then // 3
		Call useSkill("W", "2")
	ElseIf team = 3 Then // 4
		Call useSkill("Q", "2")
		Call useSkill("W", "2")
	ElseIf team = 4 Then // 5
		Call useSkill("Q", "2")
		Call useSkill("W", "2")
		Call useSkill("E", "2")
	ElseIf team = 5 Then // 6
		Call useSkill("Q", "2")
		Call useSkill("W", "2")
	ElseIf team = 6 Then // 7
		Call useSkill("W", "4")
	Else
	End If

	nowMP = nowMP - nowCostMp
End Sub

Sub outOfMp
	// team end, out of MP
	If team = (endTeam - 1) Then 
		If food > 0 Then 
			// if there's still some food, eat and restart
			Call eatFood()
			Goto waitForOutOfBattle
		Else 
			// else, goto end
			// Goto done
			Call goHome()
		End If
	End If
	
	// open team page
	KeyPress "Tab", 1
	Delay 1000
	KeyPress "A", 1
	Delay 2000
	
	// switch team
	If startTeam > endTeam Then 
		KeyPress "Left", 1
		team = team - 1
	Else 
		KeyPress "Right", 1
		team = team + 1
	End If
	Delay 1000
	
	// close team page
	KeyPress "Z", 1
	
	// reset MP
	nowMP = teamMp(team)
	nowCostMp = teamCostMp(team)
	
	Goto run
End Sub

Sub eatFood
	KeyPress "Tab", 1
	Delay 1000
	KeyPress "S", 1
	Delay 1000
	KeyPress "Enter", 1
	
	food = food - 1
	nowMP = teamMp(team) // reset MP
	
	// traverse team backward
	startTeam = oriEndTeam
	endTeam = oriStartTeam
End Sub

Function inBattle()
	FindPic 874,41,931,98,"C:\Users\Lee\Desktop\按鍵精靈\inBattleZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inBattle = true
	Else 
		inBattle = false
	End If
End Function

Function inField()
	FindPic 313,664,382,737,"C:\Users\Lee\Desktop\按鍵精靈\inFieldZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inField = true
	Else 
		inField = false
	End If
End Function

Function inMap()
	FindPic 1484,23,1577,85,"C:\Users\Lee\Desktop\按鍵精靈\inMapZone.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		inMap = true
	Else 
		inMap = false
	End If
End Function

Sub openMap
	KeyPress "W", 1

	Rem mapOpening
	If inMap() = false Then 
		Delay 500
		goto mapOpening
	End If
	
	Delay 500
End Sub

Sub waitInField
	Rem waitingForInField
	If inField() = false Then 
		Delay 500
		Goto waitingForInField
	End If
End Sub

Function useSkill(character, skill)
	KeyPress character, 1
	Delay delayMs
	KeyPress skill, 1
	Delay delayMs
End Function

Sub goHome
	Call openMap()
	If alreadyInTimeGap = false Then 
		MoveTo 726, 129
		LeftClick 1
		Delay 1000
	End If
	MoveTo 851, 424
	LeftClick 1
	Delay 500
	KeyPress "Enter", 1
	
	Call waitInField()
	
	MoveTo 711, 86
	LeftClick 1
	Delay 500
	Rem getFood
	If inField() = false Then 
		For 5
			MoveTo 1063, 423
			LeftClick 1
			Delay 100
		Next
		Goto getFood
	End If
	
	// reset food count
	food = foodCount
	// reset MP
	nowMP = teamMp(team)
	// traverse team forward
	startTeam = oriStartTeam
	endTeam = oriEndTeam

	Call toBattlefield()
End Sub

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