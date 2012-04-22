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
      
      var scoreShadow:Text = new Text(String(s), 0, 0, { size: 24, color: 0x111111 });
      scoreShadow.x = FP.width / 2 - scoreShadow.textWidth / 2 + 1;
      scoreShadow.y = FP.height / 2.25 - scoreShadow.textHeight / 2 + 1;
      addGraphic(scoreShadow);
      
      var hsShadow:Text = new Text(s > highscore ? "You beat your old highscore of " + highscore + "!" : "Highscore: " + highscore, 0, 0, { size: 8, color: 0x111111 });
      hsShadow.x = FP.width / 2 - hsShadow.textWidth / 2 + 1;
      hsShadow.y = scoreShadow.y + scoreShadow.textHeight;
      addGraphic(hsShadow);
      
      var instructionsShadow:Text = new Text("Press Z to restart", 0, 0, { size: 8, color: 0x111111 });
      instructionsShadow.x = FP.width / 2 - instructionsShadow.textWidth / 2 + 1;
      instructionsShadow.y = hsShadow.y + 50;
      addGraphic(instructionsShadow);
      
      var score:Text = new Text(String(s), 0, 0, { size: 24 });
      score.x = FP.width / 2 - score.textWidth / 2;
      score.y = FP.height / 2.25 - score.textHeight / 2;
      addGraphic(score);
      
      var hs:Text = new Text(s > highscore ? "You beat your old highscore of " + highscore + "!" : "Highscore: " + highscore, 0, 0, { size: 8 });
      hs.x = FP.width / 2 - hs.textWidth / 2;
      hs.y = score.y + score.textHeight;
      addGraphic(hs);
      
      var instructions:Text = new Text("Press Z to restart", 0, 0, { size: 8 });
      instructions.x = FP.width / 2 - instructions.textWidth / 2;
      instructions.y = hs.y + 50;
      addGraphic(instructions);
      
      add(fade = new Fade);
      fade.fadeOut();
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
