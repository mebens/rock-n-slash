package
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import worlds.TitleScreen;
  
  public class Game extends Engine
  {
    [Embed(source = "assets/music/music.mp3")]
    public static const MUSIC:Class;
    
    [Embed(source = "assets/images/menu-bg.png")]
    public static const MENU_BG:Class;
    
    public var music:Sfx = new Sfx(MUSIC);
    
    public function Game()
    {
      super(350, 210);
      FP.screen.scale = 2;
      FP.screen.color = 0x111111;
      FP.world = new TitleScreen;
      FP.console.enable();
      music.loop(0.2);
      
      Input.define("left", Key.LEFT);
      Input.define("right", Key.RIGHT);
      Input.define("jump", Key.Z, Key.UP);
      Input.define("shoot", Key.X);
      Input.define("melee", Key.C);
      Input.define("music", Key.M);
      Input.define("pause", Key.ESCAPE, Key.P)
    }
    
    override public function update():void
    {
      super.update();
      
      if (Input.pressed("music"))
      {
        if (music.playing)
        {
          music.stop();
        }
        else
        {
          music.resume();
        }
      }
    }
  }
}
