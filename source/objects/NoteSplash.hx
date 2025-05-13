package objects;

import engine.Paths;
import engine.Styles.StyleData;
import engine.Styles.LocalStyle;
import engine.Styles.StyleHandler;
import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite {
    override public function new(?x:Float = 0, ?y:Float = 0)
    {
        super(x, y);

        frames = Paths.getSparrow('ui/noteSplashes');
        alpha = 0.7;

        for (i in 1...3)
        {
            animation.addByPrefix("purpleSplash" + i, 'note impact $i purple', 24, false);
            animation.addByPrefix("blueSplash" + i, 'note impact $i blue', 24, false);
            animation.addByPrefix("greenSplash" + i, 'note impact $i green', 24, false);
            animation.addByPrefix("redSplash" + i, 'note impact $i red', 24, false);
        }

        antialiasing = true;
    }

    override public function update(elapsed:Float){
        super.update(elapsed);

        if (animation.curAnim == null || animation.curAnim != null && animation.curAnim.finished)
            this.kill();
    }

    public function splash(note:Int = 0, x:Float, y:Float)
    {
        this.setPosition(x - 80, y - 96);

        var color:String = null;
        switch (note) {
            default:
                color = 'purple';
            case 1:
                color = 'blue';
            case 2:
                color = 'green';
            case 3:
                color = 'red';
        }

        var rand:Int = FlxG.random.int(1, 2);
        this.animation.play('${color}Splash${rand}');
        this.alpha = 0.7;
    }
}

typedef SplashProperties =
{
    var fps:Int;
    var offsets:Array<Float>;
    var alpha:Float;
    var impactAmount:Int;
}