
SuperStrict

Import "memorygame.bmx"
Import "numpad.bmx"

Graphics 300, 400

Local g:TMemoryGame = New TMemoryGame
g.InitPi()

New piNumpad.Init(0, 0, 300, 400)

While Not AppTerminate()
	
	Cls

	piGadget.RenderAll()


	Flip
WEnd
