package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  
  public class Bullet extends GameEntity
  {
    [Embed(source = "../assets/images/bullet.png")]
    public static const IMAGE:Class;
    
    public static const SPEED:Number = 300;
    public var vel:Number;
    public var image:Image = new Image(IMAGE);
    
    public function Bullet(x:int, y:int, direction:int)
    {
      super(x, y, image);
      setHitbox(image.width, image.height);
      originX = Math.floor(width / 2);
      vel = SPEED * direction;
      type = "bullet";
      layer = 2;
    }
    
    override public function update():void
    {
      x += vel * FP.elapsed;
      if (x < -width || x > island.width + width) world.remove(this);
    }
    
    public function die():void
    {
      world.remove(this);
    }
  }
}
