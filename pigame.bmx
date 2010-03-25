
SuperStrict

Import brl.oggloader
'Import brl.openalaudio
'Import brl.freeaudioaudio
Import "memorygame.bmx"
Import "numpad.bmx"
Import "numbersounds.bmx"

Rem
Incbin "Sound/1.ogg"
Incbin "Sound/2.ogg"
Incbin "Sound/3.ogg"
Incbin "Sound/4.ogg"
Incbin "Sound/5.ogg"
Incbin "Sound/6.ogg"
Incbin "Sound/7.ogg"
Incbin "Sound/8.ogg"
Incbin "Sound/9.ogg"
Incbin "Sound/point.ogg"
EndRem

Type piGame Extends TMemoryGame
	Const piString:String = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609"
	
	Field numpad:piNumpad
	Field w:Int, h:Int
	Field speaker:TDigitSpeaker = New TDigitSpeaker
	
	Method InitGame:piGame()
		
		Init(piString, 2)
		w = GraphicsWidth()
		h = GraphicsHeight()
		numpad = New piNumpad.Init(0, 0, w, h)
		numpad.SetCallback(PadCallback, Self)
		speaker.LoadSounds("Sound", "ogg")
		Return Self
	End Method
	
	Method Run()
		piGadget.RenderAll()
		
	End Method
	
	Function PadCallback(evt:piEvent, context:Object)
		Local g:piGame = piGame(context)
		g.speaker.PlayDigit(evt.data)
	End Function
	
End Type

