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
	private var _insanityTmr:Float;
	private var _insanityTimeTick:Bool = false;

    public function new(InitTime:Float, InitInsanity:Int) 
    {
        super();
		
		_clockText = new FlxText(FlxG.camera.x, FlxG.camera.y);
		_clockText.size = 20;
		_clockText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK);
//		_clockText.scrollFactor.set(0, 0);

		_insanityBar = new FlxBar(FlxG.camera.x + (FlxG.camera.width - 155), FlxG.camera.y + 2, FlxBar.FILL_LEFT_TO_RIGHT, 150, 15, null, "", 0, 300 );
		_insanityBar.createFilledBar(FlxColor.CRIMSON, FlxColor.GREEN, true, FlxColor.BLACK);
		
		add(_insanityBar);
		add(_clockText);

		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set();
		});
		
		_currentInsanity = InitInsanity;
    }

    public function updateHUD(TimeLeft:Float, Insanity:Int = 0):Void
    {
		calculateTimeLeft(TimeLeft);
		calculateInsanity(Insanity);
    }
	
	public function calculateTimeLeft(TimeLeft:Float):Void
	{
		var minutes:Int;
		var seconds:Int;
		
		minutes = 0;
		seconds = 0;
		
		minutes = Std.int(TimeLeft / 60);
		seconds = Std.int(TimeLeft) % 60;
		
		_clockText.text = minutes + ':';
		if (seconds < 10)
		{
			_clockText.text += '0';
		}
		_clockText.text += seconds;
		
		if (seconds % 5 == 0 && !_insanityTimeTick)
		{
			calculateInsanity(1);
			_insanityTimeTick = true;
		}
		else if (seconds % 5 != 0)
		{
			_insanityTimeTick = false;
		}
	}
	
	private function calculateInsanity(Insanity:Int):Void
	{
		_currentInsanity -= Insanity;
		_insanityBar.currentValue = _currentInsanity;
	}
	
	public function getCurrentInsanity():Int
	{
		return _currentInsanity;
	}
	
}