
SuperStrict

Import brl.standardio

Type TMemoryGame
	
	Const piString:String = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609"

	Field _memstring:String
	Field _lastindex:Int
	Field _index:Int = 0
	
	Method Init(str:String, start:Int)
		_memstring = str
		_lastindex = start
	End Method
	
	Method InitPi()
		Init(piString, 2)
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
