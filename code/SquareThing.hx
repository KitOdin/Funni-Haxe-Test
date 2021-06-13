package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class SquareThing extends FlxSprite
{
	public function new(BSvalue:Int)
	{
		super();
		makeGraphic(50, 50);
		x += BSvalue * 50;
		switch(BSvalue % 6)
		{
			case 0:
				color = FlxColor.RED;
			case 1:
				color = FlxColor.CYAN;
			case 2:
				color = FlxColor.GREEN;
			case 3:
				color = FlxColor.PINK;
			case 4:
				color = FlxColor.PURPLE;
			case 5:
				color = FlxColor.BLUE;
		}
	}
	
}
