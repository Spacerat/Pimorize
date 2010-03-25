
SuperStrict

Import "gui.bmx"

Type piRectGadget Extends piGadget
	
	Field _x:Int, _y:Int, _w:Int = 50, _h:Int = 50
	
	Method TestPosition:Int(x:Int, y:Int)
		If x < _x Return 0
		If y < _y Return 0
		If x > _x + _w Return 0
		If y > _y + _h Return 0
		Return 1
	End Method
	
	Method SetPosition(x:Int, y:Int)
		_x = x
		_y = y
	End Method
	
	Method SetSize(w:Int, h:Int)
		_w = Max(0, w)
		_h = Max(0, h)
	End Method

	Method GetX:Int()
		Return _x
	End Method
	
	Method GetY:Int()
		Return _y
	End Method
	
	Method GetWidth:Int()
		Return _w
	End Method
	
	Method GetHeight:Int()
		Return _h
	End Method
	
End Type



