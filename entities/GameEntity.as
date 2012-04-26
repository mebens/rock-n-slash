package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  import worlds.Island;
  
  public class GameEntity extends Entity
  {
    public function GameEntity(x:int = 0, y:int = 0, graphic:Graphic = null)
    {
      super(x, y, graphic);
    }
    
    public function playSfx(sounds:Array, volume:Number = 1):void
    {
      var sfx:Sfx = FP.choose(sounds) as Sfx;
      sfx.play(volume);
    }
    
    public function get island():Island
    {
      return world as Island;
    }
  }
}
