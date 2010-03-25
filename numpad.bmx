
Import "gui/button.bmx"

Type piNumpad Extends piCallbackHandler

	Field buttons:piButton[11]

	Method Init(x:Int, y:Int, w:Int, h:Int)
		
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
				b.SetCallback(piNumpad.ButtonCallback)
				n:+1
			Next
		Next

		buttons[0] = New piButton
		buttons[0].SetText(0)
		buttons[0].SetPosition(x + bs, y + 3 * bh + bs)
		buttons[0].SetSize(bw * 2 - bs * 2, bh - bs * 2)
		
	EndMethod
	
	Function ButtonCallback(event:TEvent, context:piCallbackHandler)
		If Not piButton(context) Return
		
		
		
		
	EndFunction

End Type

