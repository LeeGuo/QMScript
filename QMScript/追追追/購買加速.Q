[General]
SyntaxVersion=2
BeginHotkey=119
BeginHotkeyMod=0
PauseHotkey=122
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=2b990b36-b99c-4b73-a19b-2dac9ccc67fc
Description=購買加速
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
UserVar interval=0 "checking interval seconds"
UserVar needSetAutoReborn=DropList{"no":0|"yes":1}=0 "自動重生"
UserVar clickRagePower=DropList{"no":0|"yes":1}=0 "點無雙"
Dim feverCnt, disconnectedCnt

feverCnt = 0
disconnectedCnt = 0

dx = 0
If shopAvailable() = false Then 
	dx = 1920
	If shopAvailable() = false Then 
		MessageBox "Game window not detected at both screen"
		ExitScript
	End If
End If

// focus on game window
MoveTo 973 + dx, 11
LeftClick 1

Dim failCnt

Rem waiShopAvailable
If shopAvailable() = false Then 
	Delay 2000
	Call isLongOffline()
	Call closeEventWindow()
	Goto waiShopAvailable
End If

Rem inShop
While shopAvailable() = true
	KeyPress "Tab", 1
	Delay 2000
Wend

Rem checkSpeedUpAvailableAndBuy
KeyPress "2", 1 // change shop tab
Delay 1000
If speedUpAvailable() = false Then 
	// speed up not available
	Goto leavingShop
Else 
	// click buy button
	While isInShop() = true
		KeyPress "B", 1
		Delay 2000
	Wend
	
	If isNoAds() = true Then 
		While isInShop() = false
			Delay 1000
		Wend
		Goto leavingShop
	End If
End If

Rem outAndIn
Delay 40000
// TODO: check no Ads cases with isShopBlackedOut()
failCnt = -1
While isInShop() = false
	// in-n-out 5 times, means game crashed
	failCnt = failCnt + 1
	If failCnt >= 10 Then 
		While closeGame() = false
		Wend
		failCnt = -1
	End If
	
	While isAtDesktop() = false
		KeyPress "Home", 1
		Delay 3000
	Wend
	
	While isAtDesktop() = true
		Call clickGameIcon()
		Delay 3000
	Wend
	
	// check if game crashed
	If gameReconnected() = true Then 
		Goto inShop
	End If
Wend

Rem leavingShop
While isInShop() = true
	KeyPress "Esc", 1 // leave shop
	Delay 1000
Wend

Rem setAutoReborn
If needSetAutoReborn = 1 Then 
	If isOverLimitAndReborn() = true Then
		// reborned, upgrading characters for 5 minutes
		Delay 10000
		For 5
			KeyDown "T", 1
			KeyDown "R", 1
			KeyDown "E", 1
			KeyDown "W", 1
			Delay 1000 * 60
			KeyUp "W", 1
			KeyUp "E", 1
			KeyUp "R", 1
			KeyUp "T", 1
		Next
		KeyDown "Q", 1
		Delay 30000
		KeyUp "Q", 1
	End If
End If

Rem waitForNextRunOfChecking
For interval
	If clickRagePower = 1 AND ragePowerReady() = true Then 
		KeyPress "`", 1
		While ragePowerReady() = true
			Call isGoldFever()
			Delay 2000
			KeyPress "`", 1
		Wend
	End If
	For 12
		Call isGoldFever()
		Delay 50
	Next
	
	If isDisconnected() = true Then 
		Call restartGame()
		
		// wait game to be reconnected
		While gameReconnected() = false
			Delay 3000
		Wend
	End If
Next
Goto waiShopAvailable

//=============== functions ================

Function shopAvailable
	FindPic 107+dx,873,194+dx,940,"C:\Users\Lee\Desktop\QMC\shopAvailable.bmp",0.9,intX,intY	
	If intX > 0 And intY > 0 Then 
		shopAvailable = true
	Else 
		shopAvailable = false
	End If
End Function

Function isLongOffline
	FindPic 565+dx,80,834+dx,197,"C:\Users\Lee\Desktop\QMC\longOffline.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		Delay 3000
		MoveTo 411+dx, 894
		LeftClick 1
		Delay 1000
		isLongOffline = true
	Else 
		isLongOffline = false
	End If
End Function

Function isInShop
	FindPic 640+dx,57,694+dx,108,"C:\Users\Lee\Desktop\QMC\isInShop.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isInShop = true
	Else 
		isInShop = false
	End If
End Function

Function speedUpAvailable
	IfColor 973+dx,930,"1795AD",0 Then
		speedUpAvailable = true
	Else 
		speedUpAvailable = false
	End If
End Function

Function isAtDesktop
	FindPic 621+dx,302,688+dx,362,"C:\Users\Lee\Desktop\QMC\atDesktop.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isAtDesktop = true
	Else 
		isAtDesktop = false
	End If
End Function

Sub clickGameIcon
	MoveTo 1511+dx, 692 // click game icon
	LeftClick 1
End Sub

Function turnOnAutoBattle
	MoveTo 1778+dx, 159
	LeftClick 1
	Delay 1000

	FindPic 1328+dx,577,1415+dx,662,"C:\Users\Lee\Desktop\QMC\autoBattleOn.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
	Else 
		MoveTo 1222+dx, 590
		LeftClick 1
	End If
	
	// exit setting window
	KeyPress "Esc", 1
	Delay 2000
End Function

Function ragePowerReady
	IfColor 441+dx,59,"FFFFFF",0 Then
		ragePowerReady = true
	Else 
		ragePowerReady = false
	End If
End Function

