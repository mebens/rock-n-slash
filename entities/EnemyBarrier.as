package entities
{
  public class EnemyBarrier extends GameEntity
  {
    public function EnemyBarrier(x:int, y:int)
    {
      super(x, y);
      setHitbox(5, 12);
      type = "barrier";
    }
  }
}
