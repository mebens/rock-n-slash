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
    
    public function ScorePopup(score:uint, enemy:Enemy)
    {
      super(enemy.x + enemy.width / 2, enemy.y);
      layer = -1;
      graphic = text = new Text("+" + score, 0, 0, { size: 8 });
      text.x = -text.textWidth / 2;
      text.y = -text.textHeight;
      FP.tween(text, { y: text.y - DISTANCE, alpha: 0 }, TIME, { ease: Ease.quadOut, complete: tweenComplete, tweener: this });
    }
    
    public function tweenComplete():void
    {
      world.remove(this);
    }
  }
}
