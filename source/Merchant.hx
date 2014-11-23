package ;

import flixel.FlxSprite;

/**
 * ...
 * @author Jason McLaughlin
 */
class Merchant extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.merchant__png, false, 27, 42);
	}
	
}