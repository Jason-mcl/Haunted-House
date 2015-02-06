package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import haxe.zip.InflateImpl;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Jason McLaughlin
 */
class Player extends FlxSprite
{
	public var REG_SOUND:Int = 125;
	public var SNEAK_SOUND:Int = 80;
	public var SPRINT_SOUND:Int = 225;
	public var NO_SOUND:Int = 50;
	public var MAX_INSANITY:Int = 300;
	
	static var REG_SPEED = 200;
	static var SNEAK_SPEED = 150;
	static var SPRINT_SPEED = 300;
	
	public var speed:Float = REG_SPEED;
	
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _shift:Bool = false;
	var _space:Bool = false;
	
	public var insanity:Int;
	public var soundRadius:Int;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.playerSprite__png, true, 32, 32);
		//loadGraphic(AssetPaths.sprite__png, true, 33, 46);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		//animation.add("lr", [4,5,6,7]);
		//animation.add("u", [12,13,14,15]);
		//animation.add("d", [0,1,2,3]);
		
		drag.x = drag.y = 1600;
		setSize(22, 22);
		offset.set(5, 5);
		
		insanity = MAX_INSANITY;
		soundRadius = REG_SOUND;
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
		_shift = FlxG.keys.anyPressed(["SHIFT"]);
		_space = FlxG.keys.anyPressed(["SPACE"]);
		
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
			if (_shift)
			{
				speed = SPRINT_SPEED;
				soundRadius = SPRINT_SOUND;
			}
			else if (_space)
			{
				speed = SNEAK_SPEED;
				soundRadius = SNEAK_SOUND;
			}
			else
			{
				speed = REG_SPEED;
				soundRadius = REG_SOUND;
			}
			
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
					
				facing = FlxObject.UP;
			}
			else if (_down)
			{
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
					
				facing = FlxObject.DOWN;
			}
			else if (_left)
			{
				mA = 180;
				facing = FlxObject.LEFT;
			}
			else if (_right)
			{
				mA = 0;
				facing = FlxObject.RIGHT;
			}
				
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);
			
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				switch(facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");
					case FlxObject.UP:
						animation.play("u");
					case FlxObject.DOWN:
						animation.play("d");
				}
			}
		}
		else
		{
			soundRadius = NO_SOUND;
		}
	}
}