
SuperStrict

Import brl.oggloader
Import "memorygame.bmx"
Import "numpad.bmx"
Import "numbersounds.bmx"
Import "gui\slider.bmx"
Import brl.freetypefont
Import brl.directsoundaudio
Import brl.pngloader
Import brl.ramstream
Import joe.advtext

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

Incbin "Img/shadow.png"
Incbin "Img/speaker-0.png"
Incbin "Img/speaker-1.png"
Incbin "Img/speaker-2.png"
Incbin "Img/speaker-3.png"
Incbin "Img/speed-1.png"
Incbin "Img/speed-2.png"
Incbin "Img/speed-3.png"
Incbin "Img/speed-4.png"
Incbin "DroidSans-Bold.ttf"

Type piGame Extends TMemoryGame
	Const piString:String = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609"
	Const plankString:String = "6.62606824"

	Field w:Int, h:Int, x:Int = 0
	
	Field numpad:piNumpad
	Field _volumeslider:piSlider
	Field _speedslider:piSlider
	
	Field _speaker:TDigitSpeaker = New TDigitSpeaker
	Field _channel:TChannel = AllocChannel()
	Field _volume:Float = 1
	
	Field _previewindex:Int = 0
	Field _previewto:Int = 3
	Field _previewtime:Int = 0
	Field _currentlevel:Int = 0
	Field _fails:Int = 0
	Field _speedmulti:Float = 1
	
	Field _bigfont:TImageFont
	Field _smallfont:TImageFont
	Field _tinyfont:TImageFont
	Field _shadowimg:TImage = LoadImage("incbin::Img/shadow.png")
	Field _speakerimg:TImage[4]
	Field _speedimg:TImage[4]
	
	Method Init(str:String = piString, start:Int = 3)
		
		Super.Init(str, start)
		_previewto = start
		w = GraphicsWidth() * (3.0 / 5)
		h = GraphicsHeight()
		
		numpad = New piNumpad.Init(x, 0, w, h)
		numpad.SetCallback(PadCallback, Self)
		
		_volumeslider = New piSlider.CreateSlider(w + w * (1 / 5.0), h / 2.4, 20, h / 2.5, piSlider.VERTICAL)
		_volumeslider.SetCallback(SliderCallback, Self)
		SetVolume(_volume)
		_speedslider = New piSlider.CreateSlider(w + w * (2 / 5.0), h / 2.4, 20, h / 2.5, piSlider.VERTICAL)
		_speedslider.SetCallback(SliderCallback, Self)
		SetSpeedMulti(_speedmulti)
		_speaker.LoadSounds("Sound", "ogg")
		_bigfont = LoadImageFont("incbin::DroidSans-Bold.ttf", h / 6.0)
		_smallfont = LoadImageFont("incbin::DroidSans-Bold.ttf", h / 12.0)
		_tinyfont = LoadImageFont("incbin::DroidSans-Bold.ttf", 10)
		For Local i:Int = 0 To 3
			_speakerimg[i] = LoadImage("incbin::Img/speaker-" + i + ".png")
			_speakerimg[i].handle_x = _speakerimg[i].width / 2
			_speakerimg[i].handle_y = _speakerimg[i].height
			_speedimg[i] = LoadImage("incbin::Img/speed-" + (i + 1) + ".png")
			_speedimg[i].handle_x = _speedimg[i].width / 2
			_speedimg[i].handle_y = _speedimg[i].height
		Next
		
		If (_bigfont) numpad.SetFont(_bigfont)

	End Method
	
	Method Run()
		'''UPDATE'''
		If KeyDown(KEY_RIGHT)
			SetX(x + 1)
		EndIf
		If KeyDown(KEY_LEFT)
			SetX(x - 1)
		EndIf
		
		piGadget.UpdateAll()
		
		
		If _previewto >= 0 And MilliSecs() > _previewtime And _previewindex < _memstring.Length
			_currentlevel = Max(_currentlevel, _previewindex)
			If _memstring[_previewindex] = Asc(".")
				numpad.PressButton(10)
			Else
				numpad.PressButton(Int(Chr(_memstring[_previewindex])))
			EndIf
			
			_previewtime = MilliSecs() + 200 * (1 - Float(_previewto - _previewindex) / _previewto) + (150 * _speedmulti)
			_previewindex:+1
			If _previewindex >= _previewto _previewto = -1
		EndIf

		'''RENDER'''
		piGadget.RenderAll()
		'Shadows
		SetScale(1, h)
		SetAlpha(0.5)
		DrawImage(_shadowimg, w + x, 0)
		SetScale(- 1, h)
		DrawImage(_shadowimg, x, 0)
		SetAlpha(1)
		SetScale(1, 1)
		
		'Info text
		SetImageFont(_smallfont)
		Local centreline:Int = w + (w / 3.0) + x / 2
		Local texth:Int = TextHeight("|") + 2
		Local top:Int = h / 20
		SetColor(0, 0, 0)
		DrawTextCentredShadow("Level: " + _currentlevel, centreline, top)
		DrawTextCentredShadow("Fails: " + _fails, centreline, top + texth)
		
		'Slider Images
		SetColor(255, 255, 255)
		SetAlpha(1)
		SetScale(GraphicsWidth() / 700.0, GraphicsHeight() / 600.0)
		Local n:Int = Ceil(_volume * 3)
		DrawImage(_speakerimg[n], _volumeslider.GetX() + _volumeslider.GetWidth() / 2, _volumeslider.GetY() - _volumeslider.GetWidth() / 2)
		Local s:Int = 3 - _speedmulti
		If KeyHit(KEY_SPACE) DebugStop
		DrawImage(_speedimg[s], _speedslider.GetX() + _volumeslider.GetWidth() / 2, _volumeslider.GetY() - _volumeslider.GetWidth() / 2)
		SetScale(1, 1)
		
		'About text
		SetImageFont(_tinyfont)
		SetColor(200, 200, 200)
		If (GraphicsWidth() - (w + x)) > 94
			joe.advtext.DrawParsedText("<gray>PiMorize<colour=default> by Joseph <gray>'Spacerat'<colour=default> Atkins-Turkish", w + x + 20, h - 40, GraphicsWidth() - w - x - 40)
		EndIf
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
	
	Method PadEvent(evt:piEvent)
		_speaker.PlayDigit(evt.data, _channel)
		
		If _previewto >= 0 Return
		If evt.data = 10
			NextChar("."[0])
		Else
			NextChar(String(evt.data)[0])
		EndIf		
	End Method
	
	Method SetVolume(vol:Float)
		vol = Max(Min(vol, 1), 0)
		SetChannelVolume(_channel, vol)
		_volumeslider.SetSliderPercentage(1 - vol)
		_volume = vol
	End Method
	
	Method SetSpeedMulti(multi:Float)
		_speedmulti = Min(Max(multi, 0), 3)
		_speedslider.SetSliderPercentage((multi) / 3)
	End Method
	
	Method SetX(nx:Int)
		numpad.SetPosition(numpad.GetX() + nx - x, numpad.GetY())
		_volumeslider.SetPosition(w + w * (1 / 5.0) + (nx / 2.0), h / 2.4)
		_speedslider.SetPosition(w + w * (2 / 5.0) + (nx / 2.0), h / 2.4)
		Self.x = nx
	End Method
	
	Function PadCallback(evt:piEvent, context:Object)
		Local g:piGame = piGame(context)
		g.PadEvent(evt)
	End Function
	
	Function SliderCallback(evt:piEvent, context:Object)
		Local g:piGame = piGame(context)
		If evt.id = EVENT_GADGETACTION
			If evt.origin = g._volumeslider
				g.SetVolume(evt.data)
			ElseIf evt.origin = g._speedslider
				g.SetSpeedMulti(((1 - evt.data) * 3))
			EndIf
		EndIf
	End Function
	
End Type

