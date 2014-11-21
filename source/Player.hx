package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jason McLaughlin
 */
class Player extends FlxSprite
{
	public var speed:Float = 200;
	
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.AQUAMARINE);
		drag.x = drag.y = 1600;
	}
	
	override public function update():Void
	{
		movement();
		super.update();
	}
	
	private function movement():Void
	{
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		if (_up && _down)
		{
			_up = _down = false;
		}
		if (_left && _right)
		{
			_left = _right = false;
		}
		
		if (_up || _down || _left || _right)
		{
			velocity.x = speed;
			velocity.y = speed;
			
			var mA:Float = 0;
			if (_up)
			{
				mA = -90;
				if (_left)
					mA -= 45;
				else if (_right)
					mA += 45;
			}
			else if (_down)
			{
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
			}
			else if (_left)
				mA = 180;
			else if (_right)
				mA = 0;
				
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);
		}
	}
	
}