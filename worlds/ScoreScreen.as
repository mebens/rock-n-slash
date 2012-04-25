package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Data;
  import net.flashpunk.utils.Input;
  import entities.Fade;
  
  public class ScoreScreen extends World
  {
    public var bg:Image = new Image(Game.MENU_BG);
    public var fade:Fade;
    
    public function ScoreScreen(s:uint)
    {
      Data.load();
      var highscore:uint = Data.readUint("highscore");
      
      if (s > highscore)
      {
        Data.writeUint("highscore", s);
        Data.save();
      }
      
      addGraphic(bg);
      add(fade = new Fade);
      fade.fadeOut();
      
      var options:Object = { size: 24 };
      var score:Text = new Text(String(s), 0, 0, options);
      score.x = FP.width / 2 - score.textWidth / 2;
      score.y = FP.height / 2.25 - score.textHeight / 2;
      addGraphic(getShadow(score, options));
      addGraphic(score);
      
      var hs:Text = new Text(s > highscore ? "You beat your old highscore of " + highscore + "!" : "Highscore: " + highscore, 0, 0, options = { size: 8 });
      hs.x = FP.width / 2 - hs.textWidth / 2;
      hs.y = score.y + score.textHeight;
      addGraphic(getShadow(hs, options));
      addGraphic(hs);
      
      var instructions:Text = new Text("Press Z to restart", 0, 0, options = { size: 8 });
      instructions.x = FP.width / 2 - instructions.textWidth / 2;
      instructions.y = hs.y + 50;
      addGraphic(getShadow(instructions, options));
      addGraphic(instructions);
    }
    
    override public function update():void
    {
      super.update();
      if (Input.pressed("jump")) fade.fadeIn(0.25, fadeComplete);
    }
    
    public function fadeComplete():void
    {
      FP.world = new GameWorld;
    }
  }
}
