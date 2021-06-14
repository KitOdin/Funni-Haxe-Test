package;


import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.ui.FlxBar;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class PlayState extends FlxState
{

	var SampleImage:FlxSprite;
	var SampleText:FlxText;
	var Target:FlxSprite;
	var MuchWin:FlxSprite;
	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var camFollow:FlxObject;
	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;
	private var barVill:Float = 1;

	override public function create()
	{
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];
		var gridBG:FlxSprite = FlxGridOverlay.create(10, 10);
		gridBG.scrollFactor.set(0.5, 0.5);
		add(gridBG);
		SampleText = new FlxText(10, 10, 0, "weed", 42); //smoke weed every day
		SampleText.scrollFactor.set(0.9, 0.8);
		
		SampleImage = new FlxSprite(420, 69).loadGraphic(AssetPaths.flixlogo__png);
		SampleImage.scrollFactor.set(0.69, 0.420);
		add(SampleImage);
		
		MuchWin = new FlxSprite(666, 666).loadGraphic(AssetPaths.funkin__png); //cursed number #666
		MuchWin.scrollFactor.set(0.7, 0.7); //77 MOMENT
		add(MuchWin);
		
		add(SampleText);
		
		
		generateLand(10);
		var buttony:FlxButton = new FlxButton(432, 234, 'Im a button', testFunc);
		add(buttony);
		var mousebut:FlxButton = new FlxButton(432, 284, 'I want mouse!', commitMousecide);
		add(mousebut);
		var consum:FlxButton = new FlxButton(532, 234, 'Consume the bar', consume);
		add(consum);
		var nutfill:FlxButton = new FlxButton(532, 284, 'Need sum bar.', filley);
		add(nutfill);
		var snappy:FlxButton = new FlxButton(432, 334, 'Reject humans, snap necc.', lockontech);
		add(snappy);
		camFollow = new FlxObject(69, 69, 1, 1);
		add(camFollow);
		
		
		
		
		FlxG.camera.follow(camFollow, LOCKON, 0.04);
		FlxG.camera.zoom = 1.05;

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		
		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(AssetPaths.healthBar__png);
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'barVill', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFF69420F, 0xFFFF8427);
		// healthBar
		add(healthBar);
		
		buttony.cameras = [camHUD];
		mousebut.cameras = [camHUD];
		consum.cameras = [camHUD];
		nutfill.cameras = [camHUD];
		snappy.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		
		
		super.create();
	}

	var debugNum:Int = 0;

	function testFunc()
	{
		if(SampleText.text != "poo poo")
		{
			SampleText.text = "poo poo";
		}
		else
		{
			SampleText.text = "weed";
		}
	}
	
	function commitMousecide()
	{
		FlxG.mouse.visible = !FlxG.mouse.visible;
	}
	
	function consume()
	{
		barVill -= 0.01;
	}
	
	function filley()
	{
		barVill += 0.01;
	}
	
	
	function lockontech()
	{
		if (Target != MuchWin)
		{
			Target = MuchWin;
		}
		else
		{
			Target = SampleImage;
		}
		camFollow.setPosition(Target.x, Target.y);
	}
	
	function generateLand(Thingy:Int)
	{
		for (i in 0...Thingy)
		{
			trace(i);
			var ConfinedSquare = new SquareThing(i);
			ConfinedSquare.x += 420;
			ConfinedSquare.y += 420;
			ConfinedSquare.scrollFactor.set(0.6, 0.9); //69 momento
			add(ConfinedSquare);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		var zoomin = FlxG.keys.anyPressed([E, V]);
		var zoomout = FlxG.keys.anyPressed([Q, B]);
		var up = FlxG.keys.anyPressed([W, UP]);
		var right = FlxG.keys.anyPressed([D, RIGHT]);
		var down = FlxG.keys.anyPressed([S, DOWN]);
		var left = FlxG.keys.anyPressed([A, LEFT]);
		
		if (zoomin)
			FlxG.camera.zoom += FlxG.elapsed;
		if (zoomout)
			FlxG.camera.zoom -= FlxG.elapsed;
		
		
		if(up)
		{
			camFollow.velocity.y = -90;
		}
		else if(down)
		{
			camFollow.velocity.y = 90;
		}
		else
		{
			camFollow.velocity.y = 0;
		}
		if(right)
		{
			camFollow.velocity.x = 90;
		}
		else if(left)
		{
			camFollow.velocity.x = -90;
		}
		else
		{
			camFollow.velocity.x = 0;
		}
	}

	
}
