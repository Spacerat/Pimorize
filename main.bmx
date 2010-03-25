
SuperStrict

Import "pigame.bmx"

Graphics 300, 400

Local game:piGame = New piGame.InitGame()
SetClsColor(255,255,255)
While Not AppTerminate()
	Cls

	game.Run()
	
	Flip
WEnd
