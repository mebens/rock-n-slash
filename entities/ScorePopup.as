package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Ease;
  
  public class ScorePopup extends GameEntity
  {
    public static const DISTANCE:Number = 10;
    public static const TIME:Number = 1;
    
    public var text:Text;
    public var shadow:Text;
    
    public function ScorePopup(score:uint, enemy:Enemy)
    {
      super(enemy.x + enemy.width / 2, enemy.y);
      layer = -1;
      
      shadow = new Text("+" + score, 0, 0, { size: 8, color: 0x111111 });
      shadow.x = -shadow.textWidth / 2 + 1;
      shadow.y = -shadow.textHeight + 1;
      FP.tween(shadow, { y: shadow.y - DISTANCE, alpha: 0 }, TIME, { ease: Ease.quadOut, complete: tweenComplete, tweener: this });
      addGraphic(shadow);
      
      text = new Text("+" + score, 0, 0, { size: 8 });
      text.x = -text.textWidth / 2;
      text.y = -text.textHeight;
      FP.tween(text, { y: text.y - DISTANCE, alpha: 0 }, TIME, { ease: Ease.quadOut, complete: tweenComplete, tweener: this });
      addGraphic(text);
    }
    
    public function tweenComplete():void
    {
      world.remove(this);
    }
  }
}
