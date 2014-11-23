package ;

import flixel.FlxState;

/**
 * ...
 * @author Jason McLaughlin
 */
class GameOverState extends FlxState
{

	override public function create():Void
	{
		#if FLX_NO_MOUSE
		FlxG.mouse.visible = true;
		#end
	}
	
	override public function destroy():Void
	{
		
	}
	
	override public function update():Void
	{
		
	}
	
}