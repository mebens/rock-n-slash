package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Spritemap;
  
  public class Enemy extends GameEntity
  {
    [Embed(source = "../assets/images/enemy.png")]
    public static const IMAGE:Class;
    
    [Embed(source = "../assets/sfx/enemy-death-1.mp3")]
    public static const DEATH_1:Class;
    
    [Embed(source = "../assets/sfx/enemy-death-2.mp3")]
    public static const DEATH_2:Class;
    
    [Embed(source = "../assets/sfx/enemy-death-3.mp3")]
    public static const DEATH_3:Class;
    
    [Embed(source = "../assets/sfx/bullet-hit-1.mp3")]
    public static const BULLET_HIT_1:Class;
    
    [Embed(source = "../assets/sfx/bullet-hit-2.mp3")]
    public static const BULLET_HIT_2:Class;
    
    public static const SPEED:Number = 70;
    public static const GRAVITY:Number = 500;
    
    public var xAxis:int;
    public var velY:Number = 0;
    public var health:int = 2;
    public var dead:Boolean = false;
    
    public var map:Spritemap;
    public var deathSfx1:Sfx = new Sfx(DEATH_1);
    public var deathSfx2:Sfx = new Sfx(DEATH_2);
    public var deathSfx3:Sfx = new Sfx(DEATH_3);
    public var bulletHitSfx1:Sfx = new Sfx(BULLET_HIT_1);
    public var bulletHitSfx2:Sfx = new Sfx(BULLET_HIT_2);
    
    public function Enemy(x:int, y:int, direction:int = 1)
    {
      super(x, y);
      setHitbox(9, 12);
      type = "enemy";
      layer = 1;
      collidable = false;
      xAxis = direction;
      tween = new ColorTween(colorComplete);
      
      graphic = map = new Spritemap(IMAGE, 9, 12);
      map.add("walk", [0, 1, 2, 3, 4], 15);
      map.add("die", [7, 8, 9, 10, 11, 12, 13], 25, false);
      map.add("spawn", [13, 12, 11, 10, 9, 8, 7], 30, false);
      map.play("spawn");
      map.flipped = xAxis == -1;      
    }
    
    override public function update():void
    {
      if (gameWorld.over)
      {
        map.active = false;
        return;
      }

      if (dead)
      {
        if (map.complete) world.remove(this);
        return;
      }
      else if (map.currentAnim == "spawn")
      {
        if (map.complete)
        {
          map.play("walk");
          collidable = true;
        }
        else
        {
          return;
        }
      }
      
      var inAir:Boolean = collide("solid", x, y + 1) == null;
      if (inAir) velY += GRAVITY * FP.elapsed;
      moveBy(xAxis * SPEED * FP.elapsed, velY * FP.elapsed);
      if (y > gameWorld.height) die(false, false);
      
      if (collide("barrier", x, y))
      {
        xAxis = -xAxis;
        map.flipped = xAxis == -1;
      }
      
      var bullet:Bullet = collide("bullet", x, y) as Bullet;
      
      if (bullet)
      {
        bullet.die();
        
        if (--health <= 0)
        {
          die();
        }
        else
        {
          playSfx([bulletHitSfx1, bulletHitSfx2]);
          tween.tween(0.15, 0xFFFFFF, 0xFF0000);
        }
      }
    }
    
    override public function moveCollideX(e:Entity):Boolean
    {
      xAxis = -xAxis;
      return true;
    }
    
    override public function moveCollideY(e:Entity):Boolean
    {
      velY = 0;
      return true;
    }
    
    public function meleeHit():void
    {
      die(true);
    }
    
    public function die(melee:Boolean = false, player:Boolean = true):void
    {
      if (player)
      {
        dead = true;
        collidable = false;
        map.play("die");
        playSfx([deathSfx1, deathSfx2, deathSfx3], 0.4);
        
        var score:uint = 10;
        
        if (melee)
        {
          score += health == 1 ? 2 : 5;
          if (Player.id.inAir) score += 5;
        }
        
        gameWorld.addScore(score, this);
      }
      else
      {
        world.remove(this);
      }
    }
  }
}
