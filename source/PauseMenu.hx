package;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class PauseMenu extends FlxSubState
{
	private var b:FlxButton;
	private var _pauseMessage:FlxText;
	
	override public function create():Void
	{
		//_pauseMessage = new FlxText(0, 0, 0, null, 8, false);
		_pauseMessage = new FlxText(0, 0, 440);
		_pauseMessage.text = "Game Paused";
		_pauseMessage.setFormat("assets/GenBasR.ttf", 40, FlxColor.WHITE, "center", FlxText.BORDER_OUTLINE, FlxColor.BLACK, false);
		//_pauseMessage.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 1);
		_pauseMessage.x = FlxG.width / 2 - _pauseMessage.width / 2;
		_pauseMessage.y = FlxG.height / 2 - _pauseMessage.height / 2;
		
		b = new FlxButton(0, 0, "Back", backFunc);
		b.x = _pauseMessage.getMidpoint().x - b.width / 2;
		b.y = (_pauseMessage.getMidpoint().y + (_pauseMessage.height / 2)) + b.height + 15;
		
		_pauseMessage.scrollFactor.set();
		b.scrollFactor.set();
		
		add(_pauseMessage);
		add(b);
		FlxG.mouse.visible = true;
		super.create();
	}
	
	override public function update():Void
	{
		
		if (FlxG.keys.pressed.ESCAPE)
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
	
	private function backFunc():Void
	{
		close();
	}
	
	override public function close():Void
	{
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = false;
		#end
		super.close();
	}
}