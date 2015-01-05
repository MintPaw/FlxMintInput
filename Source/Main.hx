package;

import motion.Actuate;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Main extends Sprite
{
	private var _aPress:TextField = new TextField();
	private var _aRelease:TextField = new TextField();
	private var _aHold:TextField = new TextField();
	
	public function new()
	{
		super();

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		FlxMintInput.init(stage);
		stage.frameRate = 60;

		var textFormat:TextFormat = new TextFormat("Arial", 16);
		var textPadding:Int = 10;

		_aPress.width = _aRelease.width = _aHold.width = 200;
		_aPress.defaultTextFormat = _aRelease.defaultTextFormat = _aHold.defaultTextFormat = textFormat;

		_aPress.x = textPadding;
		_aRelease.x = _aPress.x + _aPress.width + textPadding;
		_aHold.x = _aRelease.x + _aRelease.width + textPadding;

		_aPress.y = textPadding;
		_aRelease.y = textPadding;
		_aHold.y = textPadding;

		_aPress.text = "The A button was pressed";
		_aRelease.text = "The A button was released";
		_aHold.text = "The A button is down";

		_aPress.selectable = _aPress.selectable = _aHold.selectable = false;

		addChild(_aPress);
		addChild(_aRelease);
		addChild(_aHold);

		FlxMintInput.bindToFunction("a", this, "handleTextChange", [true, false, true], FlxMintInput.DOWN_ONCE);
		FlxMintInput.bindToFunction("a", this, "handleTextChange", [false, true, false], FlxMintInput.UP_ONCE);
		FlxMintInput.bindToFunction("a", this, "handleTextChange", [false, false, true], FlxMintInput.DOWN);
		FlxMintInput.bindToFunction("a", this, "handleTextChange", [false, false, false], FlxMintInput.UP);
	}

	private function handleTextChange(justDown:Bool, justUp:Bool, down:Bool):Void
	{
		if (justDown)
		{
			_aPress.scaleX = _aPress.scaleY = 1.5;
			Actuate.tween(_aPress, .5, { scaleX: 1, scaleY: 1 } );
		} else if (justUp) {
			_aRelease.scaleX = _aRelease.scaleY = 1.5;
			Actuate.tween(_aRelease, .5, { scaleX: 1, scaleY: 1 } );
		} else if (down) {
			_aHold.scaleX = _aHold.scaleY = 1.5;
		} else {
			_aHold.scaleX = _aHold.scaleY = 1;
		}
	}
	
}