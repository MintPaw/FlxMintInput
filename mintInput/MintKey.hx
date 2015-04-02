package mintInput;

class MintKey
{
	public var key:Int;
	public var fireCondition:Int;
	public var arguments:Array<Dynamic>;

	public var mintFunction:MintFunction;
	public var actionName:String;

	public function new(key:Int, fireCondition:Int, arguments:Array<Dynamic>)
	{
		this.key = key;
		this.fireCondition = fireCondition;
		this.arguments = arguments;
	}
}