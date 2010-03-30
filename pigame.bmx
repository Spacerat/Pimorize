
SuperStrict

Import brl.oggloader
Import "memorygame.bmx"
Import "numpad.bmx"
Import "numbersounds.bmx"
Import "gui\drawcentredtext.bmx"
Import brl.freetypefont
Import brl.directsoundaudio
Import brl.pngloader
Import brl.ramstream

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

Incbin "shadow.png"
Incbin "DroidSans-Bold.ttf"

Type piGame Extends TMemoryGame
	Const piString:String = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609"
	Const plankString:String = "6.62606824"
	
	Field numpad:piNumpad
	Field w:Int, h:Int, x:Int = 0
	
	Field _speaker:TDigitSpeaker = New TDigitSpeaker
	Field _channel:TChannel = New TChannel
	
	Field _previewindex:Int = 0
	Field _previewto:Int = 3
	Field _previewtime:Int = 0
	Field _currentlevel:Int = 0
	Field _fails:Int = 0
	
	Field _bigfont:TImageFont
	Field _smallfont:TImageFont
	Field _shadowimg:TImage = LoadImage("incbin::shadow.png")
	
	Method Init(str:String = piString, start:Int = 3)
		
		Super.Init(str, start)
		_previewto = start
		w = GraphicsWidth() * (3.0 / 5)
		h = GraphicsHeight()
		numpad = New piNumpad.Init(x, 0, w, h)
		numpad.SetCallback(PadCallback, Self)
		_speaker.LoadSounds("Sound", "ogg")
		_bigfont = LoadImageFont("incbin::DroidSans-Bold.ttf", h / 6.0)
		_smallfont = LoadImageFont("incbin::DroidSans-Bold.ttf", h / 12.0)
		If (_bigfont) numpad.SetFont(_bigfont)

	End Method
	
	Method Run()
	
		If KeyDown(KEY_RIGHT)
			x:+1
			numpad.SetPosition(numpad.GetX() + 1, numpad.GetY())
		EndIf
		If KeyDown(KEY_LEFT)
			x:-1
			numpad.SetPosition(numpad.GetX() - 1, numpad.GetY())
		EndIf
		
		piGadget.RenderAll()
		
		If _previewto >= 0 And MilliSecs() > _previewtime And _previewindex < _memstring.Length
			_currentlevel = Max(_currentlevel, _previewindex)
			If _memstring[_previewindex] = Asc(".")
				numpad.PressButton(10)
			Else
				numpad.PressButton(Int(Chr(_memstring[_previewindex])))
			EndIf
			
			_previewtime = MilliSecs() + 200 * (1 - Float(_previewto - _previewindex) / _previewto) + 150
			_previewindex:+1
			If _previewindex >= _previewto _previewto = -1
		EndIf

		SetScale(1, h)
		SetAlpha(0.5)
		DrawImage(_shadowimg, w + x, 0)
		SetScale(- 1, h)
		DrawImage(_shadowimg, x, 0)
		SetAlpha(1)
		SetScale(1, 1)
		
		SetImageFont(_smallfont)
		Local centreline:Int = w + (w / 3.0) + x / 2
		Local texth:Int = TextHeight("|") + 2
		Local top:Int = h / 20
		DrawTextCentredShadow("Level: " + _currentlevel, centreline, top)
		DrawTextCentredShadow("Fails: " + _fails, centreline, top + texth)
		
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
		_fails:+1
	End Method
	
	Function PadCallback(evt:piEvent, context:Object)
		Local g:piGame = piGame(context)
		g._speaker.PlayDigit(evt.data, g._channel)
		
		If g._previewto >= 0 Return
		If evt.data = 10
			g.NextChar("."[0])
		Else
			g.NextChar(String(evt.data)[0])
		EndIf
		
	End Function
	
End Type

