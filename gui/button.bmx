
SuperStrict

Import "rectgadget.bmx"
Import "drawcentredtext.bmx"
Import joe.colour

Type piButton Extends piRectGadget
	
	Field _text:String = "button"
	Field _textcol:TColour = TColour.Black()
	Field _backcol:TColour = TColour.Grey()
	Field _flashcol:TColour = TColour.Red()
	
	Field flashtime:Int = 0
	
	
	Method Render()
		_backcol.Set()
		
		If GetMouseIn()
			_backcol.Lighter().Set()
		EndIf
		If GetMouseDown()
			_backcol.Lighter(40).Set()
		End If
		If MilliSecs() < flashtime _flashcol.Set()
			
		DrawRect(_x, _y, _w, _h)
		
		_textcol.Set()
		
		DrawTextCentred(_text, _x + _w / 2 + GetMouseDown(), + _y + _h / 2 + GetMouseDown(), True, True)
		
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



