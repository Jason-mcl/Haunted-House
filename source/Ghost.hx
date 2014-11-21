package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.util.FlxVelocity;

/**
 * ...
 * @author Jason McLaughlin
 */
class Ghost extends FlxSprite
{
	public var speed:Float = 140;
	public var etype(default, null):Int;
	private var _brain:FSM;
	private var _idleTmr:Float;
	private var _moveDir:Float;
	public var seesPlayer:Bool = false;
	public var playerPos(default, null):FlxPoint;
	
	public function new(X:Float=0, Y:Float=0, EType:Int) 
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.RED);
		etype = EType;
		drag.x = drag.y = 10;
		setSize(22, 22);
		offset.set(5, 5);
		_brain = new FSM(idle);
		_idleTmr = 0;
		playerPos = FlxPoint.get();
	}
	
	
	override public function update():Void 
	{
		_brain.update();
		super.update();
	}
	
	public function idle():Void
	{
		if (seesPlayer)
		{
			_brain.activeState = chase;
		}
		else if (_idleTmr <= 0)
		{
			if (FlxRandom.chanceRoll(1))
			{
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				_moveDir = FlxRandom.intRanged(0, 8) * 45;
				FlxAngle.rotatePoint(speed * .5, 0, 0, 0, _moveDir, velocity);
				
			}
			_idleTmr = FlxRandom.intRanged(1, 4);			
		}
		else
			_idleTmr -= FlxG.elapsed;
		
	}
	
	public function chase():Void
	{
		if (!seesPlayer)
		{
			_brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}
}