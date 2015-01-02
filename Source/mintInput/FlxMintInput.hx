package mintInput;

import openfl.display.Stage;
import openfl.events.KeyboardEvent;

class FlxMintInput
{
	private static var _stageRef:Stage;

	public function new()
	{

	}

	public static function init(stage:Stage):Void
	{
		_stageRef = stage;
		
		addListeners();
	}

	private static function addListeners():Void
	{
		_stageRef.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
		_stageRef.addEventListener(KeyboardEvent.KEY_UP, keyUpEvent);
	}

	private static function keyDownEvent(e:KeyboardEvent):Void
	{
		
	}

	private static function keyUpEvent(e:KeyboardEvent):Void
	{
		
	}

}