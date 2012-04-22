package worlds
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Text;
  import net.flashpunk.utils.Input;
  import entities.Fade;
  
  public class TitleScreen extends World
  {
    public var title:Text;
    public var press:Text;
    public var instructions:Text;
    public var titleShadow:Text;
    public var pressShadow:Text;
    public var instructionsShadow:Text;
    
    public var fading:Boolean = false;
    public var fade:Fade;
    public var bg:Image = new Image(Game.MENU_BG);
    
    public function TitleScreen()
    {
      addGraphic(bg);
      
      titleShadow = new Text("Rock 'n' Slash", 1, 1, { size: 24, color: 0x111111 });
      titleShadow.x = -titleShadow.textWidth / 2 + 1;
      addGraphic(titleShadow, 0, FP.width / 2, 25);
      
      pressShadow = new Text("Press Z to start", 1, 1, { size: 8, color: 0x111111 });
      pressShadow.x = -pressShadow.textWidth / 2 + 1;
      addGraphic(pressShadow, 0, FP.width / 2, 35 + titleShadow.textHeight);
      
      instructionsShadow = new Text("Instructions:\nTwo hits by an enemy and you're dead.\nKill enemies to increase your score.\n\nLeft/right arrows: Movement\nZ: Jump\nX: Shoot\nC: Melee Attack\nM: Toggle music", 1, 1, { size: 8, align: "center", color: 0x111111 });
      instructionsShadow.x = -instructionsShadow.textWidth / 2 + 1;
      addGraphic(instructionsShadow, 0, FP.width / 2, FP.height - instructionsShadow.textHeight - 20);
      
      title = new Text("Rock 'n' Slash", 0, 0, { size: 24 });
      title.x = -title.textWidth / 2;
      addGraphic(title, 0, FP.width / 2, 25);
      
      press = new Text("Press Z to start", 0, 0, { size: 8 });
      press.x = -press.textWidth / 2;
      addGraphic(press, 0, FP.width / 2, 35 + title.textHeight);
      
      instructions = new Text("Instructions:\nTwo hits by an enemy and you're dead.\nKill enemies to increase your score.\n\nLeft/right arrows: Movement\nZ: Jump\nX: Shoot\nC: Melee Attack\nM: Toggle music", 0, 0, { size: 8, align: "center" });
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
