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
    
    [Embed(source = "../assets/sfx/shoot-1.mp3")]
    public static const SHOOT_1:Class;

    [Embed(source = "../assets/sfx/shoot-2.mp3")]
    public static const SHOOT_2:Class;

    [Embed(source = "../assets/sfx/melee-1.mp3")]
    public static const MELEE_1:Class;
    
    [Embed(source = "../assets/sfx/melee-2.mp3")]
    public static const MELEE_2:Class;
    
    public static const ACCELERATION:Number = 1180;
    public static const FRICTION:Number = .82;
    public static const JUMP_SPEED:Number = -160;
    public static const GRAVITY:Number = 500;
    public static const FLOAT_GRAVITY:Number = 3;
    
    public static const BULLET_TIME:Number = 0.25;
    public static const MELEE_TIME:Number = 0.3;
    public static const FLASH_TIME:Number = 0.1;
    
    public static var id:Player;
    
    public var vel:Point = new Point;
    public var bulletTimer:Number = 0;
    public var meleeTimer:Number = 0;
    public var inAir:Boolean = false;
    
    public var secondChance:Boolean = true;
    public var flashing:Boolean = false;
    public var flashReps:uint = 12;
    public var flashTimer:Number = 0;
    
    public var map:Spritemap;
    public var shootSfx1:Sfx = new Sfx(SHOOT_1);
    public var shootSfx2:Sfx = new Sfx(SHOOT_2);
    public var meleeSfx1:Sfx = new Sfx(MELEE_1);
    public var meleeSfx2:Sfx = new Sfx(MELEE_2);
    
    public static function fromXML(o:Object):Player
    {
      return new Player(o.@x, o.@y);
    }
    
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
    
    // yeah, this function is huge
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
      if (y > gameWorld.height) die();
      
      // second chance flashing
      if (flashing)
      {
        if (flashReps > 0)
        {
          if (flashTimer > 0)
          {
            flashTimer -= FP.elapsed;
          }
          else
          {
            flashReps--;
            flashTimer += FLASH_TIME;
            visible = !visible;
          }
        }
        else
        {
          flashing = false;
          collidable = true;
        }
      }
      else
      {
        // enemy collision
        var enemy:Enemy = collide("enemy", x, y) as Enemy;

        if (enemy)
        {
          if (secondChance)
          {
            secondChance = false;
            flashing = true;
            collidable = false;
            enemy.die(3);
          }
          else
          {
            die();
          }
        }
      }
      
      // spritemap
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
        enemy = world.collideRect("enemy", x + (map.flipped ? -15 : width), y, 15, height) as Enemy;
        if (enemy) enemy.meleeHit(); 
        map.play("melee");
        playSfx([meleeSfx1, meleeSfx2]);
      }
      
      // shooting
      if (bulletTimer > 0)
      {
        bulletTimer -= FP.elapsed;
      }
      else if (meleeTimer <= MELEE_TIME / 2 && Input.pressed("shoot"))
      {
        bulletTimer += BULLET_TIME;
        world.add(new Bullet(x + (map.flipped ? 0 : width), y + 9, map.flipped ? -1 : 1));
        playSfx([shootSfx1, shootSfx2]);
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
