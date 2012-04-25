package
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Text;
  
  public function getShadow(text:Text, options:Object):Text
  {
    options.color = 0x111111;
    return new Text(text.text, text.x + 1, text.y + 1, options);
  }
}