package ;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

/**
 * ...
 * @author Jason McLaughlin
 */
class SecondFloor extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _grpEnemies:FlxTypedGroup<Ghost>;
	private var _grpMoney:FlxTypedGroup<Money>;
	private var _hud:HUD;
	static public var hud:HUD;
	
	override public function create():Void
	{
		_hud = SecondFloor.hud;
		
		_map = new FlxOgmoLoader(AssetPaths.level2__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tilemap2__png, 32, 32, "walls");
		tileProperties();
		add(_mWalls);
		
		_grpEnemies = new FlxTypedGroup<Ghost>();
		_player = new Player();
		_grpMoney = new FlxTypedGroup<Money>();
		_map.loadEntities(placeEntities, "entities");
		
		add(_player);
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		
		add(_hud);
		
		super.create();
	}
	
	override public function destroy():Void
	{
		
	}
	
	override public function update():Void
	{
		super.update();
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_grpEnemies, _mWalls);
		FlxG.overlap(_player, _grpMoney, playerTouchMoney);
	}
	
	private function playerTouchMoney(player:Player, dollar:Money):Void
	{
		if (player.alive && player.exists && dollar.alive && dollar.exists)
		{
			dollar.kill();
		}
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
		else if (entityName == "money")
		{
			_grpMoney.add(new Money(x, y));
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
		_mWalls.setTileProperties(10, FlxObject.ANY);
		_mWalls.setTileProperties(11, FlxObject.ANY);
		_mWalls.setTileProperties(12, FlxObject.ANY);
		_mWalls.setTileProperties(13, FlxObject.ANY);
		_mWalls.setTileProperties(15, FlxObject.ANY);
		_mWalls.setTileProperties(16, FlxObject.ANY);
		_mWalls.setTileProperties(17, FlxObject.NONE);
		_mWalls.setTileProperties(18, FlxObject.NONE);
		_mWalls.setTileProperties(19, FlxObject.ANY, goDownstairs, Player);
		_mWalls.setTileProperties(20, FlxObject.ANY, goDownstairs, Player);
		_mWalls.setTileProperties(24, FlxObject.ANY, goDownstairs, Player);
		_mWalls.setTileProperties(25, FlxObject.ANY, goDownstairs, Player);
	}
	
	private function goDownstairs(Tile:FlxObject, Object:FlxObject):Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new GroundFloor());
		});
	}
}

