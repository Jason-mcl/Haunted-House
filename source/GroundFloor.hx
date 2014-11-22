package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class GroundFloor extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _grpEnemies:FlxTypedGroup<Ghost>;
	private var _hud:HUD;
	private var _gameClock:FlxTimer;
	private var _clockText:FlxText;
	private var _insanityBar:FlxBar;
	private var _insanityTmr:Float;
	private var _insanityTimeTick:Bool = false;
	
	var debugSoundRadius = new FlxSprite();
	var lineStyle:LineStyle = { color:FlxColor.FOREST_GREEN, thickness:1 };
	var fillStyle:FillStyle = { color:FlxColor.FOREST_GREEN, alpha:0.5 };
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_map = new FlxOgmoLoader(AssetPaths.level1__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tilemap2__png, 32, 32, "walls");
		tileProperties();
		add(_mWalls);
		
		_grpEnemies = new FlxTypedGroup<Ghost>();
		
		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		add(_grpEnemies);
		
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		
		debugSoundRadius.makeGraphic(_map.width, _map.height, FlxColor.TRANSPARENT, true);
		
		add(debugSoundRadius);
		
		_gameClock = new FlxTimer(300.0, gameOver);
		_clockText = new FlxText(FlxG.camera.x, FlxG.camera.y, 0);
		_clockText.size = 20;
		add(_clockText);

		
		_insanityBar = new FlxBar(FlxG.camera.x + (FlxG.camera.width - 155), FlxG.camera.y + 2, FlxBar.FILL_LEFT_TO_RIGHT, 150, 15, null, "", 0, 300 );
		_insanityBar.createFilledBar(FlxColor.CRIMSON, FlxColor.GREEN, true, FlxColor.BLACK);
		_insanityTmr = 0;
		add(_insanityBar);
		
		updateHUD();
		
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
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_grpEnemies, _mWalls);
		checkEnemyVision();
		//addSoundCircle();
		updateHUD();
		
		
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void 
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "enemy")
		{
			_grpEnemies.add(new Ghost(x, y, Std.parseInt(entityData.get("etype"))));
		}
	}
	
	private function tileProperties():Void
	{
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.NONE);
		_mWalls.setTileProperties(4, FlxObject.NONE);
		_mWalls.setTileProperties(5, FlxObject.ANY);
		_mWalls.setTileProperties(6, FlxObject.ANY);
		_mWalls.setTileProperties(10, FlxObject.ANY, goUpstairs);
		_mWalls.setTileProperties(11, FlxObject.ANY);
		_mWalls.setTileProperties(15, FlxObject.ANY, goUpstairs);
		_mWalls.setTileProperties(16, FlxObject.ANY);
	}
	
	private function checkEnemyVision():Void
	{
		var distance:Float;
		for (ghost in _grpEnemies.members)
		{
			distance = ghost.getMidpoint().distanceTo(_player.getMidpoint());
			if (_mWalls.ray(ghost.getMidpoint(), _player.getMidpoint()) && (ghost.getMidpoint().distanceTo(_player.getMidpoint()) < _player.soundRadius || ghost.getMidpoint().distanceTo(_player.getMidpoint()) < ghost.sightRadius))
			{
				ghost.seesPlayer = true;
				ghost.playerPos.copyFrom(_player.getMidpoint());
			}
			else
			{
				ghost.seesPlayer = false;
			}	
			
			if (_insanityTmr <= 0 && _mWalls.ray(ghost.getMidpoint(), _player.getMidpoint()))
			{
				if (distance <= _player.NO_SOUND)
				{
					_player.insanity -= 5;
				}
				else if (distance <= _player.SNEAK_SOUND)
				{
					_player.insanity -= 4;
				}
				else if (distance <= _player.REG_SOUND)
				{
					_player.insanity -= 3;
				}
				else if (distance <= _player.SPRINT_SOUND)
				{
					_player.insanity -= 2;
				}
				_insanityTmr = 0.5;
			}
			else
			{
				_insanityTmr -= FlxG.elapsed;
			}
		}
	}
	
	private function addSoundCircle():Void
	{
		var playerMid = _player.getMidpoint();
		debugSoundRadius.fill(FlxColor.TRANSPARENT);
		debugSoundRadius.drawCircle(playerMid.x, playerMid.y, _player.soundRadius, FlxColor.TRANSPARENT, lineStyle, fillStyle);
	}
	
	private function updateHUD():Void
	{
		var minutes:Int;
		var seconds:Int;
		
		minutes = 0;
		seconds = 0;
		
		_clockText.scrollFactor.set(0, 0);
		_clockText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK);
		minutes = Std.int(_gameClock.timeLeft / 60);
		seconds = Std.int(_gameClock.timeLeft) % 60;
		_clockText.text = minutes + ':';
		if (seconds < 10)
		{
			_clockText.text += '0';
		}
		_clockText.text += seconds;
		
		if (seconds % 5 == 0 && !_insanityTimeTick)
		{
			_player.insanity -= 1;
			_insanityTimeTick = true;
		}
		else if(seconds % 5 != 0)
		{
			_insanityTimeTick = false;
		}
		
		_insanityBar.scrollFactor.set(0, 0);
		_insanityBar.currentValue = _player.insanity;
	}
	
	private function gameOver(Timer:FlxTimer):Void
	{
		
	}
	
	private function goUpstairs(Tile:FlxObject, Object:FlxObject):Void
	{
		
	}
}