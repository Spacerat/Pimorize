
SuperStrict

Import "rectgadget.bmx"
Import "drawcentredtext.bmx"
Import joe.colour

Type piButton Extends piRectGadget
	
	Field _text:String = "button"
	Field _textcol:TColour = TColour.Black(0.7)
	Field _backcol:TColour = TColour.Grey()
	Field _flashcol:TColour = TColour.Red()
	Field _font:TImageFont
	
	Field flashtime:Int = 0
	
	Function RenderBlock(x:Float, y:Float, w:Float, h:Float, glassoffset:Int = 0)
		Local hx:Float, hy:Float
		Local a:Float = GetAlpha()
		Local glass:Int = True
		GetOrigin(hx, hy)
		If (glass)
			SetViewport(x + hx + 1, y + hy + 1, w - 2, h - 2)
		EndIf
		DrawRect(x + 1, y + 1, w - 2, h - 2)
		If (glass)
			TColour.White(0.4).Set()
			DrawOval(x - (w / 3.0), y - (h / 2.0) + glassoffset, w * (5.0 / 3.0), h)
		EndIf
		SetAlpha(a)
	End Function
		
	Method Render()
		_backcol.Set()
		
		If GetMouseIn()
			_backcol.Lighter().Set()
		EndIf
		If GetMouseDown()
			_backcol.Lighter(40).Set()
		End If
		If MilliSecs() < flashtime _flashcol.Set()
	
		SetBlend(ALPHABLEND)
		
	'	DrawRect(_x, _y, _w, _h)
		SetAlpha(1)
		RenderBlock(_x, _y, _w, _h, GetMouseDown())
		
		SetViewport(0, 0, GraphicsWidth(), GraphicsHeight())
		
		_textcol.Set()
		
		If (_font) Setfont(_font)
		
		DrawTextCentred(_text, _x + _w / 2 + GetMouseDown(), + _y + _h / 2 + GetMouseDown(), True, True)
		
	End Method
	
	Method SetFont(font:TImageFont)
		_font = font
	End Method
	
	Method Flash()
		flashtime = MilliSecs() + 300
	End Method
	
	Method OnMouseDown(evt:TEvent)
		TriggerTEvent(EVENT_GADGETACTION, evt)
	End Method
	
	Method SetText(text:String)
		_text = Text
	End Method
	
	Method GetText:String()
		Return _text
	End Method
	
End Type





