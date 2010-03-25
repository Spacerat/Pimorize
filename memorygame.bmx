
SuperStrict

Import brl.standardio

Type TMemoryGame

	Field _memstring:String
	Field _lastindex:Int
	Field _index:Int = 0
	
	Method Init(str:String, start:Int)
		_memstring = str
		_lastindex = start
	End Method

	Method NextChar(key:Int)
		If _memstring[_index] = key
			If _index + 1 = _lastindex
				_lastindex:+1
				_index = 0
			Else
				NextIndex()
			EndIf
		Else
			_index = 0
		EndIf
	End Method
	
	Method NextIndex()
		_index:+1
	End Method
	
End Type
