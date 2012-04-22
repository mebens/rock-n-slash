package entities
{
  import net.flashpunk.*;
  import worlds.GameWorld;
  
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
    
    public function get gameWorld():GameWorld
    {
      return world as GameWorld;
    }
  }
}
