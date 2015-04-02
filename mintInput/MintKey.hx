package mintInput;

class MintKey
{
	public var key:Int;
	public var fireCondition:Int;

	public var mintFunction:MintFunction;
	
	public var actionName:String;
	public var arguments:Array<Dynamic>;

	public function new(key:Int, fireCondition:Int, arguments:Array<Dynamic>)
	{
		this.key = key;
		this.fireCondition = fireCondition;
		this.arguments = arguments;
	}

	public function toString():String
	{
		return "key: " + key + ", fireCondition: " + fireCondition + ", mintFunction:" + mintFunction + ", actionName: " + actionName + ", arguments: " + arguments;
	}
}