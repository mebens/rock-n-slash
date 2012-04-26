package worlds
{
  import flash.utils.Dictionary;
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  import entities.*;
  
  public class Island extends World
  {
    [Embed(source = "../assets/island.oel", mimeType = "application/octet-stream")]
    public static const DATA:Class;
    
    [Embed(source = "../assets/sfx/game-over.mp3")]
    public static const GAME_OVER:Class;
    
    public static const COMBO_INCREASE:Number = 0.2;
    public static const COMBO_MAX:Number = 3;
    public static const COMBO_TIME:Number = 1 - COMBO_INCREASE;
    
    public var width:uint;
    public var height:uint;
    public var paused:Boolean = false;
    public var over:Boolean = false;
    public var listeners:Dictionary = new Dictionary;
    public var fade:Fade;
    public var gameOverSfx:Sfx = new Sfx(GAME_OVER);
    
    // score tracking
    public var score:uint = 0;
    public var combo:Number = 0.9;
    public var comboPoints:uint = 0;
    public var comboKills:uint = 0;
    public var lastKill:Number = 0;
    
    public function Island()
    {
      var xml:XML = FP.getXML(DATA);
      width = xml.width;
      height = xml.height;
      
      add(fade = new Fade);
      add(new PauseDisplay);
      add(new Vignette);
      add(new Background);
      add(new Ground(xml, width, height));
      add(new ScoreDisplay);
      loadObjects(xml);      
      fade.fadeOut();
    }
    
    override public function update():void
    {
      super.update();
      lastKill += FP.elapsed;
      if (comboKills > 0 && lastKill > COMBO_TIME) endCombo();
      
      if (!over && Input.pressed("pause"))
      {
        paused = !paused;
        PauseDisplay.id.visible = !PauseDisplay.id.visible;
        sendMessage("paused");
      }
    }
    
    public function loadObjects(xml:XML):void
    {
      var o:Object;
      add(Player.fromXML(xml.objects.player));
      for each (o in xml.objects.enemySpawner) add(EnemySpawner.fromXML(o));
      for each (o in xml.objects.enemy) add(Enemy.fromXML(o));
      for each (o in xml.objects.barrier) add(EnemyBarrier.fromXML(o));
    }
    
    public function addListener(message:String, callback:Function):void
    {
      for each (var msg:String in message.split(","))
      {
        if (!listeners[msg]) listeners[msg] = new Dictionary;
        listeners[msg][callback] = true;
      }
    }
    
    public function removeListener(message:String, callback:Function):void
    {
      if (!listeners[message]) throw new Error("The message '" + message + "' doesn't exist.");
      delete listeners[message][callback];
    }
    
    public function sendMessage(message:String):void
    {
      if (!listeners[message]) return;
      for (var f:Object in listeners[message]) f();
    }
    
    public function gameOver():void
    {
      paused = true;
      over = true;
      gameOverSfx.play();
      fade.fadeIn(1, fadeComplete);
      sendMessage("gameOver");
      if (comboKills > 0) endCombo();
    }
    
    public function enemyKilled(enemy:Enemy, score:uint):void
    {
      if (combo < COMBO_MAX) combo = Math.round((combo + COMBO_INCREASE) * 10) / 10;
      comboPoints += score;
      comboKills++;
      lastKill = 0;
      add(new ScorePopup(score, enemy));
      ScoreDisplay.id.updateScore(this.score + comboPoints * combo);
      if (comboKills > 1) ScoreDisplay.id.updateCombo(comboPoints, combo);
    }
    
    public function addScore(addition:uint):void
    {
      score += addition;
      ScoreDisplay.id.updateScore(score);
    }
    
    public function endCombo():void
    {
      addScore(comboPoints * combo);
      combo = 1 - COMBO_INCREASE;
      comboPoints = 0;
      comboKills = 0;
      ScoreDisplay.id.endCombo();
    }
    
    public function fadeComplete():void
    {
      FP.world = new ScoreScreen(score);
    }
  }
}
