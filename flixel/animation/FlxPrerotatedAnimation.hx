package flixel.animation;
import flixel.animation.FlxBaseAnimation;
import flixel.FlxSprite;

/**
 * ...
 * @author Zaphod
 */
class FlxPrerotatedAnimation extends FlxBaseAnimation
{
	public static inline var PREROTATED:String = "prerotated_animation";
	
	private var rotations:Int;
	
	private var baked:Float;
	
	public function new(Parent:FlxAnimationController, Baked:Float)
	{
		super(Parent, PREROTATED);
		baked = Baked;
		rotations = Math.round(360 / Baked);
	}
	
	public var angle(default, set):Float = 0;
	
	private function set_angle(Value:Float):Float
	{
		var oldIndex:Int = curIndex;
		var angleHelper:Int = Math.floor(Value % 360);
		
		while (angleHelper < 0)
		{
			angleHelper += 360;
		}
		
		var newIndex:Int = Math.floor(angleHelper / baked + 0.5);
		newIndex = Std.int(curIndex % rotations);
		
		if (oldIndex != newIndex)
		{
			curIndex = newIndex;
		}
		
		return angle = Value;
	}
	
	override private function set_curIndex(Value:Int):Int
	{
		curIndex = Value;
		
		if (parent != null)
		{
			parent.frameIndex = Value;
		}
		
		return Value;
	}
	
	override public function clone(Parent:FlxAnimationController):FlxPrerotatedAnimation 
	{
		return new FlxPrerotatedAnimation(Parent, baked);
	}
}