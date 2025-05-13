package objects;

import engine.Paths;
import engine.Styles.StyleData;
import engine.Styles.LocalStyle;
import engine.Styles.StyleHandler;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class ArrowStrums extends FlxTypedSpriteGroup<FlxSprite>
{
    public var strums:Array<FlxSprite> = [];

    private var idleOffsets:Map<Int, Array<Float>> = new Map();
    private var pressedOffsets:Map<Int, Array<Float>> = new Map();
    private var confirmOffsets:Map<Int, Array<Float>> = new Map();

    override public function new(x:Float, y:Float)
    {
        super(x, y, 4);

		for (i in 0...4)
		{
			var babyArrow:FlxSprite = new FlxSprite();

			babyArrow.frames = Paths.getSparrow('ui/STRUM_assets');

			babyArrow.antialiasing = true;
			babyArrow.setGraphicSize(Note.swagWidth);

            babyArrow.x += Note.swagWidth * i;

            switch (i) {
                case 0:
                    babyArrow.animation.addByPrefix('static', 'left strum', 24);
                    babyArrow.animation.addByPrefix('pressed', 'left pressed', 24, false);
                    babyArrow.animation.addByPrefix('confirm', 'left confirmed', 24, false);

                    idleOffsets.set(i, [0, 0]);
                    pressedOffsets.set(i, [0, 0]);
                    confirmOffsets.set(i, [-13, -13]);
                case 1:
                    babyArrow.animation.addByPrefix('static', 'down strum', 24);
                    babyArrow.animation.addByPrefix('pressed', 'down pressed', 24, false);
                    babyArrow.animation.addByPrefix('confirm', 'down confirmed', 24, false);

                    idleOffsets.set(i, [0, 0]);
                    pressedOffsets.set(i, [0, 0]);
                    confirmOffsets.set(i, [-14, -10]);
                case 2:
                    babyArrow.animation.addByPrefix('static', 'up strum', 24);
                    babyArrow.animation.addByPrefix('pressed', 'up pressed', 24, false);
                    babyArrow.animation.addByPrefix('confirm', 'up confirmed', 24, false);

                    idleOffsets.set(i, [0, 0]);
                    pressedOffsets.set(i, [0, 0]);
                    confirmOffsets.set(i, [-13, -13]);
                case 3:
                    babyArrow.animation.addByPrefix('static', 'right strum', 24);
                    babyArrow.animation.addByPrefix('pressed', 'right pressed', 24, false);
                    babyArrow.animation.addByPrefix('confirm', 'right confirmed', 24, false);

                    idleOffsets.set(i, [0, 0]);
                    pressedOffsets.set(i, [0, 0]);
                    confirmOffsets.set(i, [-13, -13]);
            }

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			babyArrow.ID = i;

            strums.push(babyArrow);
            add(babyArrow);

			playAnim(i, 'static');
		}
    }

    public function playAnim(arrow:Int, name:String, ?force:Bool = true) {
        var babyArrow = strums[arrow];
        if (babyArrow == null)
            return;

        babyArrow.animation.play(name, force);

        babyArrow.centerOffsets();
        switch (name) {
            case 'static':
                babyArrow.offset.x += idleOffsets.get(arrow)[0];
                babyArrow.offset.y += idleOffsets.get(arrow)[1];
            case 'pressed':
                babyArrow.offset.x += pressedOffsets.get(arrow)[0];
                babyArrow.offset.y += pressedOffsets.get(arrow)[1];
            case 'confirm':
                babyArrow.offset.x += confirmOffsets.get(arrow)[0];
                babyArrow.offset.y += confirmOffsets.get(arrow)[1];
        }
    }

    public function animateArrows()
    {
        for (i in 0...4){
            var babyArrow = strums[i];

            babyArrow.y -= 10;
            babyArrow.alpha = 0;
            FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
        }
    }
}