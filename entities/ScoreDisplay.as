package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  
  public class ScoreDisplay extends GameEntity
  {
    public static var id:ScoreDisplay;
    public var text:Text;
    public var shadow:Text;
    
    public function ScoreDisplay()
    {
      id = this;
      layer = -1;
      super(FP.width / 2, 10);
      addGraphic(shadow = new Text("", 1, 1, { color: 0x111111 }));
      addGraphic(text = new Text("", 0, 0));
    }
    
    override public function added():void
    {
      updateScore(gameWorld.score);
    }
    
    public function updateScore(score:uint):void
    {
      text.text = String(score);
      shadow.text = String(score);
      text.x = -text.textWidth / 2;
      shadow.text = String(score);
      shadow.x = -shadow.textWidth / 2 + 1;
    }
  }
}
