package entities
{
  import net.flashpunk.*;
  
  public class EnemyBarrier extends GameEntity
  {
    public static function fromXML(o:Object):EnemyBarrier
    {
      return new EnemyBarrier(o.@x, o.@y, o.@width, o.@height);
    }
    
    public function EnemyBarrier(x:int, y:int, width:uint, height:uint)
    {
      super(x, y);
      setHitbox(width, height);
      type = "barrier";
      FP.log(width, height);
    }
  }
}