Function isGameToBeClosed
	FindPic 1224+dx,215,1309+dx,296,"C:\Users\Lee\Desktop\QMC\windowsTobeClosed.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isGameToBeClosed = true
	Else 
		isGameToBeClosed = false
	End If
End Function

Function closeGame
	While isGameToBeClosed() = false and isAtDesktop() = false
		KeyPress "PageUp", 1
		Delay 5000
	Wend
	
	While isGameToBeClosed() = true
		MoveTo 1265+dx, 257
		LeftClick 1
		Delay 1000
	Wend
	
	Delay 5000
	If isAtDesktop() = false Then 
		closeGame = false
	Else 
		closeGame = true
	End If
End Function

Function isDisconnected
	FindPic 823+dx,638,1054+dx,770,"C:\Users\Lee\Desktop\QMC\disconnected.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		disconnectedCnt = disconnectedCnt + 1
		TracePrint "disconnected! totally " & disconnectedCnt & " times @ " & Plugin.GetSysInfo.GetDateTime
		isDisconnected = true
	Else 
		isDisconnected = false
	End If
End Function

Function restartGame
	Call closeGame()
	
	While isAtDesktop() = true
		Call clickGameIcon()
		Delay 3000
	Wend
End Function

Function gameReconnected
	If shopAvailable() = true OR isLongOffline() = true OR closeEventWindow() = true Then 
		Delay 10000
		While shopAvailable() = false
			Call closeEventWindow()
			Call isLongOffline()
		Wend

		Call turnOnAutoBattle()
		
		Delay 3000
		While shopAvailable() = false
			Call closeEventWindow()
			Call isLongOffline()
		Wend

		gameReconnected = true
	Else 
		gameReconnected = false
	End If
End Function

Function closeEventWindow
	FindPic 860+dx,74,1023+dx,179,"C:\Users\Lee\Desktop\QMC\eventWindow.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		Delay 1000
		MoveTo 1691+dx, 166
		LeftClick 1
		Delay 1000
		closeEventWindow = true
	Else 
		closeEventWindow = false
	End If
End Function

Function isNoAds
	FindPic 627+dx,406,881+dx,618,"C:\Users\Lee\Desktop\QMC\noAds.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		// close no ads window
		KeyPress "S", 1
		isNoAds = true
	Else 
		isNoAds = false
	End If
End Function

Function isGoldFever
	feverPic1 = "C:\Users\Lee\Desktop\QMC\goldFeverLet.bmp"
	feverPic2 = "C:\Users\Lee\Desktop\QMC\goldFeverLet2.bmp"
	feverNotFound = false
	FindPic 799+dx,462,1137+dx,610,feverPic1,0.7,intX,intY
	FindPic 799+dx,462,1137+dx,610,feverPic2,0.8,intX2,intY2
	If intX > 0 And intY > 0 Then 
		feverPic = feverPic1
	ElseIf intX2 > 0 And intY2 > 0 Then
		feverPic = feverPic2
	Else 
		feverNotFound = true
	End If
	
	If feverNotFound = true Then 
		isGoldFever = false
	Else 
		notFeverCnt = 0
		clickCnt = 0
		While notFeverCnt <= (clickCnt * 2) AND notFeverCnt < 10
			FindPic 799+dx,462,1137+dx,610,feverPic,0.8,intX,intY
			If intX > 0 And intY > 0 Then 
				KeyPress "I", 1
				// notFeverCnt = 0
				clickCnt = clickCnt + 1
			Else 
				notFeverCnt = notFeverCnt + 1
			End If
			Delay 50
		Wend
		If clickCnt > 0 Then 
			feverCnt = feverCnt + 1
			TracePrint feverPic & "! totally " & feverCnt & " times @ " & Plugin.GetSysInfo.GetDateTime
		End If
		isGoldFever = true
	End If
End Function

Function isInRebornWindow
	FindPic 1189+dx,29,1314+dx,197,"C:\Users\Lee\Desktop\QMC\rebornWindow.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		isInRebornWindow = true
	Else 
		isInRebornWindow = false
	End If
End Function

Function clickConfirmReborn
	FindPic 54+dx,32,1831+dx,1036,"C:\Users\Lee\Desktop\QMC\confirmReborn.bmp",0.6,intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY + 383
		LeftClick 1
		clickConfirmReborn = true
	Else 
		clickConfirmReborn = false
	End If
End Function

Function isReborned
	FindPic 994+dx,798,1139+dx,931,"C:\Users\Lee\Desktop\QMC\reborned.bmp",0.9,intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo 958+dx, 861
		LeftClick 1
		isReborned = true
	Else 
		isReborned = false
	End If
End Function

Function isOverLimitAndReborn
	IfColor 282+dx,925,"ECCDB5",0 Then
		// open reborn window
		While isInRebornWindow() = false
			MoveTo 306+dx, 954
			LeftClick 1
			Delay 1000
		Wend
		
		// check if it's still able to make appointment for reborn (means limit is not reached, yet)
		FindPic 356+dx,789,460+dx,918,"C:\Users\Lee\Desktop\QMC\canMakeRebornAppointment.bmp",0.9,intX,intY
		If intX > 0 And intY > 0 Then 
			KeyPress "Esc", 1 // close window
			isOverLimitAndReborn = false
		Else
			While isInRebornWindow() = true
				//MoveTo 964+dx, 846 // normal reborn
				MoveTo 1370+dx, 847 // double reborn
				LeftClick 1
				Delay 1000
			Wend

			// Reborn!
			While clickConfirmReborn() = false
				Delay 1000
			Wend
			
			While isReborned() = false
				Delay 1000
			Wend
			isOverLimitAndReborn = true
		End If
	Else 
		isOverLimitAndReborn = false
	End If
End Function