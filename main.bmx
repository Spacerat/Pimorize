
SuperStrict

Framework brl.blitz
Import "pigame.bmx"
?Win32
Import brl.d3d7max2d
?Not Win32
Import brl.glmax2d
?

Graphics 300, 400

Local game:piGame = New piGame.InitGame()
SetClsColor(0, 0, 0)
While Not AppTerminate()
	Cls

	game.Run()
	
	Flip
WEnd
