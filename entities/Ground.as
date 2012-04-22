package entities
{
  import net.flashpunk.*;
  import net.flashpunk.graphics.Tilemap;
  import net.flashpunk.masks.Grid;
  
  public class Ground extends GameEntity
  {
    [Embed(source = "../assets/images/tiles.png")]
    public static const TILES:Class;
    
    public static const TILE_SIZE:uint = 13;
    public static var id:Ground;
    
    public var map:Tilemap;
    public var grid:Grid;
    
    public function Ground(xml:XML, width:uint, height:uint)
    {
      id = this;
      type = "solid";
      layer = 2;
      setHitbox(Math.ceil(width / TILE_SIZE) * TILE_SIZE, Math.ceil(height / TILE_SIZE) * TILE_SIZE);
      
      map = new Tilemap(TILES, this.width, this.height, TILE_SIZE, TILE_SIZE);
      map.usePositions = true;
      addGraphic(map);
      
      mask = grid = new Grid(this.width, this.height, TILE_SIZE, TILE_SIZE);
      grid.usePositions = true;
      
      for each (var o:Object in xml.ground.tile)
      {
        map.setTile(o.@x, o.@y, o.@id);
        grid.setTile(o.@x, o.@y);
      }
      
      for each (o in xml.ground.rect)
      {
        map.setRect(o.@x, o.@y, o.@w, o.@h, o.@id);
        grid.setRect(o.@x, o.@y, o.@w, o.@h);
      }
    }
  }
}
