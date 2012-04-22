package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  
  public class ScoreDisplay extends GameEntity
  {
    public static var id:ScoreDisplay;
    public var text:Text;
    
    public function ScoreDisplay()
    {
      id = this;
      layer = -1;
      super(FP.width / 2, 10, text = new Text("", 0, 0));
    }
    
    override public function added():void
    {
      updateScore(gameWorld.score);
    }
    
    public function updateScore(score:uint):void
    {
      text.text = String(score);
      text.x = -text.textWidth / 2;
    }
  }
}
