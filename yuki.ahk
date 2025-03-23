init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127


Loop, 6
{
    Random, letraNum, 1, 62
    If letraNum < 11
    {
        letra := letraNum-1
    }
    Else If letraNum < 37
    {
        letra := Chr(letraNum + 54)
    }
    Else
    {
        letra := Chr(letraNum + 60)
    }
    nuevoNombre := nuevoNombre letra
}

nuevoNombre := nuevoNombre ".ahk"

FileMove, %A_ScriptFullPath%, %A_WorkingDir%\%nuevoNombre%



if (FileExist("config.ini")) 
{
}
Else
{
IniWrite, 0xA145A3, config.ini, main, EMCol
IniWrite, 20, config.ini, main, ColVn
}

IniRead, EMCol, config.ini, main, EMCol
IniRead, ColVn, config.ini, main, ColVn


toggle = 1
toggle2 = 1


AntiShakeX := (A_ScreenHeight // 160)
AntiShakeY := (A_ScreenHeight // 128)
ZeroX := (A_ScreenWidth // 2) ;dont touch?
ZeroY := (A_ScreenHeight // 2) 
CFovX := (A_ScreenWidth // 35)  ;configure for FOV up = smaller lower= bigger current boxes right fov
CFovY := (A_ScreenHeight // 35)
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY



Gui Add, Text, cGreen, UNDETECTED PRIVATE YUKI TRIGGERBOT (35 FOV)
Gui Add, Text, cBlue, Press F2 to activate. Hold "F" to make it work.
Gui Add, Text, cPurple, The default color is PURPLE.
Gui Add, Text, cPurple, Any questions Discord: yukkixyz
Gui Add, Text, cRed, yukixyz.
Gui show

Gui 2: Color, EEAA99
Gui 2: Font, S72, Arial Black

Gui 2: Add, GroupBox, w100 h250 cFFB10F BackgroundTrans,
Gui 2: +LastFound +AlwaysOnTop +ToolWindow
WinSet, TransColor, EEAA99
Gui 2: -Caption

state := false

F5::
    voice := ComObjCreate("SAPI.SpVoice")
    if (state = false) {
        voice.Speak("ON")
        state := true
    } else {
        voice.Speak("OFF")
        state := false
    }
return


~F2::
SoundBeep, 750
SoundBeep, 750
SoundBeep, 750

SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SendMode, InputThenPlay
SetBatchLines,-1
SetWinDelay,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

Loop{

PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB	

		if GetKeyState("F"){
		if (ErrorLevel=0) {
		PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
		loop , 1{
		send {Lbutton down}
		sleep, 1
		send {lbutton up}
						}
					}
				}
						
		if GetKeyState("Xbutton1") {
		if (!ErrorLevel=0) {
		loop, 10 {
			PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
			AimX := AimPixelX - ZeroX
			AimY := AimPixelY - ZeroY
			DirX := -1
			DirY := -1
			If ( AimX > 0 ) {
				DirX := 1
			}
			If ( AimY > 0 ) {
				DirY := 1
			}
			AimOffsetX := AimX * DirX
			AimOffsetY := AimY * DirY
			MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
			MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
			DllCall("mouse_event", uint, 1, int, MoveX * 2, int, MoveY, uint, 0, int, 0) ;turing mouse to color were it says * is the speed of the aimbot turn up for unhuman reactions lower for human
				}
			}
		}
	}


return:
goto, init

Home::
if toggle2 = 0
{
	toggle2 = 1
	Gui Hide
}
Else
{
	toggle2 = 0
	Gui Show
}


action1:
if toggle = 0
{
	toggle = 1
	Gui 2: Hide
}
Else
{
	toggle = 0
	Gui 2: Show
}
return

end::
exitapp
return


Quitter:
ExitApp

GuiClose:
ExitApp