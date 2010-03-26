
SuperStrict

Import "gui/button.bmx"

Type piNumpad Extends piGadget

	Field buttons:piButton[11]

	Method Init:piNumpad(x:Int, y:Int, w:Int, h:Int)
		
		Local n:Int = 1
		Local bw:Float = w / 3.0	'Button width
		Local bh:Float = h / 4.0	'Button height
		Local bs:Float = 1			'Border size
		
		For Local yy:Int = 2 To 0 Step - 1
			For Local xx:Int = 0 To 2
				Local b:piButton = New piButton
				buttons[n] = b
				b.SetText(n)
				b.SetPosition(x + xx * bw + bs, y + yy * bh + bs)
				b.SetSize(bw - bs * 2, bh - bs * 2)
				b.SetCallback(piNumpad.ButtonCallback, Self)
				n:+1
			Next
		Next

		buttons[0] = New piButton
		buttons[0].SetText(0)
		buttons[0].SetPosition(x + bs, y + 3 * bh + bs)
		buttons[0].SetSize(bw * 2 - bs * 2, bh - bs * 2)
		buttons[0].SetCallback(piNumpad.ButtonCallback, Self)
		
		buttons[10] = New piButton
		buttons[10].SetText(".")
		buttons[10].SetPosition(x + bw * 2 + bs, y + 3 * bh + bs)
		buttons[10].SetSize(bw - bs * 2, bh - bs * 2)
		buttons[10].SetCallback(piNumpad.ButtonCallback, Self)
		
		Return Self
	EndMethod
	
	
	
	Function ButtonCallback(event:piEvent, context:Object)
		If Not piButton(event.origin) Return
		Local b:piButton = piButton(event.origin)
		
		Select event.id
			Case EVENT_GADGETACTION
				Local emit:piEvent = event.Propagate(context)
				Local t:String = b.GetText()
				Local data:Int = -1
				If t = "." Then data = 10 Else data = t.ToInt()
				emit.data = data
				piNumpad(context).CallCallback(emit)
		End Select
		
	EndFunction
	
	Method OnKeyDown(evt:TEvent)
		
		Local d:Int = evt.data
	
		If d = 190 Or d = 110
			PressButton(10, evt)
			Return
		End If
	
		If d - 49 < 10 And d - 49 >= - 1 d:-48
		If d - 97 < 10 And d - 97 >= - 1 d:-96
		If d >= 0 And d < 10
			PressButton(d, evt)
		EndIf
	End Method
	
	Method PressButton(num:Int, evt:TEvent = Null)
		If evt = Null
			evt = TEvent.Create(EVENT_GADGETACTION, Self, num)
		End If
		If num >= 0 And num < 11
			buttons[num].OnMouseDown(evt)
			buttons[num].Flash()
		EndIf
	End Method

End Type

