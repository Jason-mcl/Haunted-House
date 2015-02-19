package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class SecondFloorTempMenu extends FlxSubState
{
	private var _frame:FlxSprite;
	private var _message:FlxText;

	override public function create():Void
	{
		_frame = new FlxSprite(0, 0);
		_frame.loadGraphic("assets/images/dialogFrame.png");
		
		_message = new FlxText(10, 430, 500, 8, false);
		_message.text = "I probably shouldn't go up there";
		_message.setFormat("assets/GenBasR.tff", 24, FlxColor.WHITE, "center");
		_message.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		
		_frame.scrollFactor.set();
		_message.scrollFactor.set();
		
		
		add(_frame);
		add(_message);
		super.create();
	}
	
	override public function update():Void
	{
		
		if (FlxG.keys.pressed.ANY)
		{
			close();
		}
		super.update();
	}
	
	override public function destroy():Void
    {
        //call super to destroy the core state class objects
        super.destroy();
    }
}