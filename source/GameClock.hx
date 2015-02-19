package ;

import flixel.util.FlxTimer;

/**
 * ...
 * @author Jason McLaughlin
 */
class GameClock extends FlxTimer
{
	private var tr:Float;
	public  var paused:Bool;
	
	
	public function new(?Time:Null<Float>, ?Callback:FlxTimer->Void, Loops:Int=1) 
	{
		super(Time, Callback, Loops);
		paused = false;
	}
	
	public function pause()
	{
		tr = timeLeft;
		paused = true;
	}
	
	public function unpause()
	{
		reset(tr);
		paused = false;
	}
	
	
//	override public function complete(timer:FlxTimer):Void
//	{
//		super.complete(timer);
//	}
	
}