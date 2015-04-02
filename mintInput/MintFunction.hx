package mintInput;

class MintFunction
{
	public var instance:Dynamic;
	public var functionName:String;

	public function new(instance:Dynamic, functionName:String)
	{
		this.instance = instance;
		this.functionName = functionName;
	}

	public function call(arguments):Void
	{
		Reflect.callMethod(instance, Reflect.field(instance, functionName), arguments);
	}
}