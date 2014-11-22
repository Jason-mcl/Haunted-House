package ;

import flixel.util.FlxTimer;

/**
 * ...
 * @author Jason McLaughlin
 */
class GameClock extends FlxTimer
{

	public function new(?Time:Null<Float>, ?Callback:FlxTimer->Void, Loops:Int=1) 
	{
		super(?Time, ?Callback, Loops);
		
	}
	
	override public function complete(:FlxTimer):Void
	{
		super.complete();
	}
	
}