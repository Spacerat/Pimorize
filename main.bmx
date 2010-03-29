
SuperStrict

Framework brl.blitz
Import "pigame.bmx"
Import "ini.bmx"
?Win32
Import brl.d3d7max2d
?Not Win32
Import brl.glmax2d
?
Incbin "DroidSans-Bold.ttf"
AppTitle = "PiMorize"



Local ini:TPertIni = TPertIni.Create("settings.ini")
ini.Load()
Local str:String = IniLoadDef(ini, "Game", "String", "pi")
Local start:Int = Int(IniLoadDef(ini, "Game", "Start", "3"))
Local swidth:Int = Int(IniLoadDef(ini, "Window", "Width", "300"))
Local sheight:Int = Int(IniLoadDef(ini, "Window", "Height", "400"))
Local fullscr:Int = Int(IniLoadDef(ini, "Window", "Fullscreen", "0"))
ini.Save(True)
Graphics swidth, sheight, fullscr * 32
Local game:piGame = New piGame



If str.ToLower() = "pi"
	game.Init(piGame.piString, start)
Else
	game.Init(str, start)
EndIf

SetClsColor(0, 0, 0)
While Not (AppTerminate() Or KeyDown(KEY_ESCAPE))
	Cls

	game.Run()
	
	Flip
WEnd
