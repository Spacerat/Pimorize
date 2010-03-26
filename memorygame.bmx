
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
		Print _memstring[_index] + "(" + Chr(_memstring[_index]) + ") = " + key + "(" + Chr(key) + ")"
		If _memstring[_index] = key
			If _index + 1 = _lastindex
				_lastindex:+1
				_index = 0
				NextLevel()
				
			Else
				NextIndex()
			EndIf
		Else
			_index = 0
			Fail()
		EndIf
		Print "i: " + _index
		Print "l: " + _lastindex
		
	End Method
	
	Method NextLevel()
		
	End Method
	
	Method Fail()
		
	End Method
	
	Method NextIndex()
		_index:+1
	End Method
	
End Type
