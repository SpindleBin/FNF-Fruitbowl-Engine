package objects;

import engine.Paths;
import flixel.tweens.FlxTween;
import engine.Styles.StyleData;
import engine.Styles.LocalStyle;
import engine.Options;
import engine.Conductor;
import engine.Styles.StyleHandler;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

using StringTools;

class Note extends FlxSprite
{
	public static var swagWidth:Float = 160 * 0.7;

	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var altAnimation:Bool = false;

	public var noteScore:Float = 1;

	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var xOffset:Float = 0;
	public var yOffset:Float = 0;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		visible = false;

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		this.strumTime = strumTime;
		this.noteData = noteData;

		// Sprites
		frames = Paths.getSparrow('ui/NOTE_assets');

		animation.addByPrefix('leftScroll', 'left0', 24);
		animation.addByPrefix('leftHold', 'left hold0', 24);
		animation.addByPrefix('leftHoldEnd', 'left hold end0', 24);

		animation.addByPrefix('downScroll', 'down0', 24);
		animation.addByPrefix('downHold', 'down hold0', 24);
		animation.addByPrefix('downHoldEnd', 'down hold end0', 24);

		animation.addByPrefix('upScroll', 'up0', 24);
		animation.addByPrefix('upHold', 'up hold0', 24);
		animation.addByPrefix('upHoldEnd', 'up hold end0', 24);

		animation.addByPrefix('rightScroll', 'right0', 24);
		animation.addByPrefix('rightHold', 'right hold0', 24);
		animation.addByPrefix('rightHoldEnd', 'right hold end0', 24);

		setGraphicSize(swagWidth);
		updateHitbox();
		antialiasing = true;

		switch (noteData)
		{
			case 0:
				animation.play('leftScroll');
			case 1:
				animation.play('downScroll');
			case 2:
				animation.play('upScroll');
			case 3:
				animation.play('rightScroll');
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			switch (noteData)
			{
				case 0:
					animation.play('leftHoldEnd');
				case 1:
					animation.play('downHoldEnd');
				case 2:
					animation.play('upHoldEnd');
				case 3:
					animation.play('rightHoldEnd');
			}

			updateHitbox();
			
			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('leftHold');
					case 1:
						prevNote.animation.play('downHold');
					case 2:
						prevNote.animation.play('upHold');
					case 3:
						prevNote.animation.play('rightHold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.curSong.speed;
				prevNote.updateHitbox();
			}

			yOffset = -10;
			xOffset = (swagWidth / 2) - (width / 2);
			if (Options.get("downscroll") == true) {
				flipY = !flipY;
			}
		}
	}

	public var noteOnTime:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
			&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.75)) // funni
		{
			canBeHit = true;
		}
		else
			canBeHit = false;

		if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset)
			tooLate = true;

		if (!noteOnTime && strumTime <= Conductor.songPosition) {
			noteOnTime = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}