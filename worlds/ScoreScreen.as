package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Input;
  import entities.Fade;
  
  public class ScoreScreen extends World
  {
    public var fade:Fade;
    
    public function ScoreScreen(s:uint)
    {
      var score:Text = new Text(String(s), 0, 0, { size: 24 });
      score.x = -score.textWidth / 2;
      score.y = -score.textHeight / 2;
      addGraphic(score, 0, FP.width / 2, FP.height / 2.25);
      
      var instructions:Text = new Text("Press Z to restart", 0, 0, { size: 8 });
      instructions.x = -instructions.textWidth / 2;
      addGraphic(instructions, 0, FP.width / 2, FP.height / 2.25 + score.textHeight - 5);
      
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
