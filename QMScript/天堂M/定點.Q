[General]
SyntaxVersion=2
BeginHotkey=120
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=ed4ae62b-5a92-48b4-a9a4-2d2ecb58590f
Description=定點
Enable=1
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

[Attachment]
UEsDBBQAAgAIAJ55I0yny8RdhgAAAAYFAAAJABEAZm9jdXMuYm1wVVQNAAfP8kxaHvJMWh7yTFpz8mVjZQADMyDWAGI+IJYBYkYGCbD4BRYGDKAi85ZIBFb75Q4zQQRTi4b+PWX+epcZh7lo6O8T5hcXiVT75zHz3eOjakfVjqolXu3GBQiZS3uZ8ao9spHp2GYgAsm/vsxMyA07ljGf28V84xAoB3+4yXzjMDHu3bea6fI+plPbifQb7jIKAFBLAQIXCxQAAgAIAJ55I0yny8RdhgAAAAYFAAAJAAkAAAAAAAAAIACAgQAAAABmb2N1cy5ibXBVVAUAB8/yTFpQSwUGAAAAAAEAAQBAAAAAvgAAAAAA


[Script]
Rem startChecking

MoveTo 258, 656
LeftClick 1
KeyPress "X", 1
Delay 100

FindPic 62,334,98,380,"C:\Users\Lee\Desktop\按鍵精靈\focus.bmp",0.9,intX,intY
If intX > 0 And intY > 0 Then 
Else 
	Delay 100
	Goto startChecking
End If

Rem stillFighting
FindPic 62,334,98,380,"C:\Users\Lee\Desktop\按鍵精靈\focus.bmp",0.9,intX,intY
If intX > 0 And intY > 0 Then 
	Delay 100
	Goto stillFighting
Else 
	Goto startChecking
End If