package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  
  public class ScoreDisplay extends GameEntity
  {
    public static var id:ScoreDisplay;
    
    public var score:Text;
    public var scoreShadow:Text;
    public var combo:Text;
    public var comboShadow:Text;
    public var comboOn:Boolean = false;
    
    public function ScoreDisplay()
    {
      id = this;
      layer = -1;
      super(FP.width / 2, 10);
      addGraphic(scoreShadow = new Text("", 1, 1, { color: 0x111111 }));
      addGraphic(score = new Text("", 0, 0));
      
      var options:Object = { alpha: 0, size: 8 };
      combo = new Text("", 0, 18, options);
      addGraphic(comboShadow = getShadow(combo, options));
      addGraphic(combo);
    }
    
    override public function added():void
    {
      updateScore(island.score);
    }
    
    public function updateScore(gameScore:uint):void
    {
      score.text = scoreShadow.text = String(gameScore);
      score.x = -score.textWidth / 2;
      scoreShadow.x = -scoreShadow.textWidth / 2 + 1;
    }
    
    public function updateCombo(points:uint, multiplier:Number):void
    {
      if (!comboOn)
      {
        comboOn = true;
        FP.tween(combo, { alpha: 1 }, 0.15, { tweener: this });
        FP.tween(comboShadow, { alpha: 1 }, 0.15, { tweener: this });
      }
      
      combo.text = comboShadow.text = String(points) + " x " + String(multiplier);
      combo.x = -combo.textWidth / 2;
      comboShadow.x = -comboShadow.textWidth / 2 + 1;
    }
    
    public function endCombo():void
    {
      comboOn = false;
      FP.tween(combo, { alpha: 0 }, 0.5, { tweener: this });
      FP.tween(comboShadow, { alpha: 0 }, 0.5, { tweener: this });
    }
  }
}
