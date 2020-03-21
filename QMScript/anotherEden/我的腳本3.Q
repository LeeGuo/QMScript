[General]
SyntaxVersion=2
BeginHotkey=115
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=77084272-86a4-4ea4-92f6-e653c960136a
Description=½Æ»s®y¼Ð
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
Clipboard = Plugin.Sys.GetCLB()
GetCursorPos x, y

If StrComp(Clipboard,"") <> 0 Then 
	Call Plugin.Sys.SetCLB(Clipboard & "|" & x & "," & y)
Else 
	Call Plugin.Sys.SetCLB(x & "," & y)
End If
