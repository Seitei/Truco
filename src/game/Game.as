package game
{
import entities.Player;
import entities.Player;
import entities.iGame;

import flash.utils.Dictionary;

import helpers.Portrait;

import helpers.AlphaSprite;

import helpers.ExtendedButton;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

import starling.utils.AssetManager;

public class Game extends Sprite implements iGame
{

    public static const GAME_NAME:String = "Truco";

    //WRITE //READ //PRODUCTION
    //private static const ALPHA_SPRITE_MODE:String = "production";
    private static const ALPHA_SPRITE_MODE:String = "read";

    private var _doneButton:ExtendedButton;
    private var _assetManager:AssetManager;
    private var _player:Player;

    private var _players:Vector.<Player>;
    private var _portraits:Vector.<Portrait>;
    private var _palos:Array;
    private var _toSend:Object;
    private var _initialized:Boolean;
    private var _notInitializedPlayers:Vector.<Player>;
    private var _gameID:String;
    private var _matchID:int;

    public function Game(player:Player, assetManager:AssetManager)
    {

        visible = false;
        _assetManager = assetManager;
        loadGameAssets();
        _player = player;

        _players = new <Player>[];
        _portraits = new <Portrait>[];
        _notInitializedPlayers = new <Player>[];

        addPlayer(_player);
        /*addEventListener(Event.ADDED_TO_STAGE, onAdded);

        this.addEventListener(Event.ADDED, onChildAdded);
        this.addEventListener(Event.REMOVED, onChildRemoved);

        _palos = ["Oro", "Basto", "Espada", "Copa"];*/

    }

    private function loadGameAssets():void {

        _assetManager.enqueue(Assets.stringAssets);
        _assetManager.loadQueue(onProgress);

    }

    private function onProgress(ratio:Number):void {

        if(ratio == 1){

            init();

        }
    }

    private function onKeyDown(e:KeyboardEvent):void {

        var randomPalo:int = _palos[Math.floor(Math.random() * 4)];
        var randomNumber:int = Math.random() * 12;

        _toSend = {palo: randomPalo, number: randomNumber};

    }

    private function init():void {

        dispatchEventWith("gameConstructionComplete", true, this);

        var background:Image = new Image(_assetManager.getTexture("background_truco"));
        addChild(background);

        //done button
        var upState:Image = new Image(_assetManager.getTexture("done_button_up"));
        upState.name = "up0000";
        var hoverState:Image = new Image(_assetManager.getTexture("done_button_hover"));
        hoverState.name = "hover0000";
        var downState:Image = new Image(_assetManager.getTexture("done_button_hover"));
        downState.name = "down0000";
        var disabledState:Image = new Image(_assetManager.getTexture("done_button_disabled"));
        disabledState.name = "disabled0000";

        var buttonsStates:Array = new Array();
        buttonsStates.push(upState, downState, hoverState, disabledState);

        createSlots();

        _doneButton = new ExtendedButton(buttonsStates);
        _doneButton.enabled = false;
        _doneButton.name = "done_button";

        //_doneButton.addEventListener("buttonTriggeredEvent", onMyTurnEnd);
        addChild(_doneButton);

        _initialized = true;

        checkNotInitializedPlayers();
        //createTurns();

        //this should execute when the player clicks the game in MY_GAMES list.
        //_player.getTurn(_matchID).start();

    }

    private function checkNotInitializedPlayers():void {

        for each(var player:Player in _notInitializedPlayers){

            addPlayer(player);

        }
    }

    public function createSlots():void {

        placePortrait(stage.stageWidth / 2, stage.stageHeight - 75);
        placePortrait(stage.stageWidth / 2, 0);
        placePortrait(0, stage.stageHeight / 2);
        placePortrait(stage.stageWidth - 75, stage.stageHeight / 2);

    }

    private function placePortrait(coordX:Number, coordY:Number):void {

        var portrait:Portrait = new Portrait();
        portrait.x = coordX;
        portrait.y = coordY;
        addChild(portrait);
        _portraits.push(portrait);

    }

    public function addPlayer(player:Player):Boolean {

        //check if already exists
        for each(var fPlayer:Player in _players){

            if(fPlayer.userName == player.userName){

                return false;

            }

        }

        if(_initialized){
            _players.push(player);
            _portraits[_players.indexOf(player)].setPlayer(player);
        }
        else {
            _notInitializedPlayers.push(player);
        }

        return true;

    }

    private function createTurns():void {

        /*_player.getTurn(_matchID).createState(
                //state name
                "PLACE_CARD",
                //start
                {
                    "var_method": [this, "addEventListener", KeyboardEvent.KEY_DOWN, onKeyDown]
                },
                //end
                {
                    "var_method": [this, "removeEventListener", KeyboardEvent.KEY_DOWN, onKeyDown]
                },
                //result
                {
                    "method": [result]
                },
                //send
                    _toSend,
                //receive
                    receive,
                0

        );*/

    }


    //receive
    private function receive():void {



    }

    //show cartas
    private function result():void {



    }

    private function onChildAdded(e:Event):void {

        if(DisplayObject(e.target).name)
            AlphaSprite.getInstance().addNew(e.target);
    }

    private function onChildRemoved(e:Event):void {

        if(DisplayObject(e.target).name)
            AlphaSprite.getInstance().remove(e.target);
    }

    public function get matchID():int {
        return _matchID;
    }
    
    public function get gameID():String {
        return _gameID;
    }
}




























}
