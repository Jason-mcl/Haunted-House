package;

/**
 * ...
 * @author ...
 */

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MerchantMenu extends FlxSubState
{
	
	private var _frame:FlxSprite;
	private var _message:FlxText;
	
	override public function create():Void
	{
		_frame = new FlxSprite(0, 0);
		_frame.loadGraphic("assets/images/dialogFrame.png");
		
		_message = new FlxText(15, 430, 700, 8, false);
		_message.text = "Sorry kid the shop isn't open yet. Try coming back later.";
		_message.setFormat("assets/GenBasR.tff", 17, FlxColor.WHITE, "left");
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
			#if !FLX_NO_MOUSE
			FlxG.mouse.visible = false;
			#end
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