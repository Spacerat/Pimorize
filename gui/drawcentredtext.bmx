
SuperStrict

Import brl.max2d

Function DrawTextCentred(s:String, x:Float, y:Float, hcentre:Int = True, vcentre:Int = False)
	If (hcentre) x:-(TextWidth(s) / 2)
	If (vcentre) y:-(TextHeight(s) / 2)
	DrawText(s, x, y)
End Function

Function DrawTextCentredShadow(s:String, x:Float, y:Float, offset:Int = 3, hcentre:Int = True, vcentre:Int = False)
	Local r:Int, g:Int, b:Int, a:Float
	GetColor(r, g, b)
	a = GetAlpha()
	If (hcentre) x:-(TextWidth(s) / 2)
	If (vcentre) y:-(TextHeight(s) / 2)
	DrawText(s, x, y)
	SetColor(r + 20, g + 20, b + 20)
	SetAlpha(a / 5.0)
	DrawText(s, x + offset, y + offset)
	SetColor(r, g, b)
	SetAlpha(a)
End Function
