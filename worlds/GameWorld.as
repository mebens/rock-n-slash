package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  import entities.*;
  
  public class GameWorld extends World
  {
    [Embed(source = "../assets/world.oel", mimeType = "application/octet-stream")]
    public static const DATA:Class;
    
    [Embed(source = "../assets/sfx/game-over.mp3")]
    public static const GAME_OVER:Class;
    
    public var width:uint;
    public var height:uint;
    public var score:uint = 0;
    public var paused:Boolean = false;
    public var fade:Fade;
    public var gameOverSfx:Sfx = new Sfx(GAME_OVER);
    
    public function GameWorld()
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
      
      if (Input.pressed("pause"))
      {
        paused = !paused;
        PauseDisplay.id.visible = !PauseDisplay.id.visible;
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
    
    public function gameOver():void
    {
      paused = true;
      gameOverSfx.play();
      fade.fadeIn(1, fadeComplete);
    }
    
    public function addScore(addition:uint, enemy:Enemy = null):void
    {
      score += addition;
      ScoreDisplay.id.updateScore(score);
      if (enemy) add(new ScorePopup(addition, enemy));
    }
    
    public function fadeComplete():void
    {
      FP.world = new ScoreScreen(score);
    }
  }
}
