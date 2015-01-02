package;

import mintInput.FlxMintInput;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	
	
	public function new()
	{
		super();

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		FlxMintInput.init(stage);

		FlxMintInput.bindToFunction("a", this, "once", [true], FlxMintInput.DOWN_ONCE);
		FlxMintInput.bindToFunction("a", this, "once", [false], FlxMintInput.UP_ONCE);
		FlxMintInput.bindToFunction("b", this, "holdMe", [], FlxMintInput.DOWN);
	}

	private function once(down:Bool):Void
	{
		trace("The a button was " + (down ? "pressed" : "released"));
	}

	private function holdMe():Void
	{
		trace("The b button is down");
	}
	
}