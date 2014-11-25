
package game {

import flash.display.Sprite;

public class Main extends Sprite{

    public static var gameName:String = "Truco";

    public function Main() {

    }

    public function getAssets():Array {

        return Assets.stringAssets;

    }

    public function getGameClass():Class {

        return Game;

    }

}
}
