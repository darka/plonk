package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class PlayfieldObject extends OptimalArrayObject
	{
		public var position:Vec;
		public var collidable:Boolean;
		public var radius:Number;
		public var sprite:MovieClip;
		
		public const offscreenLimit = 300;

		public function PlayfieldObject(game_:Game, sprite_:MovieClip, position_:Vec)
		{
			super(game_);
			position = position_;
			sprite = sprite_;
			sprite.x = position.x;
			sprite.y = position.y;
			game.addChild(sprite);
		}
		
		public function makeColidable(radius_:Number)
		{
			collidable = true;
			radius = radius_;
		}
		
		public function collidesWith(object:PlayfieldObject):Boolean
		{
			if (collidable && object.collidable)
			{
				if ( Math.sqrt(Math.pow(position.x - object.position.x, 2) + 
				               Math.pow(position.y - object.position.y, 2)) < radius + object.radius )
				{
					return true;
				}
			}
			return false;
		}
		
		public function update()
		{
			sprite.x = position.x;
			sprite.y = position.y;
		}
		
		public function fadeIn()
		{
			Fading.fadeIn(game, sprite, 1.0);
		}
		
		public function fadeOut()
		{
			Fading.fadeOut(game, sprite);
		}
		
		public function isOffscreen():Boolean
		{
			var playfield:Playfield = LevelController(game.gameMode).playfield;
			if (position.x < -offscreenLimit || position.y < -offscreenLimit || 
			    position.x > playfield.width + offscreenLimit|| 
				position.y > playfield.height + offscreenLimit)
			{
				return true;
			}
			return false;
		}
		
		public function unregisterSprite()
		{
			game.removeChild(sprite);
		}
		
		public override function unusedCleanUp()
		{
			unregisterSprite();
		}
		
		public function handlePlayerCollision()
		{
			
		}
		
		public function spawnBubblesAroundMaybe()
		{
			if (Math.random() > 0.9)
			{
				game.getPlayfield().addBubbles(position.copy(), 1, false);
			}
		}

	}
}