
SuperStrict

Import brl.oggloader
Import brl.ramstream

Rem
bbdoc: Digit audio class
about: Simple class for loading and playing spoken digits
EndRem
Type TDigitSpeaker
	Field numbers:TSound[10]
	Field point:TSound
	
	Rem
	bbdoc: Load all of the digit sounds from a given folder.
	EndRem
	Method LoadSounds(FolderURL:String, extension:String = "ogg")
		
		For Local n:Int = 0 To 9
			Local s:TSound = LoadSound(FolderURL + "/" + n + "." + extension)
			If (s) numbers[n] = s
		Next
		point = LoadSound(FolderURL + "/point." + extension)
	
	End Method
	
	Rem
	bbdoc: Play a digit.
	EndRem
	Method PlayDigit(digit:Int, channel:TChannel = Null)
		If digit < 0 Return
		If digit >= 10
			If (point) PlaySound(point)
		ElseIf (numbers[digit])
			PlaySound(numbers[digit], channel)
		End If
	End Method
	
End Type
