
SuperStrict

Import brl.standardio
Import brl.event

piGadget.EnableGadgets()

Rem
bbdoc: piEvent, heirarchal event class.
about: Similar to TEvent, but can be propagated with a new source, keeping a record of the original source.
EndRem
Type piEvent
	
	Rem
	bbdoc: The original source of the event.
	EndRem
	Field origin:Object
	
	Rem
	bbdoc: The source of this version of the event.
	EndRem
	Field source:Object
	
	Rem
	bbdoc: The event which this event was copied from.
	EndRem
	Field parent:piEvent
	
	Rem
	bbdoc: An integer identifier of the type of event.
	EndRem
	Field id:Int
	
	Rem
	bbdoc: Positional event data.
	EndRem
	Field x:Int, y:Int
	
	Rem
	bbdoc: Arbitrary event data.
	EndRem
	Field data:Object
	
	Rem
	bbdoc: Create a new piEvent and set all of its data.
	EndRem
	Function Create:piEvent(id:Int, source:Object, data:Object, x:Int = 0, y:Int = 0)
		Local n:piEvent = New piEvent
		n.id = id
		n.source = source
		n.origin = source
		n.data = data
		n.x = x
		n.y = y
	EndFunction

	Rem
	bbdoc: Create a copy of this piEvent with a new source.
	EndRem
	Method Propagate:piEvent(source:Object)
		Local n:piEvent = Self.Duplicate()
		n.parent = Self
		n.source = source
	End Method
	
	Rem
	bbdoc: Create an exact duplicate of this piEvent.
	EndRem
	Method Duplicate:piEvent()
		Local n:piEvent = New piEvent
		n.id = id
		n.source = source
		n.origin = origin
		n.parent = parent
		n.x = x
		n.y = y
	End Method
	
End Type

Rem
bbdoc: Base class for objects designed to send piEvent callbacks.
EndRem
Type piCallbackHandler

	Field _EventCallback:Int(event:TEvent, context:piCallbackHandler)

	Rem
	bbdoc: Set the function which will be called when this object emits events.
	EndRem
	Method SetCallback(callback:Int(event:TEvent, context:piCallbackHandler))
		_EventCallback = callback
	End Method

EndType

Rem
bbdoc: Base gadget class.
EndRem
Type piGadget Extends piCallbackHandler
	
	Global _gadgets:TList = New TList
	Field _MouseIn:Int = 0
	Field _MouseDown:Int = 0
	
	Rem
	bbdoc: Enable input to all gadgets.
	EndRem
	Function EnableGadgetInput()
		AddHook(EmitEventHook, piGadget.GadgetHook)
	End Function
	
	Rem
	bbdoc: Disable input to all gadgets.
	EndRem
	Function DisableGadgetInput()
		RemoveHook(EmitEventHook, piGadget.GadgetHook)
	End Function
	
	Method New()
		_gadgets.AddLast(Self)
	End Method
	
	Rem
	bbdoc: Remove this gadget.
	Endrem
	Method Remove()
		_gadgets.Remove(Self)
	End Method	
	
	Rem
	bbdoc: Render all created gadgets.
	EndRem
	Function RenderAll()
		For Local g:piGadget = EachIn _gadgets
			g.Render()
		Next
	End Function
	
	Function GadgetHook:Object(id:Int, data:Object, context:Object)
		
		Local evt:TEvent = TEvent(data)
		For Local b:piGadget = EachIn _gadgets
			Local m:Int = b.TestPosition(evt.x, evt.y)
			
			Select evt.id
			
				Case EVENT_MOUSEMOVE
					If ((m) And Not b.GetMouseIn())
						b._MouseIn = True
						b.TriggerEvent(EVENT_MOUSEENTER, evt)
					EndIf
					If ((Not m) And b.GetMouseIn())
						b._MouseIn = False
						b.TriggerEvent(EVENT_MOUSELEAVE, evt)
					EndIf
					If (m)
						b.OnMouseMove(evt)
					EndIf
				Case EVENT_MOUSEDOWN
					If (m)
						b.TriggerEvent(EVENT_MOUSEDOWN, evt)
						b._MouseDown = 1
						b.OnMouseDown(evt)
					End If
					
				Case EVENT_MOUSEUP
					If (m)
						b.TriggerEvent(EVENT_MOUSEUP, evt)
						b.OnMouseUp(evt)
					End If
					b._MouseDown = 0

			End Select

		Next
		
		Return data
		
	EndFunction
	
	Method TriggerEvent(id:Int, evt:TEvent)
		Local emit:TEvent = TEvent.Create(id, Self, evt.data, evt.mods, evt.x, evt.y, evt.extra)
	'	EmitEvent(emit)
		If (_EventCallback) _EventCallback(emit, Self)
	
	End Method
	
	
	Rem
	bbdoc: Check if the mouse is inside this gadget.
	EndRem
	Method GetMouseIn:Int()
		Return _MouseIn
	End Method
	
	Rem
	bbdoc: Check if the mouse is being held on this gadget.
	Endrem
	Method GetMouseDown:Int()
		Return _MouseDown
	EndMethod
	
'#Region Abstract
	Method TestPosition:Int(x:Int, y:Int) Abstract
	
	Method Render() Abstract
	
	Method OnMouseDown(evt:TEvent)
		
	End Method
	
	Method OnMouseUp(evt:TEvent)
		
	End Method
	
	Method OnMouseMove(evt:TEvent)
		
	End Method
'#End Region 
	
End Type
