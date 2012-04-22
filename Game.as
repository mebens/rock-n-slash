package
{
  import net.flashpunk.*;
  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import worlds.TitleScreen;
  
  public class Game extends Engine
  {
    public function Game()
    {
      super(350, 210);
      FP.screen.scale = 2;
      FP.screen.color = 0x111111;
      FP.world = new TitleScreen;
      FP.console.enable();
      
      Input.define("left", Key.LEFT);
      Input.define("right", Key.RIGHT);
      Input.define("jump", Key.Z, Key.UP);
      Input.define("shoot", Key.X);
      Input.define("melee", Key.C);
    }
  }
}
