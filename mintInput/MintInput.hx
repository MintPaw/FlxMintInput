package mintInput;

import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.JoystickEvent;
import openfl.events.KeyboardEvent;

class MintInput
{
	public static var BIND:Int = 0;
	public static var FUNCTION_CALL:Int = 1;

	public static var DOWN:Int = 2;
	public static var UP:Int = 3;
	public static var DOWN_ONCE:Int = 4;
	public static var UP_ONCE:Int = 5;

	private static var _stageRef:Stage;

	private static var _stateMap:Map<Int, Int>;
	private static var _binds:Array<MintKey>;
	//private static var _actionMap:Map<String, MintInputAction>;

	private static var _joyAddFunction:Dynamic;
	private static var _joyRemovedFunction:Dynamic;

	public function new()
	{

	}

	public static function init(stage:Stage):Void
	{
		_stageRef = stage;

		_stateMap = new Map();

		unbindAll();
		addListeners();
	}

	public static function bindToFunction(key:String, instance:Dynamic, functionName:String, arguments:Array<Dynamic>, fireCondition:Int):Void
	{
		var mintKey:MintKey = new MintKey(keyMap.get(key), fireCondition, arguments);
		var mintFunction:MintFunction = new MintFunction(instance, functionName);

		mintKey.mintFunction = mintFunction;

		_binds.push(mintKey);
	}

	public static function bindKeyToAction(key:String, actionName:String, arguments:Array<Dynamic>, fireCondition:Int):Void
	{
		var action:MintInputAction = new MintInputAction();
		action.key = keyMap.get(key);
		action.actionType = BIND;
		action.actionName = actionName;
		action.arguments = arguments;
		action.fireCondition = fireCondition;

		//_bindMap.get(action.key).push(action);
	}

	public static function bindActionToFunction(actionName:String, instance:Dynamic, functionName:String):Void
	{

	}

	public static function bindJoyAdded(addFunction:Int->Void):Void
	{
		_joyAddFunction = addFunction;
	}

	public static function bindJoyRemoved(removeFunction:Int->Void):Void
	{
		_joyRemovedFunction = removeFunction;
	}

	public static function unbindAll():Void
	{
		_binds = [];

		for (i in -1000...1000)
			_stateMap.set(i, 0);
	}

	private static function addListeners():Void
	{
		_stageRef.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
		_stageRef.addEventListener(KeyboardEvent.KEY_UP, keyUpEvent);
		_stageRef.addEventListener(JoystickEvent.DEVICE_ADDED, joyAddedEvent);
		_stageRef.addEventListener(JoystickEvent.DEVICE_REMOVED, joyRemovedEvent);
		_stageRef.addEventListener(Event.ENTER_FRAME, update);
	}

	private static function keyDownEvent(e:KeyboardEvent):Void
	{
		handleInput(e.keyCode, true);
	}

	private static function keyUpEvent(e:KeyboardEvent):Void
	{
		handleInput(e.keyCode, false);
	}

	private static function joyAddedEvent(e:JoystickEvent):Void
	{
		if (_joyAddFunction != null)
			_joyAddFunction(e.device);
	}

	private static function joyRemovedEvent(e:JoystickEvent):Void
	{
		if (_joyRemovedFunction != null)
			_joyRemovedFunction(e.device);
	}

	private static function update(e:Event):Void
	{
		for (key in _binds)
		{
			if (
				(key.fireCondition == DOWN && _stateMap.get(key.key) == 1) ||
				(key.fireCondition == UP && _stateMap.get(key.key) == 0)) fire(key);
		}
	}

	private static function handleInput(keyCode:Int, down:Bool):Void
	{
		var justDown:Bool = _stateMap.get(keyCode) == 0 && down;
		var justUp:Bool = _stateMap.get(keyCode) == 1 && !down;

		for (key in _binds)
		{
			if (
				key.key == keyCode && (
					(key.fireCondition == DOWN_ONCE && justDown) ||
					(key.fireCondition == UP_ONCE && justUp))) fire(key);
		}

		_stateMap.set(keyCode, down ? 1 : 0);
	}

	private static function fire(key:MintKey):Void
	{
		if (key.mintFunction != null) key.mintFunction.call(key.arguments);

	}

	private static var keyMap:Map<String, Int> =
	[
		"a" => 65,
		"b" => 66,
		"c" => 67,
		"d" => 68,
		"e" => 69,
		"f" => 70,
		"g" => 71,
		"h" => 72,
		"i" => 73,
		"j" => 74,
		"k" => 75,
		"l" => 76,
		"m" => 77,
		"n" => 78,
		"o" => 79,
		"p" => 80,
		"q" => 81,
		"r" => 82,
		"s" => 83,
		"t" => 84,
		"u" => 85,
		"v" => 86,
		"w" => 87,
		"x" => 88,
		"y" => 89,
		"z" => 90
	];

}