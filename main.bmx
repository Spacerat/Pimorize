
SuperStrict

Framework brl.blitz
Import "pigame.bmx"
Import "ini.bmx"
?Win32
Import brl.d3d7max2d
?Not Win32
Import brl.glmax2d
?

AppTitle = "PiMorize"



Local ini:TPertIni = TPertIni.Create("settings.ini")
ini.Load()
Local str:String = IniLoadDef(ini, "Game", "String", "pi")
Local start:Int = Int(IniLoadDef(ini, "Game", "Start", "3"))
Local swidth:Int = Int(IniLoadDef(ini, "Window", "Width", "500"))
Local sheight:Int = Int(IniLoadDef(ini, "Window", "Height", "400"))
Local fullscr:Int = Int(IniLoadDef(ini, "Window", "Fullscreen", "0"))
Local x:Int = Int(IniLoadDef(ini, "Window", "X", "15"))

ini.Save(True)
Graphics swidth, sheight, fullscr * 32
Local game:piGame = New piGame
game.x = x


If str.ToLower() = "pi"
	game.Init(piGame.piString, start)
ElseIf str.ToLower() = "h"
	game.Init(piGame.plankString, start)
Else
	game.Init(str, start)
EndIf

SetClsColor(255, 255, 255)
While Not (AppTerminate() Or KeyDown(KEY_ESCAPE))
	Cls

	game.Run()
	
	Flip
WEnd
