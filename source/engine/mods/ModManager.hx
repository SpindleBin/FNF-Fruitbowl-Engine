package engine.mods;

import haxe.io.Path;
import sys.FileSystem;

using StringTools;

class ModManager {
    public static var mods:Map<String, String> = new Map();

    public static var modsFolder:String;

    public static function init()
    {
        var rootFolder:String = Path.directory(Sys.programPath());
        modsFolder = Path.normalize('$rootFolder/mods/');

        for (mod in FileSystem.readDirectory(modsFolder)) {
            if (mod != null #if !debug && !mod.endsWith('.ignore') #end) {

            }
        }
    }
}