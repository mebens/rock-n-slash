package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  
  public class Background extends GameEntity
  {
    [Embed(source = "../assets/images/bg.png")]
    public static const IMAGE:Class;
    
    public static var id:Background;
    public var image:Image = new Image(IMAGE);
    
    public function Background()
    {
      id = this;
      graphic = image;
      layer = 3;
    }
  }
}
