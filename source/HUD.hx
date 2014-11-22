package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{

	private var _gameClock:FlxTimer;
	private var _clockText:FlxText;
	private var _insanityBar:FlxBar;
	private var _currentInsanity:Int;

    public function new() 
    {
        super();
    }

    public function updateHUD(TimeLeft:Float, Insanity:Int = 0):Void
    {
		_currentInsanity -= Insanity;
    }
	
}