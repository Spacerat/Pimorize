
SuperStrict

Rem
bbdoc: Base memory game class
about: This class contains the logic for memory games. It is then left to a sub-class to impliment an interface.
EndRem
Type TMemoryGame

	Field _memstring:String
	Field _lastindex:Int
	Field _index:Int = 0
	
	Rem
	bbdoc: Initialise the game with a string, at a position.
	EndRem
	Method Init(str:String, start:Int)
		_memstring = str
		_lastindex = start
	End Method

	Method NextChar(key:Int)
	
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
		
	End Method
	
	Method NextLevel()
		
	End Method
	
	Method Fail()
		
	End Method
	
	Method NextIndex()
		_index:+1
	End Method
	
End Type
