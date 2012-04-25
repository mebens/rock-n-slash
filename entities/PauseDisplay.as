package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Text;
  
  public class PauseDisplay extends GameEntity
  {
    public static var id:PauseDisplay;
    public var bg:Image;
    public var text:Text;
    public var shadow:Text;
    
    public function PauseDisplay()
    {
      id = this;
      layer = -3;
      visible = false;
      bg = Image.createRect(FP.width, FP.height, 0x000000, 0.4);
      addGraphic(bg);
      
      var options:Object = { size: 24 };
      text = new Text("Paused", 0, 0, options);
      text.x = FP.width / 2 - text.textWidth / 2;
      text.y = FP.height / 2 - text.textHeight / 2;
      addGraphic(shadow = getShadow(text, options));
      addGraphic(text);
    }
  }
}
