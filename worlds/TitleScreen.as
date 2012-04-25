package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Input;
  import entities.Fade;
  
  public class TitleScreen extends World
  {
    public var fading:Boolean = false;
    public var fade:Fade;
    public var bg:Image = new Image(Game.MENU_BG);
    
    public function TitleScreen()
    {
      addGraphic(bg);
      add(fade = new Fade(true));
      
      var options:Object = { size: 24 };
      var title:Text = new Text("Rock 'n' Slash", 0, 25, { size: 24 });
      title.x = FP.width / 2 - title.textWidth / 2;
      addGraphic(getShadow(title, options));
      addGraphic(title);
      
      var press:Text = new Text("Press Z to start", 0, title.textHeight + 35, options = { size: 8 });
      press.x = FP.width / 2 - press.textWidth / 2;
      addGraphic(getShadow(press, options))
      addGraphic(press);
      
      var instructions:Text = new Text("Instructions:\nTwo hits by an enemy and you're dead.\nKill enemies to increase your score.\n\nLeft/right arrows: Movement\nZ: Jump\nX: Shoot\nC: Melee Attack\nM: Toggle music", 0, 0, options = { size: 8, align: "center" });
      instructions.x = FP.width / 2 - instructions.textWidth / 2;
      instructions.y = FP.height - instructions.textHeight - 20;
      addGraphic(getShadow(instructions, options));
      addGraphic(instructions);
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
