package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Input;
  import entities.Fade;
  
  public class TitleScreen extends World
  {
    public var title:Text;
    public var press:Text;
    public var instructions:Text;
    public var fading:Boolean = false;
    public var fade:Fade;
    
    public function TitleScreen()
    {
      title = new Text("Lorem Ipsum", 0, 0, { size: 24 });
      title.x = -title.textWidth / 2;
      addGraphic(title, 0, FP.width / 2, 50);
      
      press = new Text("Press Z to start", 0, 0, { size: 8 });
      press.x = -press.textWidth / 2;
      addGraphic(press, 0, FP.width / 2, 60 + title.textHeight);
      
      instructions = new Text("Instructions:\nDo not be hit by enemies; kill them to increase your score.\nPress Z to jump, X to shoot, and C for a melee attack.", 0, 0, { size: 8, align: "center" });
      instructions.x = -instructions.textWidth / 2;
      addGraphic(instructions, 0, FP.width / 2, FP.height - instructions.textHeight - 20);
      
      add(fade = new Fade(true));
    }
    
    override public function update():void
    {
      super.update();
      
      if (!fading && Input.pressed("jump"))
      {
        fading = true;
        fade.fadeIn(0.5, fadeComplete);
      }
    }
    
    public function fadeComplete():void
    {
      FP.world = new GameWorld;
    }
  }
}
