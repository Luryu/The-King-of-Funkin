package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverContinueSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var round:FlxSprite;
	var animation:FlxSprite;
	var bgFade:FlxSprite;
	var white:FlxSprite;
	var bgBlack:FlxSprite;
	var endCounter:Int = 0;
	var comienzaAnimacion:Int = 0;
	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf-continueIori';
		}

		super();
		Conductor.songPosition = 0;

		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;
		white = new FlxSprite(0,0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), 0xffffffff);
		white.scrollFactor.set();
		white.screenCenter();
		white.y += 50;
		white.updateHitbox();
		white.alpha = 1;
			
		bgFade = new FlxSprite(0,0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), 0xfff10202);
		bgFade.scrollFactor.set();
		bgFade.screenCenter();
		bgFade.y += 50;
		bgFade.updateHitbox();
		bgFade.alpha = 1;
		add(bgFade);
		FlxG.sound.play(Paths.sound('kof97win'));

		bgBlack = new FlxSprite(0,0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), 0xff000000);
		bgBlack.scrollFactor.set();
		bgBlack.screenCenter();
		bgBlack.y += 50;
		bgBlack.updateHitbox();
		bgBlack.alpha = 0;
		
		var roundTex = Paths.getSparrowAtlas('characters/winIori');
		switch(PlayState.SONG.player2){
			case'iori':
			roundTex = Paths.getSparrowAtlas('characters/winIori');
			trace("Hiiii <3");
			case'orochi-iori':
			roundTex = Paths.getSparrowAtlas('characters/wiOrochiIori');
		}
	trace("a");
		add(white);
		
		var animatonText = Paths.getSparrowAtlas('characters/Continue');
		animation = new FlxSprite();
		animation.frames = animatonText;
		animation.animation.addByPrefix('deathLoop', "deathLoop", 24, true);
		animation.animation.addByPrefix('deathConfirm', "deathConfirm", 24, false);
		animation.screenCenter();
		
		round = new FlxSprite();
		round.frames = roundTex;
		round.animation.addByPrefix('firstDeath', "win", 12, false);
		round.screenCenter();
		round.x += 150;
		round.y += 20;
		switch(PlayState.SONG.player2){
			case'orochi-iori':
				round.screenCenter(X);
				trace(round.x,round.y);
				round.x = -290;
				trace(round.x,round.y);
		}
		new FlxTimer().start(0.3, function(tmr:FlxTimer)
			{
				white.alpha -= 0.15;

				if (white.alpha > 0)
				{
					tmr.reset(0.3);
				}

				add(round);
				round.animation.play('firstDeath');
			});
		
		new FlxTimer().start(6, function(tmr:FlxTimer){
			round.alpha = 0;
			round.destroy();
			bgFade.alpha = 0;
			bgBlack.alpha = 1;
			white.alpha = 0.85;
			
			FlxG.sound.playMusic(Paths.music('Kof97_GameOver'));
			new FlxTimer().start(0.3, function(tmr:FlxTimer)
			{
				white.alpha -= 0.15;
				
				if (white.alpha > 0)
				{
					tmr.reset(0.3);
				}
			add(bgBlack);
			add(animation);
			animation.animation.play('deathLoop');
			comienzaAnimacion = 1;
			new FlxTimer().start(14, function(tmr:FlxTimer){
				FlxG.sound.music.stop();
	
				if (PlayState.isStoryMode)
					FlxG.switchState(new TitleState());
				else
					FlxG.switchState(new TitleState());
				PlayState.loadRep = false;
			});
		});
			});
			
		
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new TitleState());
			else
				FlxG.switchState(new TitleState());
			PlayState.loadRep = false;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			if(comienzaAnimacion == 1){
				animation.animation.play('deathConfirm', false);
			}
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.initialHealth = false;
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
