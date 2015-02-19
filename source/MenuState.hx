package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		//TODO: Create an image to use as a start game button
		var startButton = new FlxButton(0, 0, "Start Game", startGame);
		
		
//		startButton.label.setFormat("assests/GenBasR.ttf", 30, FlxColor.WHITE, "center");
//		startButton.label.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 1);
		
		startButton.x = (FlxG.width / 2) - startButton.width / 2;
		startButton.y = (FlxG.height / 2) - startButton.height / 2;

		add(startButton);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	private function startGame():Void
	{
		FlxG.switchState(new GroundFloor());
	}
}