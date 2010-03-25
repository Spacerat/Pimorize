
SuperStrict

Import "rectgadget.bmx"
Import "drawcentredtext.bmx"
Import joe.colour

Type piButton Extends piRectGadget
	
	Field _text:String = "button"
	Field _textcol:TColour = TColour.Black()
	Field _backcol:TColour = TColour.Grey()
	
	
	Method Render()
		_backcol.Set()
		
		If GetMouseIn()
			_backcol.Lighter().Set()
		EndIf
		If GetMouseDown()
			_backcol.Lighter(40).Set()
		End If
		DrawRect(_x, _y, _w, _h)
		
		_textcol.Set()
		
		DrawTextCentred(_text, _x + _w / 2 + GetMouseDown(), + _y + _h / 2 + GetMouseDown(), True, True)
		
	End Method
	
	Method OnMouseDown(evt:TEvent)
		TriggerEvent(EVENT_GADGETACTION, evt)
	End Method
	
	Method SetText(text:String)
		_text = Text
	End Method
	
End Type



