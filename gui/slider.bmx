
SuperStrict

Import "rectgadget.bmx"
Import joe.colour

Type piSlider Extends piRectGadget
	
	Const HORIZONTAL:Int = 0
	Const VERTICAL:Int = 1
	
	Field _sliderpos:Float = 0
	Field _orient:Int
	Field _backcol:TColour = TColour.Black()
	Field _knobcol:TColour = TColour.Gray(0.8)
	
	Method CreateSlider:piSlider(x:Int, y:Int, w:Int, h:Int, orient:Int)
		SetPosition(x, y)
		SetSize(w, h)
		SetOrient(orient)
		Return Self
	End Method
	
	Method Render()
		
		SetLineWidth(4)
		
		SetAlpha(1)
		_backcol.Set()
	
		Local knobx:Int, knoby:Int, knobd:Int
		
		If _orient = VERTICAL
			DrawLine(_x + _w / 2, _y, _x + _w / 2, _y + _h)
			knobx = _x + _w / 2
			knoby = _y + _h * _sliderpos
			knobd = _w
		Else
			DrawLine(_x, _y + _h / 2, _x + _w, _y + _h / 2)
			knobx = _x + + _w * _sliderpos
			knoby = _y + _h / 2
			knobd = _h
		End If
		
		_knobcol.Set()
		
		DrawOval(knobx - knobd * 0.5, knoby - knobd * 0.5, knobd, knobd)
		
	End Method

	Method Update()
		If GetMouseDown()
			Local pv:Float = _sliderpos
			If _orient = HORIZONTAL
				SetSliderPercentage(Float(MouseX() - _x) / _w)
			Else
				SetSliderPercentage(Float(MouseY() - _y) / _h)
			EndIf
			If pv <> _sliderpos
				CallCallback(New piEvent.Create(EVENT_GADGETACTION, Self, GetSliderPercentage(),, MouseX(), MouseY()))
			End If
		End If		
	EndMethod
	
	Method SetOrient(is_vertical:Int)
		If is_vertical = True _orient = True Else _orient = False
	End Method
	
	Method GetOrient:Int()
		Return _orient
	End Method
	
	Method GetSliderPercentage:Float()
		If _orient = HORIZONTAL
			Return _sliderpos
		Else
			Return 1 - _sliderpos
		End If
	End Method
	
	Method SetSliderPercentage(v:Float)
		_sliderpos = Max(Min(v, 1), 0)
	End Method
	
EndType
