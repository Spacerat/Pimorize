
SuperStrict

Import brl.oggloader
Import "memorygame.bmx"
Import "numpad.bmx"
Import "numbersounds.bmx"
Import joe.snarl
Import brl.freetypefont
Import brl.directsoundaudio

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
	Const plankString:String = "6.62606824"
	
	Field numpad:piNumpad
	Field w:Int, h:Int
	Field speaker:TDigitSpeaker = New TDigitSpeaker
	
	Field _previewindex:Int = 0
	Field _previewto:Int = 3
	Field _previewtime:Int = 0
	
	Field _font:TImageFont
	
	Method Init(str:String = piString, start:Int = 3)
		
		Super.Init(str, start)
		_previewto = start
		w = GraphicsWidth()
		h = GraphicsHeight()
		numpad = New piNumpad.Init(0, 0, w, h)
		numpad.SetCallback(PadCallback, Self)
		speaker.LoadSounds("Sound", "ogg")
		_font = LoadImageFont("incbin::DroidSans-Bold.ttf", h / 6)
		If (_font) numpad.SetFont(_font)

	End Method
	
	Method Run()
		piGadget.RenderAll()
		
		If _previewto >= 0 And MilliSecs() > _previewtime And _previewindex < _memstring.Length
			
			If _memstring[_previewindex] = Asc(".")
				numpad.PressButton(10)
			Else
				numpad.PressButton(Int(Chr(_memstring[_previewindex])))
			EndIf
			
			_previewtime = MilliSecs() + 200 * (1 - Float(_previewto - _previewindex) / _previewto) + 150
			_previewindex:+1
			If _previewindex >= _previewto _previewto = -1
		EndIf
		
		SetImageFont(_font)
		
	End Method
	
	Method NextLevel()
	
		_previewto = _lastindex
		_previewindex = 0
		_previewtime = MilliSecs() + 400
		
	End Method
	
	Method Fail()
		_previewto = _lastindex
		_previewindex = 0
		_previewtime = MilliSecs() + 400		
	End Method
	
	Function PadCallback(evt:piEvent, context:Object)
		Local g:piGame = piGame(context)
		g.speaker.PlayDigit(evt.data)
		
		If g._previewto >= 0 Return
		If evt.data = 10
			g.NextChar("."[0])
		Else
			g.NextChar(String(evt.data)[0])
		EndIf
		
	End Function
	
End Type

