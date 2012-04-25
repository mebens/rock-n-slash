package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  
  public class Vignette extends GameEntity
  {
    [Embed(source = "../assets/images/vignette.png")]
    public static const IMAGE:Class;
    
    public static var id:Vignette;
    public var image:Image = new Image(IMAGE);
    
    public function Vignette()
    {
      id = this;
      graphic = image;
      layer = -2;
    }
  }
}
