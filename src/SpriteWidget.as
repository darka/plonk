package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class SpriteWidget extends Widget
	{
		protected var sprite:DisplayObject;
		
		public function SpriteWidget(game_:Game, sprite_:DisplayObject, position_:Vec) 
		{
			super(game_);
			position = position_;
			sprite = sprite_;
			sprite.x = position.x;
			sprite.y = position.y;
			game.addChild(sprite);
		}
		
		public override function updatePosition(newPosition:Vec)
		{
			sprite.x = newPosition.x;
			sprite.y = newPosition.y;
			position = newPosition;
		}
		
		public override function unregister()
		{
			game.removeChild(sprite);
		}
		
		public function bringToFront()
		{
			game.setChildIndex(sprite, game.numChildren - 1);
		}
		
		public function fadeIn()
		{
			Fading.fadeIn(game, sprite, 1.0);
		}
		
		public function fadeOut()
		{
			Fading.fadeOut(game, sprite);
		}
	}
	
}