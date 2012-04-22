package entities
{
  import flash.geom.Point;
  import net.flashpunk.*;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.utils.Input;
  
  public class Player extends GameEntity
  {
    [Embed(source = "../assets/images/player.png")]
    public static const IMAGE:Class;
    
    public static const ACCELERATION:Number = 1180;
    public static const FRICTION:Number = .82;
    public static const JUMP_SPEED:Number = -160;
    public static const GRAVITY:Number = 500;
    public static const FLOAT_GRAVITY:Number = 3;
    public static const BULLET_TIME:Number = 0.2;
    public static const MELEE_TIME:Number = 0.3;
    public static var id:Player;
    
    public var vel:Point = new Point;
    public var bulletTimer:Number = 0;
    public var meleeTimer:Number = 0;
    public var inAir:Boolean = false;
    public var map:Spritemap;
    
    public function Player(x:int, y:int)
    {
      id = this;
      super(x, y);
      setHitbox(9, 15);
      graphic = map = new Spritemap(IMAGE, 15, 15);
      map.add("stand", [0], 1);
      map.add("walk", [0, 1, 2, 3, 4], 16);
      map.add("melee", [5, 6, 7, 8], 30, false);
      map.play("stand");
    }
    
    override public function update():void
    {
      if (gameWorld.over)
      {
        map.active = false;
        return;
      }
      
      inAir = collide("solid", x, y + 1) == null;
      
      if (inAir)
      {
        var factor:Number = vel.y < 0 && !Input.check("jump") ? FLOAT_GRAVITY : 1;
        vel.y += GRAVITY * factor * FP.elapsed;
      }
      else if (Input.pressed("jump"))
      {
        inAir = true;
        vel.y = JUMP_SPEED;
        map.play("stand");
      }
      
      // x velocity and applying movement
      var xAxis:int = 0;
      if (Input.check("left")) xAxis--;
      if (Input.check("right")) xAxis++;
      vel.x += ACCELERATION * xAxis * FP.elapsed;
      vel.x *= FRICTION;
      moveBy(vel.x * FP.elapsed, vel.y * FP.elapsed, "solid");
      
      if (vel.x == 0) xAxis = 0;
      if (y > gameWorld.height || collide("enemy", x, y)) die();
      
      if (xAxis != 0)
      {
        map.flipped = xAxis == -1;
        map.x = map.flipped ? -6 : 0;
      }
      
      if (!inAir && (map.currentAnim != "melee" || (map.currentAnim == "melee" && map.complete)))
      {
        if (xAxis == 0)
        {
          map.play("stand");
        }
        else
        {
          map.play("walk");
        }
      }
      
      // melee
      if (meleeTimer > 0)
      {
        meleeTimer -= FP.elapsed;
      }
      else if (Input.pressed("melee"))
      {
        meleeTimer += MELEE_TIME;
        var enemy:Enemy = world.collideRect("enemy", x + (map.flipped ? -15 : width), y, 15, height) as Enemy;
        if (enemy) enemy.meleeHit(); 
        map.play("melee");
      }
      
      // shooting
      if (bulletTimer > 0)
      {
        bulletTimer -= FP.elapsed;
      }
      else if (meleeTimer <= 0 && Input.pressed("shoot"))
      {
        bulletTimer += BULLET_TIME;
        world.add(new Bullet(x + (map.flipped ? 0 : width), y + 9, map.flipped ? -1 : 1));
      }
    }
    
    override public function moveCollideX(e:Entity):Boolean
    {
      vel.x = 0;
      return true;
    }
    
    override public function moveCollideY(e:Entity):Boolean
    {
      vel.y = 0;
      return true;
    }
    
    public function die():void
    {
      gameWorld.gameOver();
    }
  }
}
