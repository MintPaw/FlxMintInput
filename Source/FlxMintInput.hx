package;

import mintInput.FlxMintInputAction;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.JoystickEvent;
import openfl.events.KeyboardEvent;

class FlxMintInput
{
	public static var FUNCTION_CALL:Int = 0;
	public static var FLIP:Int = 1;
	public static var INCREMENT:Int = 2;
	public static var DECREMENT:Int = 3;
	public static var CUSTOM:Int = 4;

	public static var DOWN:Int = 5;
	public static var UP:Int = 6;
	public static var DOWN_ONCE:Int = 7;
	public static var UP_ONCE:Int = 8;

	private static var _stageRef:Stage;

	private static var _stateMap:Map<Int, Int>;
	private static var _bindMap:Map<Int, Array<FlxMintInputAction>>;

	private static var _joyAddFunction:Dynamic;
	private static var _joyRemovedFunction:Dynamic;

	public function new()
	{

	}

	public static function init(stage:Stage):Void
	{
		_stageRef = stage;
		
		_bindMap = new Map();
		_stateMap = new Map();

		unbindAll();
		addListeners();
	}

	public static function bindToFunction(key:String, instance:Dynamic, functionName:String, arguments:Array<Dynamic>, fireCondition:Int):Void
	{
		var action:FlxMintInputAction = new FlxMintInputAction();
		action.key = keyMap.get(key);
		action.actionType = FUNCTION_CALL;
		action.instance = instance;
		action.property = functionName;
		action.arguments = arguments;
		action.fireCondition = fireCondition;

		_bindMap.get(action.key).push(action);
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
		for (i in keyMap)
			_bindMap.set(i, []);

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
		for (i in _bindMap)
		{
			if (i == null)
				continue;

			for (action in i)
			{
				if (action.fireCondition == DOWN && _stateMap.get(action.key) == 1)
					fire(action);
				if (action.fireCondition == UP && _stateMap.get(action.key) == 0)
					fire(action);
			}
		}
	}

	private static function handleInput(keyCode:Int, down:Bool):Void
	{
		if (_bindMap.get(keyCode) == null) _bindMap.set(keyCode, []);

		var justDown:Bool = _stateMap.get(keyCode) == 0 && down;
		var justUp:Bool = _stateMap.get(keyCode) == 1 && !down;

		var actions:Array<FlxMintInputAction> = _bindMap.get(keyCode);

		for (i in actions)
		{
			if (i.fireCondition == DOWN_ONCE && justDown)
					fire(i);
			if (i.fireCondition == UP_ONCE && justUp)
					fire(i);
		}

		_stateMap.set(keyCode, down ? 1 : 0);
	}

	private static function fire(action:FlxMintInputAction):Void
	{
		Reflect.callMethod(action.instance, Reflect.field(action.instance, action.property), action.arguments);
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