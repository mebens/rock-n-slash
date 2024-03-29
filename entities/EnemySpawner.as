package entities
{
  import net.flashpunk.*;
  
  public class EnemySpawner extends GameEntity
  {
    public var time:Number = 2.5;
    public var timeRange:Number = 0.1;
    public var timer:Number = 1.8;
    
    public var seqReps:uint = 2;
    public var seqRepCounter:uint = seqReps;
    public var seqChance:uint = 10;
    public var seqRunning:Boolean = false;
    
    public var direction:int;
    
    public static function fromXML(o:Object):EnemySpawner
    {
      return new EnemySpawner(o.@x, o.@y, o.@direction);
    }
    
    public function EnemySpawner(x:int, y:int, direction:int = 1)
    {
      super(x, y);
      setHitbox(9, 12);
      type = "spawner";
      this.direction = direction;
      FP.tween(this, { time: 1.5, seqChance: 5 }, 90, { tweener: this });
      FP.alarm(75, increaseSeqReps, Tween.ONESHOT, this);
    }
    
    override public function update():void
    {
      if (island.paused) return;

      if (timer > 0)
      {
        timer -= FP.elapsed;
      }
      else if (!seqRunning)
      {
        if (FP.rand(seqChance) == 0)
        {
          seqRunning = true;
          sequence();
        }
        else
        {
          resetTimer();
          world.add(new Enemy(x, y, direction));
        }
      }
    }
    
    public function sequence():void
    {
      world.add(new Enemy(x, y, direction));
      
      if (--seqRepCounter > 0)
      {
        FP.alarm(0.25, sequence, Tween.ONESHOT, this);
      }
      else
      {
        seqRunning = false;
        seqRepCounter = seqReps;
        resetTimer();
      }
    }
    
    public function resetTimer():void
    {
      timer += time + FP.lerp(-timeRange, timeRange, FP.random);
    }
    
    public function increaseSeqReps():void
    {
      seqReps = 3;
      if (!seqRunning) seqRepCounter = seqReps;
    }
  }
}
