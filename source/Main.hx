package;

import openfl.utils.Assets;
import flixel.FlxG;
import lime.app.Application;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) {
			#if (target.threaded)
			sys.thread.Thread.create(() -> {
				var log:String = '${infos.fileName}:${infos.methodName}():${infos.lineNumber}: $v';
				Sys.println(log);
			});
			#else
			var log:String = '${infos.fileName}:${infos.methodName}():${infos.lineNumber}: $v';
			Sys.println(log);
			#end
		};

		super();

		addChild(new FlxGame(0, 0, TitleState));

		engine.Options.init();
		
		#if debug
		addChild(new FPS(10, 3, 0xFFFFFF));
		#end
	}
}